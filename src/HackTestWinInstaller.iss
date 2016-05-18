//Hack Windows Installer 
//Copyright (C) 2016 Michael Hex 
//Licensed under the MIT License
//https://github.com/source-foundry/Hack-Test-Win-Installer

//We require InnoSetup 5.5.8
#if VER < EncodeVer(5,5,8)
  #error A more recent version of Inno Setup is required to compile this script (5.5.8 or newer)
#endif

#include <ISPPBuiltins.iss>
#pragma option -v+
#pragma verboselevel 9

//Use BuildID from AppVeyor or 0.0.1 if this is not defined
#define public Version '0.0.1'

#ifdef AppVeyorBuild
#define public Version AppVeyorBuild
#endif 



//This defines in which sub folder of this project the current files are located
#define public HackMonospaced_Sourcefolder 'Hack_v2_020'

//This definies the version of Hack monospaces
#define public HackMonospaced_Version '2.020'



//--------------------------------------------------------------------
//Get the base path of this setup. It is assumed that is located in a folder named "src" and the base path is the folder above it
#define base_path StringChange(SourcePath,'src\','') 
#emit '; ISPP: Base Path ' + base_path

//Name of this setup
#define public AppName 'Test Hack Typeface Windows Installer'

//URL of the project homepage for the FONT 
#define public HackMonospaced_Homepage 'http://sourcefoundry.org/hack/'       

//URL of the installer homepage
#define public Installer_Homepage 'https://github.com/source-foundry/Hack-windows-installer'

//Copyright information 
#define public Copyright 'Copyright © 2016 Michael Hex / Source Foundry'


//Internal names of the services 
#define public FontCacheService 'FontCache'
#define public FontCache30Service 'FontCache3.0.0.0'

//File name of the FontState Log
#define public LogFontDataFilename 'Log-FontData.txt'
#define public LogFontDataFilenameOld 'Log-FontData-old.txt'



//Total number of font entries we have
#define total_fonts 4

//Define font array
#dim public font_source[total_fonts]
#dim public font_file[total_fonts]
#dim public font_name[total_fonts]

//Counter for array
#define cntr 0

//---------------------------------------------------------

#define font_source[cntr] HackMonospaced_Sourcefolder
#define font_file[cntr] 'Hack-Bold.ttf'
#define font_name[cntr] 'Hack Bold'
#define cntr cntr+1

#define font_source[cntr] HackMonospaced_Sourcefolder
#define font_file[cntr] 'Hack-BoldItalic.ttf'
#define font_name[cntr] 'Hack Bold Italic'
#define cntr cntr+1

#define font_source[cntr] HackMonospaced_Sourcefolder
#define font_file[cntr] 'Hack-Regular.ttf'
#define font_name[cntr] 'Hack'    /* Regular is not used by Windows, so we need to remove this from the font name */
#define cntr cntr+1

#define font_source[cntr] HackMonospaced_Sourcefolder
#define font_file[cntr] 'Hack-Italic.ttf'
#define font_name[cntr] 'Hack Italic'
#define cntr cntr+1

//---------------------------------------------------------

//Helper macro to generate a SHA1 hash for a font file
#define public GetSHA1OfFontFile(str fontFolder, str fontFile) \
  GetSHA1OfFile(base_path + 'fonts\' + fontFolder + '\' + fontFile)

;---DEBUG---
;This output ensures that we do not have font_xxx array elements that are empty.
#define public GetFontDataDebugOutput(str source, str fileName, str fontName) \
   source + '\' + fileName + ' - "' + fontName + '"'

;Because the sub expects a string for each item, an error from ISPP about "Actual datatype not declared type" 
;when compiling the setup indicates that total_fonts is set to a wrong value
  
#define public i 0
#sub Sub_DebugFontDataOutput
  //#emit '; ' + GetFontDataDebugOutput(font_source[i], font_file[i], font_name[i]) + ' (' + GetSHA1OfFontFile(font_source[i], font_file[i]) + ')'
#endsub
#for {i = 0; i < DimOf(font_file); i++} Sub_DebugFontDataOutput
#undef i

;---END---



  

[Setup]
AppId=HackWindowsInstaller
SetupMutex=HackWindowsInstaller_SetupMutex 

AppName={#AppName}
AppVersion={#Version}
VersionInfoVersion={#Version}

AppPublisher=Michael Hex / Source Foundry
AppContact=Michael Hex / Source Foundry
AppSupportURL={#Installer_Homepage}
AppComments=Hack font installer
AppCopyright={#Copyright}

;This icon is used for the icon of HackWindowsInstaller.exe itself
;SetupIconFile=img\Hack-installer-icon.ico
;This icon will be displayed in Add/Remove programs and needs to be installed locally
;UninstallDisplayIcon={app}\Hack-installer-icon.ico

;Folder configuration
SourceDir={#base_path}
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
SetupAppTitle={#AppName}
;SetupWindowsTitle is displayed in the setup window itself so better include the version
SetupWindowTitle={#AppName} {#Version}

;Message for the "Read to install" wizard page
  ;NOT USED - "Ready To Install" - below title bar
  ;WizardReady=
;ReadLabel1: "Setup is now ready to begin installing ...."
ReadyLabel1=
;ReadyLabel2b: "Click Install to continue with the installation" 
ReadyLabel2b=Setup is now ready to install the Hack fonts v{#HackMonospaced_Version} on your system.


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





//Save the result of the ISSP 
#expr SaveToFile(AddBackslash(SourcePath) + "HackTestWinInstaller_TEMP_Preprocessed.iss")
