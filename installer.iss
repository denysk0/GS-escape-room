; Inno Setup script — wraps the Unity Windows build into a single
; installer .exe with a proper uninstaller (Add/Remove Programs entry).
;
; Build locally:   iscc /DSourceDir=path\to\build installer.iss
; In CI it is invoked as: iscc /DSourceDir=build installer.iss
;
; SourceDir must point to the folder containing EscapeRoom.exe + EscapeRoom_Data.

#ifndef SourceDir
  #define SourceDir "build\StandaloneWindows64"
#endif

#define AppName "Escape Room"
#define AppVersion "1.0.0"
#define AppPublisher "Your Team"
#define AppExe "EscapeRoom.exe"

[Setup]
AppId={{E5C0A7B2-1234-4ABC-9DEF-ESCAPEROOM01}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
UninstallDisplayIcon={app}\{#AppExe}
OutputDir=Output
OutputBaseFilename=EscapeRoom-Setup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"

[Files]
; Recursively include the whole build folder
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent

; Uninstaller is generated automatically by Inno Setup — it removes all
; installed files, shortcuts, and the Add/Remove Programs entry.
