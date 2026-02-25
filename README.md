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

## How to update the background image and/or prepare for a new year

* To update the background image, do one of the following:
   +  rename the new image to be the same as the old one and commit/push the new image to GitHub or
   +  edit index.html to change the image name (two places) then commit/push both index.html and the new image to GitHub
*  For a new year, also edit the <title> tag in index.html and commit/push index.html to GitHub

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
*  If new changes fail to load, check Settings -> Pages. Set Build and deployment as follows:
   + Deploy from Branch
   + Branch: main -> /(root)
*  If an Action fails with authentication errors on reading the Google Drive Icon Link Table, it is likely because the GOOGLE_APPLICATION_CREDENTIALS are no longer valid. The new credential can be created in the Google Cloud Console: IAM & Admin -> IAM
   + Go to Settings -> Secrets and variables -> Actions
   + Remove (trash can icon) the old credential then copy/paste the new one into the box provided
   
