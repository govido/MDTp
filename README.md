# MDTp Microsoft Deployment Toolkit PORTABLE

What it does:

Tools to use with MDT, SQL and WDS servers with installed ADK.
This version is currently tested with Windows 10 2004!

MDTp contains Tools for different workflows for creating and deploying images to client-pcs:

1. Export DHCP-leases and reservations from a Windows-Server to MDTp as CSV-File.
    - With this file you are able to add the PCs to the SQL database with MAC and correct hostname for installation
    
2. Import exisiting CSV-Files with MAC, hostname and inventory no. to make deploying new hardware fast and easy
    - Edit the files with CSV-Buddy, or edit them directly on the fly with a filter
    - Option to export current import-selection as CSV-file (special PC list, extra room lists etc.)

3. Aks for PC details (name and inventory no.), if not found in database

4. Add or refresh SQL database entry if install is triggered from Lite- or Zerotouch (making self registration possible, every new PC can be installed zerotouch from that point)

5. Extra tasksequence for W10 Audit-Mode, making it easier to edit and update existing WIM-files (no problems with W10Apps either in Audit-Mode)

6. Extra tasksequence for W10 Capture, with the option to add description text to the image file (installed software, updates etc.)
    - Auto import of captured images: MDTp checks every 5 minutes for new captures and imports them with description to the deployment share

7. Special tasksequence (aka MDTp special):
    - Ask for PC name / inventory no. if information is not found in SQL database
    - Check what mainboard model is prensent -> getting the correct drivers from MDTp on install
    - Ability to use custom driver if mainboard detection is not enough (for special PCs with extra GPU, external hardware etc.)
    - SQL import / update that adds MAC, hostname, tasksequenceID etc. to the database (no additional steps needed)
    - PXE deactivator: right before install the MDTp gets info to deactivate PXE for the client-> PXE will be skipped for faster boots
        - if the client has to be reinstalled simply deactivate this and send WoL to reinstall completely remote ZEROtouch!!!
    - Show tasksequence name, drive name and pc name on install -> making wrong selection obvious
    - Show the same info in MDT monitoring
    - Writes logfile with PC-inventory info and installdate
    - Sets UEFI PXE boot as first boot after Windows install (PXE needs to be primary before install)
    
8. Litetouch Zerotouch
    - Use Litetouch to ask for admin password before installation
    - Use Zerotouch to boot directly to tasksequence, no interaction on the PC needed
    
9. DaRT PE
    - Use remote 'RDP' with Windows PE, allowing to monitor or control PCs running Lite / Zerotouch
    - Custom imageconfig to start it early, even before Litetouch login, making 'locked' deployments recoverable
    
10. Staggered deploy
    - Boot all clients into Windows PE first (saving precious network throughput) and starting client install from the admin interface later
    - Option to start all PCs every 5 minutes automatically
    
11. Driver Export / Import
    - Tool to export additionally installed Windows drivers to the MDTp-Server
    - MDTp imports all completed driver imports every 5 minutes and adds them to the deployment share

12. Domain Settings
    - Set your domain settings once: domain join user, domain name, OU, browser homepage, windows 10 key etc.
    - Apply settings to the MDTp tasksequence templates
    - Domain settings in the tasksequence or SQL database allow for customized PC / laptop scenarios
    
13. Database tools
    - Import, edit, delete entries
    - WoL, RDP, DaRT multiple PCs from the interface
    - Create inventory-info from all PC-install CSV-files -> gather all install-infos in 1 easy to read file
    
14. Tasksequence tool
    - Create new tasksequnces from templates that work, faster and less steps than MDT
    - Change only the install.wim from a tasksequence if no further changes are needed
    - Delete old tasksequnces
    - Delete old images
    - Delete old driver-folders
    - Get TS info and show which image will be applied in that TS
    
15. Quick deployment share update
    - Update Litetouch AND Zerotouch images
    - Old startimages will be removed from WDS and new ones will be added automatically
    - Lite- or Zerotouch will be enabled again, depending what was active before
    - Easy switch from Lite- to Zerotouch from the UI
   
16. Prestage Clients
    - On import the hostname and MAC get added to WDS server as prestaged clients
    - Option to deactivate "F12" presses, to boot directly into Win PE
    - Option to "skip PXE" to skip install process
    - This makes remote install and reinstall possible (PXE boot as primary required)
    
Wishlist:

- DHCP server leasetime change (longer to account for holidays etc.)
- Change hostnames in import-dialog -> correct wrong spelled names etc. easier
- WDS PXE for thin-clients -> making one imageserver for install and thin-clients, making tftp obsolete
- PC restart option in UI
- TS without PXE skip (laptops)
- Make SQL queries faster and in parallel
