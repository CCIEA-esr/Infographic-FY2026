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

## GitHub Action

*  Use the workflow dispatch on "Generate Modal html files" GitHub Action
*  Reads the icon_link table on Google Drive
*  Downloads all figures
*  Generates the modal html files
*  Commits the new files to the main branch
*  The commit triggers the page to be re-built and deployed
