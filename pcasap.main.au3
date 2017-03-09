#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <WindowsConstants.au3>
#include <WinAPIFiles.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <IE.au3>
#include <GuiTab.au3>
#include "pcasap.shopR.au3"
#include "pcasap.login.au3"
#include "pcasap.maintain.au3"
#include "pcasap.data.au3"
#include "pcasap.av.au3"
#include "pcasap.graphics.au3"

;Application for Automating Repairs, Diagnostics, and Reporting info for such
;By Joseph Rosenbaum

Opt("GUIOnEventMode", 1)
Global $isLoggedin = false
Global $oIE
Global $hGUI
Global $hTab

;if loginWindow() = true Then ;Eval login status, launch gui after success
	$oIE; = _IECreate("https://pcasap.repairshopr.com",1,1,0,0)
	$sUser = "Test"
	pcasapMainGUI()
;endif

func pcasapMainGUI()

	; Create Window and Logo

	$sMOTD = "PCASAP Automation Tool Initialized" & @CRLF & "Signed in as " & $sUser
	_IENavigate($oIE, "pcasap.repairshopr.com",0)
	$hGUI = GUICreate("PCASAP | Tech Support and Repair", 529, 399, -1, -1)
	Local $hLogo = GUICtrlCreatePic("", 5, -10, 520, 65)
	GUICtrlSetImage(-1, "Images\pcasap.logofull.bmp")

	pcasapReaderGUI()		; Load Log Reader Script

	pcasapTicketGUI()		; load Ticket Navigation Toolbar

	pcasapTabGUI()			; Load GUI Tabs

	dateStamp()

	updateReader($sMOTD)

	updateReader("break")
	GUIctrlSetState($hCustName,$GUI_FOCUS)
	GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")

	;GUI Run Loop
		GUISetState(@SW_SHOW)


	While 1
		;$hMsg = GUIGetMsg()
		;Switch $hMsg
			;Case $GUI_EVENT_CLOSE
				;Exit
				;EndSwitch
				While WhatTab() = "Maintanance"
					loadRT()
					ramRT()
					tempRT()
					Sleep(1000)
				WEnd
		Sleep(200)
	WEnd
EndFunc

func pcasapTabGUI() 		; Initialize GUI Tabs
	$hTab = GUICtrlCreateTab(5, 55, 275, 270)
	GUICtrlCreateTabItem("Maintanance")
	pcasapMaintananceTabGUI()
	GUICtrlCreateTabItem("Data")
	pcasapDataTabGUI()
	GUICtrlCreateTabItem("Antivirus")
	pcasapAVTabGUI()
	GUICtrlCreateTabItem("Graphics")
	pcasapGFXTabGUI()
	GUICtrlCreateTabItem("")
EndFunc
