#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
func pcasapDataTabGUI()

  GUICtrlCreateLabel("Data / Storage Operations", 18, 77, 250, 23, $SS_CENTER)
  GUICtrlSetFont(-1, 14, 400, 0, "Arial")

  #Region Drive Information
  	$DriveCombo = GUICtrlCreateCombo("Select Drive", 13, 97, 97, 23, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

    GUICtrlCreateLabel("S.M.A.R.T Status:", 115, 100, 89, 18)
    GUICtrlSetFont(-1, 8, 400, 0, "Arial")
    $Smart = GUICtrlCreateInput("4", 213, 98, 50, 20,$ES_READONLY)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

  	GUICtrlCreateLabel("Drive/Partition ID:", 13, 122, 85, 18)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
    $DriveID = GUICtrlCreateInput("2", 101, 120, 50, 20,$ES_READONLY)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

  	GUICtrlCreateLabel("In Use:", 171, 122, 37, 18)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
    $InUse = GUICtrlCreateInput("3", 213, 120, 50, 20,$ES_READONLY)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

    GUICtrlCreateLabel("Users Folder Size:", 13, 140, 93, 18)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  	$UserSize = GUICtrlCreateInput("1", 101, 142, 50, 20,$ES_READONLY)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

  	GUICtrlCreateLabel("Available:", 163, 142, 51, 18)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  	$AvailableSpace = GUICtrlCreateInput("5", 213, 142, 50, 20,$ES_READONLY)
  	GUICtrlSetFont(-1, 8, 400, 0, "Arial") ; Load HDD/Data Operations Tab
  #EndRegion

  GUICtrlCreateGroup("Destination", 13,175,100,50)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  $SVRBackup = GUICtrlCreateRadio("To Server", 18, 190, 75, 17)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetState(-1, $GUI_CHECKED)
  $EXTBackup = GUICtrlCreateRadio("To Ext Storage", 18, 205, 90, 17)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")

  GUICtrlCreateGroup("Type",115,175,60,50)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  $IMGBackup = GUICtrlCreateRadio("Image", 120, 190, 50, 17)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetState(-1, $GUI_CHECKED)
  $UsersBackup = GUICtrlCreateRadio("Users", 120, 205, 50, 17)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  $BackupStart = GUICtrlCreateButton("Start Backup", 181, 190, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"BackItUp")

  $WinDirStat = GUICtrlCreateButton("WinDirStat", 21, 229, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"WinDirStat")

  $ADM = GUICtrlCreateButton("Acronis Drive Monitor", 101, 229, 155, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"ADM")

  $Defrag = GUICtrlCreateButton("Defrag", 21, 261, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"Defrag")

  $chkdsk = GUICtrlCreateButton("Check Disk", 101, 261, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"CHKDSK")

  $bGrantFilePerm = GUICtrlCreateButton("Permissions", 181, 261, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"PermGrant")

  GUICtrlCreateGroup("Backup Options", 7,160,255,65)

  GUICtrlCreateLabel("Liscenses:", 30, 296, 60, 18)
  GUICtrlSetFont(-1, 10, 400, 0, "Arial")


  $RecoverKeys = GUICtrlCreateButton("Recover Keys", 101, 293, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"RecoverKeys")

  $Produkey = GUICtrlCreateButton("Produkey", 181, 293, 75, 25)
  GUICtrlSetFont(-1, 8, 400, 0, "Arial")
  GUICtrlSetOnEvent(-1,"Produkey")
EndFunc

#Region Data Button Functions
  func BackItUp()
    MsgBox($MB_SYSTEMMODAL, "", "Pressed 'BackupStart'")
    ;$sLogEntry = "Pressed 'Speccy'"
    ;updateReader($sLogEntry)
    ;Run("Maintanance\Speccy\Speccy.exe","",@SW_SHOW)
  EndFunc
  func WinDirStat()
    Run("Data\WinDirStat\WinDirStatPortable.exe","",@SW_SHOW)
  EndFunc
  func ADM()
    Run("Data\ADM_en-US.exe","",@SW_SHOW)
  EndFunc
  func Defrag()
    Run("Data\ausdiskdefragportable.exe","",@SW_SHOW)
  EndFunc
  func CHKDSK()
    Run("Data\chkdsk.exe","",@SW_SHOW)
  EndFunc
  func PermGrant()
    Run("Data\NTFSAccess.exe","",@SW_SHOW)
  EndFunc
  func RecoverKeys()
    Run("Data\RecoverKeys\RecoverKeys.exe","",@SW_SHOW)
  EndFunc
  func Produkey()
    Run("Data\Produkey\Produkey.exe","",@SW_SHOW)
  EndFunc
#End Region
