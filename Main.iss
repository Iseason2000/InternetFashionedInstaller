;指定是否为64位安装程序
;#define x64Build

;指定是否只能在 Windows 7 SP1 及更新版本的操作系统上安装
;#define Windows7SP1AndNewer

;指定是否要注册相关后缀名
;#define RegisteAssociations

;指定是否为绿色版安装程序（仅释放文件，不写入注册表条目，也不生成卸载程序）
;#define PortableBuild

;是否安装前调用旧版本的卸载程序卸载(如果有的话)
#define UninstallBefore

;指定是否只能安装新版本，而不能用旧版本覆盖新版本
#define OnlyInstallNewVersion 

;是否启用界面圆角
#define EnableRoundRect
;是否启用圆角数值(越大越圆)
#define RoundRectData 20

#ifdef x64Build  ;64位的
  #define MyAppID "{D388FE9E-1F93-BFFA-CC14-AD638CC123BA}"
  #define MyAppName "我的客户端"
  #define MyAppExeName "启动游戏-HMCL-3.3.188.exe"
  #define MyAppMutex MyAppName
#else             ;32位的(推荐)
  #define MyAppID "{2895C600-B509-4A85-BB2F-EB88CBD75974}"
  #define MyAppName "我的客户端"
  #define MyAppExeName "启动游戏-HMCL-3.3.188.exe"
  #define MyAppMutex MyAppName
#endif

;若想开启禁止安装旧版本的功能，此处版本号请注意一定要是
;点分十进制的正整数，除数字和英文半角句点以外不允许出现任何其他字符，
;否则程序无法判断版本的高低。
#define MyAppVersion "1.0.0"                             
#define MyAppPublisher "Iseason"                         
#define MyAppPublisherURL "http://www.iseason.top/"     
#define MyAppSupportURL MyAppPublisherURL           
#define MyAppUpdatesURL MyAppPublisherURL                    
#define MyAppComments "我的客户端"                             
#define MyAppContact MyAppPublisher
#define MyAppSupportPhone ""
#define MyAppReadmeURL "https://www.iseason.top/innosetup/"
#define MyAppLicenseURL "https://www.iseason.top/innosetup/"
#define MyAppCopyrightYear "2021"
#define MyAppCopyright "版权所有 © " + MyAppCopyrightYear + ", " + MyAppPublisher
#define IconFile ".\Setup.ico"

[Setup]
AppId={{#MyAppID}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppSupportURL}
AppUpdatesURL={#MyAppUpdatesURL}
AppComments={#MyAppComments}
AppContact={#MyAppContact}
AppSupportPhone={#MyAppSupportPhone}
AppReadmeFile={#MyAppReadmeURL}
AppCopyright={#MyAppCopyright}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
VersionInfoDescription={#MyAppName} 安装程序 
VersionInfoProductName={#MyAppName}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
OutputDir=.\Output\
SetupIconFile= {#IconFile}
Compression=lzma2/ultra64
InternalCompressLevel=ultra64
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyMemo=yes
DisableReadyPage=yes
TimeStampsInUTC=yes
SetupMutex={{#MyAppID}Installer,Global\{{#MyAppID}Installer
AppMutex={#MyAppMutex}
ShowLanguageDialog=no
AllowCancelDuringInstall=no
#ifdef x64Build
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
;64位版本的默认安装位置
DefaultDirName={userappdata}\{#MyAppName}
#else
ArchitecturesAllowed=x86 x64
;32位版本的默认安装位置
DefaultDirName={userappdata}\{#MyAppName}
#endif
#ifdef Windows7SP1AndNewer
MinVersion=0,6.1.7601
#else
MinVersion=0,6.0.2600
#endif
#ifdef RegisteAssociations
ChangesAssociations=yes
#else
ChangesAssociations=no
#endif
#ifdef PortableBuild
Uninstallable=no
PrivilegesRequired=lowest
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Portable
#else
Uninstallable=yes
PrivilegesRequired=admin
OutputBaseFilename={#MyAppName}_{#MyAppVersion}
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={uninstallexe},0
UninstallFilesDir={app}
#endif

[Languages]
;安装语言为简体中文，还需要其他语言请在此区段添加
Name: "zh_CN"; MessagesFile: ".\lang\ChineseSimplified.isl"

[Files]
;包含项目文件app目录下的全部文件
;Source: ".\app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;包含所有临时资源文件(勿删)
Source: ".\tmp\*"; DestDir: "{tmp}"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
;包含的文件,指定文件
;Source: "E:\mc\我的客户端1.17.1\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

#ifndef PortableBuild
[Dirs]
;创建一个隐藏的系统文件夹存放卸载程序
;Name: "{app}\Uninstaller"; Attribs: hidden system
#endif

;若有写入INI条目的需要，请取消此区段的注释并自行添加相关脚本
;[INI] 
;Filename: "{app}\MyProg.ini"; Section: "InstallSettings"; Key: "InstallPath"; String: "{app}"; Flags: uninsdeleteentry

;若有写入注册表条目的需要，请取消此区段的注释并自行添加相关脚本
;[Registry]
;Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"
;Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\jre-x64\bin"; \
    Check: NeedsAddPath('{app}\jre-x64\bin')

;创建快捷方式
[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename:"{app}\icon.ico"

;安装前删除原目录的内容
;[installDelete]
;Type: filesandordirs; Name:"{app}";

;安装完执行的任务
[Run]
;启动主程序,如不需要请注释
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

#ifdef RegisteAssociations
[UninstallRun]
;卸载时运行反注册程序
Filename: "{app}\{#MyAppExeName}"; Parameters: "--uninstall"; WorkingDir: "{app}"; Flags: waituntilterminated skipifdoesntexist
#endif

#ifndef PortableBuild
[UninstallDelete]
;卸载时删除安装目录下的所有文件及文件夹
;Type: filesandordirs; Name: "{app}"
#endif

[Code]
//引入脚本区段
#include ".\include\Code.iss"

