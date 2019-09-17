# Calendar Copier in Javascript for Apple Script

A Small script that allows to copy all events anonymized from one calendar to another one. I use this to publish my availability to customers without giving up all information. I know using Exchange would be easier but I don't want to change my whole setup.
The script is in Javascript because AppleScript is a horrible language. Doing it with the Script Editor seemed to be the only way to make it work though. 

## Sync of Changes (kinda)
There is a  sync implemented. Basically the target calendar gets deleted and rewritten for a defined timespan. You can define the timespan by changing the enddate. What I did was to set the timespan to a full year at first and now I'm calling the script everyday with a 90 days "sync". Thats just to save time because the Calendar UI is  unresponsive while running the script. 

The Calendar app needs to be active to allow changes, I put a command at the beginning of the script to launch the app but depending on your computer speed it may not be enough. Personally, I just never quit the thing. Sometimes, the changes don't show up directly in the UI. Just restart the app.

