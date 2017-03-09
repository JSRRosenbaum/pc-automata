#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.


#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <MsgBoxConstants.au3>
#include <Date.au3>
#include <array.au3>

Global $sSearchString
Global $SearchFilter

#Region Static GUI

	func pcasapTicketGUI()	; load Ticket Navigation Toolbar
		Global $hUnderlay = GUICtrlCreateGroup("Ticket", -5, 320, 535, 76)
		Global $hTimerLabel = GUICtrlCreateLabel("Ticket Timer", 280, 335, 88, 20)
		GUICtrlSetFont(-1, 12)

		Global $hTimer = GUICtrlCreateInput("object.timer", 375, 340, 136, 48)
		Global $hTimerStatus = GUICtrlCreateLabel("Stopped", 305, 355, 50, 14)
		Global $hPauseTime = GUICtrlCreateLabel("Pause in 60s", 300, 370, 62, 14)

		Global $hCustNumber = GUICtrlCreateInput("Customer #", 105, 335, 92, 25)
		Global $hTicketInfo = GUICtrlCreateInput("Ticket # | Description", 5, 365, 175, 25)
		Global $hCustName = GUICtrlCreateInput("Customer Name", 5, 335, 90, 25)

		Global $hNewTicket = GUICtrlCreateIcon("shell32.dll", -318, 205, 330, 32, 32)
		GUICtrlSetTip(-1, "Create New Ticket")
		GUICtrlSetImage(-1, "Images\Button Add.ico")
	  GUICtrlSetOnEvent(-1,"newTicket")

	  Global $hTicketSearch = GUICtrlCreateIcon("shell32.dll", -318, 240, 330, 32, 32)
		GUICtrlSetTip(-1, "Lookup Info")
	  GUICtrlSetImage(-1, "Images\Button Info.ico")
	  GUICtrlSetOnEvent(-1,"ticketSearch")

	  Global $hTicketOpen = GUICtrlCreateIcon("shell32.dll", -318, 185, 365, 32, 32)
		GUICtrlSetTip(-1, "Open Ticket # / Customer #")
		GUICtrlSetImage(-1, "Images\Button Next.ico")
	  GUICtrlSetOnEvent(-1,"ticketOpen")

	  Global $hTicketClose = GUICtrlCreateIcon("shell32.dll", -318, 222, 365, 32, 32)
		GUICtrlSetTip(-1, "Reset")
		GUICtrlSetImage(-1, "Images\Button Delete.ico")
	  GUICtrlSetOnEvent(-1,"ticketClose")

	  Global $hTimerControl = GUICtrlCreateIcon("shell32.dll", -318, 260, 365, 32, 32)
		GUICtrlSetTip(-1, "Start / Stop Timer")
		GUICtrlSetImage(-1, "Images\Button Last.ico")
	  GUICtrlSetOnEvent(-1,"timerControl")
	EndFunc

	func pcasapReaderGUI()	; Load Log Reader Script
	  ; Create Window to Display Logs and Information
	  Global $hLogReader = GUICtrlCreateGroup("Log Reader", 275, 60, 255, 270)
	  Global $hReaderWindow= GUICtrlCreateEdit("", 290, 85, 230, 240, BitOR($WS_VSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$ES_READONLY))
	  GUICtrlSetColor(-1, 0x00FF00)
	  GUICtrlSetBkColor(-1, 0x000000)

	  ; Create Drop Down Selection for log nav
	  Global $hSelectLog = GUICtrlCreateCombo("Reader Files", 395, 65, 125, 21)
		GUICtrlCreateLabel("Mode", 340, 70, 40, 15)
	EndFunc
#Endregion

;Logger Functionality
#Region Logger
	$sLineBreak = "---------------------------------------------------------------------"
	$sHalfBreak = "-------------------------"
		;Basic Update
		func updateReader($sUpdate)
			if $sUpdate = "break" Then
				GUICtrlSetData($hReaderWindow, $sLineBreak & @CRLF ,1)
			else
				GUICtrlSetData($hReaderWindow, $sUpdate & @CRLF ,1)
			endif
		EndFunc

		;--------------------------------$sdate--------------------------------
		func dateStamp()
			$sDate = StringTrimRight(_Date_Time_SystemTimetoDateTimeStr(_Date_Time_GetSystemTime()),9)
			GUICtrlSetData($hReaderWindow, $sHalfBreak & $sDate & $sHalfBreak & @CRLF ,1)
		EndFunc
#Endregion

#Region Ticket Buttons
  func newTicket()
    MsgBox($MB_SYSTEMMODAL, "", "Pressed 'New Ticket'")
		$sLogEntry = "Pressed 'New Ticket'"
		updateReader($sLogEntry)
  EndFunc

  func ticketOpen()
    MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Open Ticket/Customer'")
		updateReader("Pressed 'Open Ticket/Customer'")
  EndFunc

  func ticketClose()
    MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Close Ticket'")
		updateReader("Pressed 'Close Ticket'")
  EndFunc

  func timerControl()
    MsgBox($MB_SYSTEMMODAL, "", "Pressed 'Start / Stop Timer'")
		updateReader("Pressed 'Start / Stop Timer'")
  EndFunc
#Endregion
#Region Search Functionality
	func ticketSearch()

		$oForm = _IEFormGetObjByName($oIE, 0)
		$oQuery = _IEFormElementGetCollection($oForm, 0)

		if  searchCheck() = false Then
			updateReader("Nothing to Search!")
		else
			_IEFormElementSetValue($oQuery,$sSearchString)
			_IEFormSubmit($oForm, 1)
			updateReader("Search: " & $sSearchString & @CRLF & searchResults())
		endif
	EndFunc

	func searchCheck()
		;Local $Name, $Number, $Description

		if StringInStr (GUICtrlRead($hCustName), "Customer") Then
			$Name = ""
		else
			$Name = GUICtrlRead($hCustName)
		endif

		if StringInStr (GUICtrlRead($hCustNumber), "Customer") Then
			$Number = ""
		else
			$Number = GUICtrlRead($hCustNumber)
		endif

		if StringInStr (GUICtrlRead($hTicketInfo), "Ticket") Then
			$Description = ""
		else
			$Description = GUICtrlRead($hTicketInfo)
		endif
		if $Number = "" And $Description = "" Then
			$SearchFilter = "name"
		endif
		$sSearchString = $Name & " " & $Number & " " & $Description

		if $sSearchString = "  " Then
			return false
		else
			return true
		endif
	EndFunc

	func searchResults()
		$oLinks = _IELinkGetCollection($oIE)

		;_ArrayDelete($oLinks, 0-50)

		$iNumLinks = @extended

		$sTxt = $iNumLinks & " links found" & @CRLF & @CRLF
		if $SearchFilter = "name" Then

			For $oLink In $oLinks
				if StringInStr($oLink.href,"customers") And StringInStr($oLink.innerText,"Customer")<>true  Then
			    $sTxt &= $oLink.innerText & @CRLF & $oLink.href & @CRLF
				endif
			Next
		else
			For $oLink In $oLinks
					$sTxt &= $oLink.innerText & @CRLF
			Next
		endif

		;MsgBox($MB_SYSTEMMODAL, "Link Info", $sTxt)

		return $sTxt
	EndFunc
#EndRegion
