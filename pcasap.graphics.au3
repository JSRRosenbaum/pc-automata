#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
func pcasapGFXTabGUI()
	GUICtrlCreateLabel("Graphics", 106, 80, 80, 26)
	GUICtrlSetFont(-1, 14, 400, 0, "Arial")

	GUICtrlCreateLabel("Graphics Card:", 16, 95, 100, 18)
	$GPU = GUICtrlCreateInput(GPUinfo(), 16, 112, 121, 22,$ES_READONLY)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

	GUICtrlCreateLabel("Benchmarks", 16, 142, 64, 18)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")

	GUICtrlCreateButton("Catzilla", 16, 160, 75, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"Catzilla")

	GUICtrlCreateButton("3DMark", 16, 192, 75, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"3DMark")

	GUICtrlCreateButton("Heaven", 16, 224, 75, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"Heaven")

	GUICtrlCreateButton("Valley", 16, 256, 75, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"Valley")

	GUICtrlCreateLabel("Drivers", 20, 294, 39, 18)

	GUICtrlCreateButton("Intel", 208, 288, 51, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"Intel")

	GUICtrlCreateButton("AMD", 145, 288, 51, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"AMD")

	GUICtrlCreateButton("Nvidia", 76, 288, 59, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"Nvidia")

	GUICtrlCreateButton("FurMark Stress Test", 124, 257, 123, 25)
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetOnEvent(-1,"FurMark")

	GUICtrlCreateLabel("3D Display Window", 136, 184, 98, 18)
	;GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	;$Edit1 = GUICtrlCreateEdit("", 112, 144, 153, 105)
	;GUICtrlSetColor(-1, 0xFFFFFF) ; Load Graphics Troubleshooting/Diag Tab
EndFunc

Func GPUinfo()
		if FileExists('C:/dxdiag.txt') Then
			$file_to_read = "C:\dxdiag.txt"
			; open file to read and store the handle
			$handle_read = FileOpen($file_to_read, 0)
			; read each line from a file
			$line_read = StringMid(StringStripWS (FileReadLine($handle_read,53),3),11)
			; exit the loop if end of file
			return $line_read
			; write each line to a file
			;FileWriteLine($handle_write, $line_read)
		EndIf
EndFunc
Func Catzilla()
	Run("Graphics\Catzilla1.4.exe","",@SW_SHOW)
EndFunc
Func Heaven()
	Run("Graphics\Unigine_Heaven-4.0.exe","",@SW_SHOW)
EndFunc

Func Valley()
	Run("Graphics\Unigine_Valley-1.0.exe","",@SW_SHOW)
EndFunc

Func FurMark()
	Run("Graphics\FurMark\FurMark.exe","",@SW_SHOW)
EndFunc

Func AMD()
	Run("Graphics\radeon-crimson-relive-17.2.1-minimalsetup-170221_web.exe","",@SW_SHOW)
EndFunc

Func Intel()
	Run("Graphics\Intel\Setup.exe","",@SW_SHOW)
EndFunc

Func Nvidia()
	Run("Graphics\GeForce_Experience_v3.4.0.70.exe","",@SW_SHOW)
EndFunc
