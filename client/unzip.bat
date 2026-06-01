@echo off
title "Updating is in progress, please do not close this window"
powershell -command "Expand-Archive -Path 'uw_seediffusion.zip' -DestinationPath '.' -Force"
del uw_seediffusion.zip
start "" uw.exe
exit
