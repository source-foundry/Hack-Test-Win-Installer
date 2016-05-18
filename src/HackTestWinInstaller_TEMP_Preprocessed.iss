; BEGIN ISPPBUILTINS.ISS


; END ISPPBUILTINS.ISS



; BEGIN ISPPBUILTINS.ISS


; END ISPPBUILTINS.ISS









; ISPP: Base Path C:\dev\git\Hack-Test-Win-Installer\




















;---DEBUG---
;This output ensures that we do not have font_xxx array elements that are empty.

;Because the sub expects a string for each item, an error from ISPP about "Actual datatype not declared type" 
;when compiling the setup indicates that total_fonts is set to a wrong value
  

;---END---



  

[Setup]
AppId=HackWindowsInstaller
SetupMutex=HackWindowsInstaller_SetupMutex 

AppName=Test Hack Typeface Windows Installer
AppVersion=1.2.1
VersionInfoVersion=1.2.1

AppPublisher=Michael Hex / Source Foundry
AppContact=Michael Hex / Source Foundry
AppSupportURL=https://github.com/source-foundry/Hack-windows-installer
AppComments=Hack font installer
AppCopyright=Copyright © 2016 Michael Hex / Source Foundry

;This icon is used for the icon of HackWindowsInstaller.exe itself
;SetupIconFile=img\Hack-installer-icon.ico
;This icon will be displayed in Add/Remove programs and needs to be installed locally
;UninstallDisplayIcon={app}\Hack-installer-icon.ico

;Folder configuration
SourceDir=C:\dev\git\Hack-Test-Win-Installer\
OutputDir=out\
OutputBaseFilename=HackTestWinInstaller

;Target folder settings (Ignored anyway, but Inno ensists on it)
DefaultDirName={pf}\Hack Test Win Installer\
DirExistsWarning=no

;Always create a log to aid troubleshooting. The file is created as:  
;C:\Users\<YourUsername>\AppData\Local\Temp\Setup Log Year-Month-Day #XXX.txt
SetupLogging=Yes

;enable 64bit Mode so the files are installed to C:\Program Files in x86 and x64 mode
;ArchitecturesInstallIn64BitMode=x64 

;Only allow the installer to run on Windows 7 and upwards
MinVersion=6.1

;It should be NOT uninstallable
Uninstallable=No 

Compression=lzma2/ultra
SolidCompression=yes

PrivilegesRequired=admin

;Ignore some screens
;DisableWelcomePage=yes
DisableDirPage=yes
DisableProgramGroupPage=yes
AllowCancelDuringInstall=False


[Messages]
;Default Windows/App text
;SetupAppTitle is displayed in the taskbar
SetupAppTitle=Test Hack Typeface Windows Installer
;SetupWindowsTitle is displayed in the setup window itself so better include the version
SetupWindowTitle=Test Hack Typeface Windows Installer 1.2.1

;Message for the "Read to install" wizard page
  ;NOT USED - "Ready To Install" - below title bar
  ;WizardReady=
;ReadLabel1: "Setup is now ready to begin installing ...."
ReadyLabel1=
;ReadyLabel2b: "Click Install to continue with the installation" 
ReadyLabel2b=Setup is now ready to install the Hack fonts v2.020 on your system.


;[Files]
;Copy license files - always copied
;Source: "license*.*"; DestDir: "{app}"; Flags: ignoreversion;

;Copy the icon to the installation folder in order to show it in Add/Remove programs
;Source: "img\Hack-installer-icon.ico"; DestDir: "{app}"; Flags: ignoreversion;

;Install fonts
;#define public i 0
;#sub Sub_FontInstall
;  Source: "fonts\{#font_source[i]}\{#font_file[i]}"; FontInstall: "{#font_name[i]}"; DestDir: "{fonts}"; Check: FontFileInstallationRequired; Flags: ignoreversion restartreplace; 
;#endsub
;#for {i = 0; i < DimOf(font_file); i++} Sub_FontInstall
;#undef i





