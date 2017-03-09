#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
$sAV = detectAV()
$sEXP = AVexpDate()
$sLastScan = lastScan()
$iLine = 0
$sLine = ''
; Script Start - Add your code below here
func pcasapAVTabGUI()
	$hAVLiscense = GUICtrlCreateInput("", 108, 291, 156, 22)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$hESET = GUICtrlCreateButton("Install ESET", 143, 258, 121, 27)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$AddRemove = GUICtrlCreateButton("Add/Remove Programs", 143, 226, 121, 27)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$hAUTORUN = GUICtrlCreateButton("Autorun AV Script (TRON)", 16, 191, 245, 27)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlCreateInput($sLastScan, 121, 161, 124, 22,$ES_READONLY)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlCreateInput($sEXP, 121, 135, 124, 22,$ES_READONLY)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlCreateInput($sAV, 121, 110, 124, 22,$ES_READONLY)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

	GUICtrlCreateLabel("Current AV Software", 20, 112, 96, 12)
	GUICtrlSetBkColor(-1, 0xFFFFFF)

	GUICtrlCreateLabel("Subscription Status", 23, 139, 96, 12)
	GUICtrlSetBkColor(-1, 0xFFFFFF)

	GUICtrlCreateLabel("Last Scan", 39, 163, 56, 12)
	GUICtrlSetBkColor(-1, 0xFFFFFF)

	$BrowserReset = GUICtrlCreateButton("Reset Browsers", 15, 226, 121, 27)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$SFC = GUICtrlCreateButton("System File Check", 15, 258, 121, 27)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	$Label5 = GUICtrlCreateLabel("ESET Liscense", 22, 296, 80, 12)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Label1 = GUICtrlCreateLabel("Antivirus Functions",18, 80, 250, 23, $SS_CENTER)
	GUICtrlSetFont(-1, 14, 400, 0, "Arial") 	; Load Antivirus Operations Tab
EndFunc

func detectAV()
  if ProcessExists("ekrn.exe") Then
    return "ESET NOD32 Antivirus"
  endif
EndFunc

func AVexpDate()
	local $iLine, $sLine
  if $sAV = "ESET NOD32 Antivirus" Then
    $file_to_read = "C:\ProgramData\ESET\ESET NOD32 Antivirus\License\license.lf"
		$handle_read = FileOpen($file_to_read,0)
		while 1
			$iLine += 1
			$sLine = FileReadLine($handle_read)
			if @error = -1 Then ExitLoop

			If StringInStr($sLine,"Expiration Date") Then
        Local $iPosition = StringInStr($sLine,"Expiration Date")

        return StringMid($sLine,783,9)
				ExitLoop
			endif
		WEnd
	endif
EndFunc

func lastScan()

		$Folder = 'C:\ProgramData\ESET\ESET NOD32 Antivirus\Logs\eScan\'
    $avFiles = _FileListToArray($Folder & "\", "*",1)
    If @Error<>0 Then
        Return
        MsgBox($MB_SYSTEMMODAL, "", "ERROR")
    EndIf

    $iNewestTime = 11111111111111; YYYYMMDDhhmmss
    $iNewestIndex = 0; Array index of newest file
		; Find the newest file
    For $p = 1 To $avFiles[0]
        $iFileTime2 = Number(FileGetTime($Folder & "\" & $avFiles[$p], 0, 1))
        If $iFileTime2 > $iNewestTime Then
            $iNewestTime = $iFileTime2
            $iNewestIndex = $p
        EndIf
    Next
    If $iNewestIndex > 0 Then
        $t = FileGetTime($Folder & "\" & $avFiles[$iNewestIndex])
        $iDateRan = $t[1] & "/" & $t[2] & "/" & $t[0] & " "
        return $iDateRan
    Else
        MsgBox(16, "Error", "Failed to find a newest file.")
    EndIf
EndFunc
