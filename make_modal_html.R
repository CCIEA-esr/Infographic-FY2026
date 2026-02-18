##install.packages(c("googledrive", "googlesheets4", "readr", "stringr", "dplyr"))

library(googledrive)
library(googlesheets4)
library(readr)
library(stringr)
library(dplyr)

# --- Configuration ---
out_dir <- "modals"
link_table_file <- "icon_link.csv"
file_id <- "1PElkUJ2b0bIbb4q2zHzPYKbacThBg-qVFqzgaNyKa-A"
image_folder_id <- "1-77QYFK0qVkHAPplms0gUo0Y7YHXp4tx"

if (!dir.exists(out_dir)) dir.create(out_dir)

# --- Helper Functions ---

# Equivalent to add_links(): wraps URLs in <a> tags
add_links <- function(text) {
  if (is.na(text) || text == "") return("")
  # Regex to find URLs not already inside quotes/tags
  pattern <- "(http[s]?://[^[:space:]\\)\\.\\r\\n]+)"
  str_replace_all(text, pattern, '<a href="\\1" target="_blank">\\1</a>')
}

# --- Data Acquisition ---

# Auth (This will open a browser window the first time)
drive_auth()
gs4_auth(token = drive_token())

# 1. Get list of image files from Drive folder
# PHP used a 1-year filter; we do the same here
one_year_ago <- Sys.Date() - 365
image_files <- drive_ls(as_id(image_folder_id)) %>%
  filter(as.Date(drive_resource[[1]]$modifiedTime) > one_year_ago)

# 2. Read the Google Sheet directly into a data frame
modals_df <- read_sheet(file_id)

# --- Processing ---

# Prepare the link table accumulator
link_table_data <- data.frame()

for (i in 1:nrow(modals_df)) {
  row <- modals_df[i, ]
  
  # Skip if icon ncolumn in empty or contains a question mark
  if (is.na(row$icon)) next
  if (str_detect(row$icon, "\\?")) next
  
  # Prepare variables
  title    <- row$title
  icon     <- row$icon
  section  <- row$section
  order_val <- row$order
  image_nm <- row$figure
  caption  <- add_links(row$caption)
  mouseover <- add_links(row$`summary descriptive text for hover`)
  alt_text <- paste0("Image showing ", title, ": ", row$caption)
  
  # File path for the HTML modal
  modal_path <- file.path(out_dir, paste0(icon, ".html"))
  
  # --- Generate HTML Content ---
  html_content <- paste0(
'<!DOCTYPE HTML>
<html lang="en">
<head>
  <title>', title, '</title>
  <meta charset="utf-8" />
  <script async src="https://www.googletagmanager.com/gtag/js?id=UA-176398491-1"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag(\'js\', new Date());
    gtag(\'config\', \'UA-23806328-1\');
  </script>
  <style>
    .modaltext { font-family: "Open Sans", Helvetica, sans-serif; }
    h3 { font-family: "Open Sans", Helvetica, sans-serif; }
  </style>
</head>
<body>
  <div>
    <h3>', mouseover, '</h3>',
    if (!is.na(image_nm) && image_nm != "") {
      paste0('\n    <img src="', image_nm, '" alt="', alt_text, '" height="100%" width="100%"/>')
    } else { "" },
'   <br>
    <span class="modaltext">', caption, '</span>
  </div>
</body>
</html>')

  # Write HTML file (using Windows-style line endings as per original PHP)
  writeLines(str_replace_all(html_content, "\n", "\r\n"), modal_path)
  
  # --- Handle Image Download ---
  if (!is.na(image_nm) && image_nm != "") {
    img_match <- image_files %>% filter(name == image_nm)
    
    if (nrow(img_match) == 0) {
      message(paste0("Image '", image_nm, "' not in folder"))
    } else {
      message(paste0("Downloading: ", title, " -> ", image_nm))
      drive_download(as_id(img_match$id[1]), 
                     path = file.path(out_dir, image_nm), 
                     overwrite = TRUE)
    }
  }
  
  # Add to our link table data frame
  link_table_data <- rbind(link_table_data, data.frame(
    icon = icon,
    section = as.character(section),
    order = order_val,
    title = as.character(title),
    link = as.character(paste0("modals/", icon, ".html"))
  ))
}
link_table_data
# Write the final CSV link table
readr::write_csv(link_table_data, link_table_file,quote="all")
