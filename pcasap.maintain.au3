#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
$RUNDLL32 = @SystemDir & "\rundll32.exe"
if (FileExists ("C:\dxdiag.txt") = 0) Then Run(@ComSpec & ' /c ' & "dxdiag" & ' /t',"C:/",@SW_HIDE)

#Region RT Monitoring
	Global $CT = Run("Maintanance\CoreTemp\Core Temp.exe","",@SW_SHOW)
	sleep(2000)
	$DLL = DllOpen("GetCoreTempInfo.dll")

	If $DLL=-1 Then
		MsgBox(0,"VCTemp:Error",'Failed to open "GetCoreTempInfo.dll". VCTemp will now exit.')
		Exit
	EndIf

	$Struct = DllStructCreate("uint[256];uint[128];uint;uint;float[256];float;float;float;float;char[100];BOOLEAN;BYTE")
	$hRamPercent = ""
	$hCPUPercent = ""
	$hCoreTemp = ""

	func loadRT()

		Local $sReturn, $cTempFormat, $iCores, $iCounter
		$Ret=DllCall($DLL, "BOOLEAN", "fnGetCoreTempInfoAlt", "ptr", DllStructGetPtr($Struct))
		If @Error Then Return ".ERROR."
		If $Ret[0]<>1 Then Return ".NODATA."

		$iCores = DllStructGetData($Struct, 3)
		Switch DllStructGetData($Struct, 11)
			Case 1
				$cTempFormat = "F"
			Case 0
				$cTempFormat = "C"
		EndSwitch

		$total=0
		for $iCounter = 1 To $iCores
			$total = $total + DllStructGetData($Struct, 1, $iCounter)
		Next
			$sReturn = Round( $total/$iCores )
		GUICtrlSetData($hCPUPercent," " & $sReturn & "% ")
	EndFunc

	func ramRT()

		Local $aMem = MemGetStats()
		GUICtrlSetData($hRamPercent," " & $aMem[0] & "% ")
	EndFunc

	func tempRT()
		Local $sReturn, $cTempFormat, $iCores, $iCounter

		$Ret=DllCall($DLL, "BOOLEAN", "fnGetCoreTempInfoAlt", "ptr", DllStructGetPtr($Struct))

		If @Error Then Return ".ERROR."
		If $Ret[0]<>1 Then Return ".NODATA."

		$iCores = DllStructGetData($Struct, 3)

		Switch DllStructGetData($Struct, 11)
			Case 1
				$cTempFormat = "F"
			Case 0
				$cTempFormat = "C"
		EndSwitch

	  $total=0
	  for $iCounter = 1 To $iCores
	    $total = $total + DllStructGetData($Struct, 5, $iCounter)
	  Next
	    $sReturn = Round( $total/$iCores )
		GUICtrlSetData($hCoreTemp, " " & $sReturn & $cTempFormat)
	EndFunc
#EndRegion

func pcasapMaintananceTabGUI()
	$Label1 = GUICtrlCreateLabel("System Upkeep / Diagnostics", 18, 77, 250, 23, $SS_CENTER)
	GUICtrlSetFont(-1, 14, 400, 0, "Arial")
	Global $hSysinfo = GUICtrlCreateEdit("", 10, 100, 257, 102,BitOR($WS_VSCROLL,$ES_READONLY))
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	Sysinfo()

	GUICtrlCreateGroup("", 90, 220, 173, 95)
	Local $hIntake = GUICtrlCreateButton("Intake Analysis", 125, 205, 95, 25)
	GUICtrlSetOnEvent(-1,"Intake")
	Local $hBCD = GUICtrlCreateButton("Boot Configuration", 80, 235, 95, 25)
	GUICtrlSetOnEvent(-1,"BootConf")
	Local $hPrograms = GUICtrlCreateButton("Programs", 175, 235, 95, 25)
	GUICtrlSetOnEvent(-1,"AddRemove")
	Local $hDevices = GUICtrlCreateButton("Device Manager", 80, 260, 95, 25)
	GUICtrlSetOnEvent(-1,"DevMan")
	Local $hStress = GUICtrlCreateButton("Stress Test", 175, 260, 95, 25)
	GUICtrlSetOnEvent(-1,"StressTest")
	Local $hVolumes = GUICtrlCreateButton("Drive Health", 80, 285, 95, 25)
	GUICtrlSetOnEvent(-1,"DriveHealth")
	Local $hSpeccy = GUICtrlCreateButton("Speccy", 175, 285, 95, 25)
	GUICtrlSetOnEvent(-1,"Speccy")


	Local $hRealTime = GUICtrlCreateGroup("Real-Time", 10, 210, 70, 95)
	GUICtrlCreateLabel("Temp", 15, 230, 30, 20)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlCreateLabel("CPU", 15, 255, 30, 20)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlCreateLabel("RAM", 15, 280, 30, 20)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

	GUICtrlCreateLabel("", 45, 230, 25, 15)
	GUICtrlSetBkColor(-1, 0x000000)
	$hCoreTemp = GUICtrlCreateLabel("null", 45, 230, 25, 15)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetColor(-1, 0xFFFF00)

	GUICtrlCreateLabel("null", 45, 255, 25, 15)
	GUICtrlSetBkColor(-1, 0x000000)
	$hCPUPercent = GUICtrlCreateLabel("null", 45, 255, 25, 15)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetColor(-1, 0x00FFFF)

	GUICtrlCreateLabel("null", 45, 280, 25, 15)
	GUICtrlSetBkColor(-1, 0x000000)
	$hRamPercent = GUICtrlCreateLabel("null", 45, 280, 25, 15)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetColor(-1, 0x00FF00)
	;Local $hCurrentLog = GUICtrlCreateButton("View Current Log", 175, 240, 100, 40)
	;Local $hSaveLog = GUICtrlCreateButton("Save", 175, 280, 45, 35)
	;Local $hUploadLog = GUICtrlCreateButton("Upload", 220, 280, 55, 35)		; Load Maintanance/General Diags Tab
EndFunc

#Region Maintanance Buttons
	func Speccy()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Speccy'")
		;$sLogEntry = "Pressed 'Speccy'"
		;updateReader($sLogEntry)
		Run("Maintanance\Speccy\Speccy.exe","",@SW_SHOW)
	EndFunc

	func Intake()
		MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Intake'")
		$sLogEntry = "Pressed 'Intake'"
		updateReader($sLogEntry)
	EndFunc

	func BootConf()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Boot Configuration'")
		;$sLogEntry = "Pressed 'Boot Configuration'"
		;updateReader($sLogEntry)
		__Run("msconfig.exe")
	EndFunc

	func AddRemove()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Programs'")
		;$sLogEntry = "Pressed 'Programs'"
		;updateReader($sLogEntry)
		$cpl = 'appwiz.cpl'
		Run($RUNDLL32 & " shell32,Control_RunDLL " & $cpl)
	EndFunc

	func DevMan()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Device Manager")
		;$sLogEntry = "Pressed 'Device Manager'"
		;updateReader($sLogEntry)
		Run(@ComSpec & " /c " & 'devmgmt.msc', "", @SW_HIDE)
	EndFunc

	func DriveHealth()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Drive Health'")
		;$sLogEntry = "Pressed 'Drive Health'"
		;updateReader($sLogEntry)
		Run("Maintanance\CrystalDiskInfoPortable\CrystalDiskInfoPortable.exe","",@SW_SHOW)
	EndFunc

	func StressTest()
		;MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Stress Test'")
		;$sLogEntry = "Pressed 'Stress Test'"
		;updateReader($sLogEntry)
		Run("Maintanance\HeavyLoad\HeavyLoad.exe","",@SW_SHOW)
	EndFunc

	func LogCheck()
	EndFunc

	func LogSave()
	EndFunc

	func LogUpload()
	EndFunc
#Endregion

Func Sysinfo()
	while 1
		if FileExists('C:/dxdiag.txt') Then
			$file_to_read = "C:\dxdiag.txt"
			; open file to read and store the handle
			$handle_read = FileOpen($file_to_read, 0)
			While 1
			    ; read each line from a file
			    $line_read = StringStripWS (FileReadLine($handle_read),1)
			    ; exit the loop if end of file
			    If StringInStr($line_read, "Windows Dir:") Then ExitLoop
			    ; show the line read (just for testing)
			    GUICtrlSetData($hSysinfo, $line_read & @CRLF ,1)
			    ; write each line to a file
			    ;FileWriteLine($handle_write, $line_read)
			WEnd
			ExitLoop
		EndIf
	Wend
EndFunc

Func WhatTab()
	$iIndex = _GUICtrlTab_GetCurSel($hTab)
	$name = _GUICtrlTab_GetItemText($hTab, $iIndex)

	return $Name
EndFunc

Func __Run($s_program, $s_workdir = "", $i_show = @SW_SHOW, $i_opt_flag = 0)

    If @OSArch = "X86" Then
        Return Run($s_program, $s_workdir, $i_show, $i_opt_flag)
    EndIf

    Local $t_int = DllStructCreate("int")
    Local $p_int = DllStructGetPtr($t_int)

    DllCall("kernel32.dll", "int", "Wow64DisableWow64FsRedirection", "ptr", $p_int)
    Local $i_pid = Run($s_program, $s_workdir, $i_show, $i_opt_flag)
    DllCall("kernel32.dll", "int", "Wow64RevertWow64FsRedirection", "ptr", $p_int)

    Return $i_pid
EndFunc
