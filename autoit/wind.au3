#include <MsgBoxConstants.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <String.au3>
#include <Array.au3>

Global Const $ST_CLOSE = 0            ;no sdk launch
Global Const $ST_WAIT = 1             ;sdk waiting for trigger
Global Const $ST_LISTEN = 2           ;sdk recognizing
Global $g_state = $ST_CLOSE
Global Const $CYBERON_PROG = "Cyberon_SDK_Demo"
Global Const $CYBERON_CLASS = "[CLASS:CYBERON_SDK_DEMO]"

Main()


Func SetState($EditId, $state, $RegId)
	$g_state = $state
	Select
		Case $g_state = $ST_CLOSE
			_GUICtrlEdit_SetText($EditId, "closed")
			_GUICtrlEdit_SetText($RegId, "")
		Case $g_state = $ST_WAIT
			_GUICtrlEdit_SetText($EditId, "waiting")
			_GUICtrlEdit_SetText($RegId, "")
		Case $g_state = $ST_LISTEN
			_GUICtrlEdit_SetText($EditId, "listening")
	EndSelect
EndFunc


Func StateMachine($idState, $idRecog)
	Local $hWnd, $sText

	Switch $g_state
	Case $ST_CLOSE
		If ProcessExists($CYBERON_PROG & ".exe") Then
			$hWnd = WinGetHandle($CYBERON_CLASS)
			If Not @error Then
				$sText = WinGetText($CYBERON_PROG)
				If StringRegExp($sText, 'Listen') Then
					SetState($idState, $ST_WAIT, $idRecog)
				Else
					SetState($idState, $ST_LISTEN, $idRecog)
				EndIf
			EndIf
		EndIf
	case $ST_WAIT
		If Not ProcessExists($CYBERON_PROG & ".exe") Then
			SetState($idState, $ST_CLOSE, $idRecog)
		Else
			$hWnd = WinGetHandle($CYBERON_CLASS)
			If @error Then
				SetState($idState, $ST_CLOSE, $idRecog)
			Else
				Local $sText = WinGetText($CYBERON_PROG)
				If Not StringRegExp($sText, 'Listen') Then
					SetState($idState, $ST_LISTEN, $idRecog)
				EndIf
			EndIf
		EndIf
	case $ST_LISTEN
		If Not ProcessExists($CYBERON_PROG & ".exe") Then
			SetState($idState, $ST_CLOSE, $idRecog)
		Else
			$hWnd = WinGetHandle("[CLASS:CYBERON_SDK_DEMO]")
			If @error Then
				SetState($idState, $ST_CLOSE, $idRecog)
			Else
				Local $sText = WinGetText($CYBERON_PROG)
				If StringRegExp($sText, 'Listen') Then
					SetState($idState, $ST_WAIT, $idRecog)
				ElseIf StringRegExp($sText, 'Recog Result: ') Then
					Local $recogs = StringSplit($sText, ":")		
					_GUICtrlEdit_SetText($idRecog, $recogs[$recogs[0]])
				EndIf
			EndIf
		EndIf
	EndSwitch
EndFunc


Func Main()
	Local $iGUIWidth = 1000, $iGUIHeight = 360
	Local $idExit_Btn, $iMsg, $idEdit_State, $idEdit_Reg

	;Create window
	GUICreate("Cyberon Demo", $iGUIWidth, $iGUIHeight)
	
	GUISetFont(40, 400, 0, "標楷體")
	GUICtrlCreateLabel("SDK state: ", 110, 40)
	GUICtrlCreateLabel("Recog string: ", 30, 140)
	$idEdit_State = GUICtrlCreateLabel("closed", 420, 40, 400)
	$idEdit_Reg = GUICtrlCreateLabel("", 400, 140, 500, 72)
	$idExit_Btn = GUICtrlCreateButton("Exit", 420, 240, 180, 72)
	;Create an "OK" button

	GUISetState(@SW_SHOW)

	While 1
		$iMsg = GUIGetMsg()
		Select
			;Check if user clicked on the close button
			Case $iMsg = $GUI_EVENT_CLOSE
				GUIDelete()
				Exit
			Case $iMsg = $idExit_Btn
				GUIDelete()
				Exit
			Case Else
				StateMachine($idEdit_State, $idEdit_Reg)
		EndSelect
	WEnd
EndFunc