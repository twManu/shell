#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

; run as main
If "test.au3" = @ScriptName Then
	Local $WinWidth = 400, $WinHight = 200, $borderSize = 32
	; will create a dialog box that when displayed is centered
	Local $hWnd = GUICreate("Test Result", $WinWidth, $WinHight)
	Local $idClear = GUICtrlCreateButton("Clear", 40, $WinHight - $borderSize)
	Local $idMyedit = GUICtrlCreateEdit("", $borderSize, $borderSize, _
		$WinWidth - 2*$borderSize , $WinHight - 2*$borderSize - 10, $ES_AUTOVSCROLL + $WS_VSCROLL)
	GUISetState(@SW_SHOW, $hWnd)
	Send("{END}")

	; will be append dont' forget 3rd parameter
	GUICtrlSetData($idMyedit, "Click button" & Chr(34) & "clear" & Chr(34) & " to clear the context", 1)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idClear
			ControlSetText("", "", $idMyedit, "")
		EndSwitch
	WEnd
	GUIDelete($hWnd)
EndIf

Func TestText($str)
	ControlSetText("Test Result", "", "Edit1", $str)
EndFunc

Func TestClear()
	ControlSetText("Test Result", "", "Edit1", "")
EndFunc
