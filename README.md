# CCIEA Infographic

## This repository contains the following

*  Static web page and javascript
*  Base image
*  Folder containing the html for the modal (pop-ups) for the mouseovers and menu links
*  Images used in the modals
*  GitHub actions to generate the modal files from [Draft.icon_link_table.2025-26](https://docs.google.com/spreadsheets/d/1PElkUJ2b0bIbb4q2zHzPYKbacThBg-qVFqzgaNyKa-A/edit?gid=1841299816#gid=1841299816)

## How to update the Icon table 

All updates are done in the Google Drive Infographic Folder for the current year <https://drive.google.com/drive/folders/1hFhjJ0bVipKU1QjopCfqL5goBS-xApjn>

*  Name of the icon in column A **must agree** with the name of the html file in column D
*  The Order column is used to order the items in the side menu
*  Figure names in column F can be anything, but the names in this column **must agree** with the actual figure names in the figure folder
*  The text in column G gets placed in bold above the figure in each modal popup
*  mouseover column H is not currently used

## GitHub Action to Update Modal html files

*  How to start the GitHub action workflow
   +  go to the Actions tab, click on "Generate Modal html files" in the left menu
   +  click on "Run workflow" on the right, and again on the green "Run workflow" button ("Branch main" is the only branch choice)
   +  the action will have a yellow animation until it finishes
   +  after the action finishes (turns green), a new action called "pages-build deployment" starts
   +  after the deployment action ends, the updates to the infographio will be available at <https://cciea-esr.github.io/Infographic-FY2026/>
*  What does the Action do?
   +  Reads the icon_link table on Google Drive
   +  Downloads all figures
   +  Generates the modal html files
   +  Commits the new files to the main branch
   +  The commit triggers the page to be re-built and deployed
 
  ## Troubleshooting

*  The most likey cause of either the Action crashing or the modal files missing text or figures is not following the rules in the "How to update the Icon table" section
