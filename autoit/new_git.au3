#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <dirselect.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>


; Script Start - Add your code below here
Local $GIT_INIT = 0
Local $GIT_CLONE = 1

; clone or init git
; In    : $srcDir - the directory where repository presents (to init here)
;         $repo - repository
;         $tgtDir - the target working directory (to clone here)
;         $action - GIT_INIT or GIT_CLONE
Func _do_git($srcDir, $repo, $tgtDir, $action)
	Switch $action
		Case $GIT_INIT
			Local $newDir = $srcDir & "\" & $repo
			If FileExists($newDir) Then
				MsgBox(0, "", $newDir & "exists !!!")
				Return
			EndIf
			ShellExecuteWait("mkdir", $newDir)
			ShellExecuteWait("git", "init --bare ", $newDir)
		Case $GIT_CLONE
			ShellExecuteWait("git", "clone " & $srcDir & "\" & $repo, $tgtDir)
	EndSwitch
EndFunc


Func _main_git()
	Local $srcDir = $MY_GIT, $tgtDir = @WorkingDir
	Local $flist = ""
	Local $width1st = 88	; width of 1st column
	Local $width2nd = 200	; width of directory
	Local $widthWin = 390, $top = 5, $left = 5, $height = 32
	Local $ctrlButtonChgDir, $ctrlButtonTgtDir, $ctrlButtonNew, $ctrlButtonClone, $ctrlButtonExit
	Local $ctrlComboRepo, $ctrlEditRepo, $ctrlEditTgtDir
	; GUI, W, H, L, T
	GUICreate("GIT", $widthWin, 250, 100, 200, -1, $WS_EX_ACCEPTFILES)
	; row 1
	; Combo/Button/Edit/Edit, L, T, W, H
	$ctrlButtonChgDir = GUICtrlCreateButton("Git Directory", $left, $top, $width1st-10)
	$ctrlEditRepo = GUICtrlCreateEdit($srcDir, $left+$width1st+10, $top+2, $width2nd, $height-10, $ES_READONLY)
	
	; row 2
	GUICtrlCreateLabel("Git Repository   : ", $left+8, $top+$height+3, $width1st)
	$ctrlComboRepo = GUICtrlCreateCombo("", $left+$width1st+10, $top+$height, $width2nd)
	
	; row 3
	$ctrlButtonTgtDir = GUICtrlCreateButton("Target Dir", $left, $top+$height*2, $width1st-10)
	$ctrlEditTgtDir = GUICtrlCreateEdit($tgtDir, $left+$width1st+10, $top+$height*2+3, $width2nd, $height-10, $ES_READONLY)
	
	; row 4
	Local $widthAction = ($widthWin-2*$left-2*$left)/3
	$ctrlButtonNew = GUICtrlCreateButton("Git Init", $left, $top*2+$height*3, $widthAction, $height)
	$ctrlButtonClone = GUICtrlCreateButton("Git Clone", $left*2+$widthAction, $top*2+$height*3, $widthAction, $height)
	$ctrlButtonExit = GUICtrlCreateButton("Exit", $left*3+$widthAction*2, $top*2+$height*3, $widthAction, $height)

	_do_chg_dir($srcDir, 0, $ctrlEditRepo, $ctrlComboRepo)
	; GUI MESSAGE LOOP
	GUISetState(@SW_SHOW)
	While 1
		Local $ret, $repo
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
			Case $ctrlButtonExit
				Exit
			Case $ctrlButtonChgDir	;change dir pressed
				$srcDir = _do_chg_dir("", 0, $ctrlEditRepo, $ctrlComboRepo)
			Case $ctrlButtonNew
				$repo = GUICtrlRead($ctrlComboRepo)
				Local $right4 = StringRight($repo, 4)
				If $right4 <> ".git" Then
					$repo = $repo & ".git"
				EndIf
				; ok (0) and cancel (1)
				$ret = MsgBox(1, "", "git init " & $repo & " w/ directory " & $srcDir)
				If $ret = 1 Then	;ok
					_do_git($srcDir, $repo, $tgtDir, $GIT_INIT)
					_do_chg_dir($srcDir, 0, $ctrlEditRepo, $ctrlComboRepo)	;refresh
					GUICtrlSetData($ctrlComboRepo, $repo)			;new inited repo as default
				EndIf
			Case $ctrlButtonClone
				$repo = GUICtrlRead($ctrlComboRepo)
				$ret = MsgBox(1, "", "git clone " & $repo & " to directory " & $tgtDir)
				If $ret = 1 Then	;ok
					_do_git($srcDir, $repo, $tgtDir, $GIT_CLONE)
				EndIf
			Case $ctrlButtonTgtDir
				$tgtDir = _do_chg_dir("", 0, $ctrlEditTgtDir, 0)
		EndSwitch
	WEnd
EndFunc	;==>_main_git

_main_git()