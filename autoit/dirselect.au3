#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <File.au3>
#include <Array.au3>


; Script Start - Add your code below here

Global $MY_GIT = "d:\doc\program\git"
; Update the label/edit with directory name and the combo with content of directory
; In    : $dir - "" : to pop a window for user selection
;              otherwise : the given directory to update
;         $ctrlLabelDir : the CTRL ID of label of directory (0 is update ignored)
;	  $ctrlEditDir : the CTRL ID of edit of directory (0 is update ignored)
; NOTE: usually one of Edit and Label exists
;         $ctrlComboDir : the CTRL ID of combo for directory content (0 is update ignored)
; Ret   : "" - not a directory or empty
;       : otherwise - the directory path selected
Func _do_chg_dir($dir, $ctrlLabelDir, $ctrlEditDir, $ctrlComboDir)
	If $dir = "" Then
		$dir = _pickDir($MY_GIT)
	EndIf

	If _isDir($dir) Then
		Local $flist = _FileListToArray($dir)
		Switch $flist[0]	; [0] is the count
			Case 0, 1
				MsgBox(0, "", "Fail to get file list")
			Case Else
				If $ctrlLabelDir Then
					GUICtrlSetData($ctrlLabelDir, $dir)	; refresh directory name
				EndIf
				If $ctrlEditDir Then
					GUICtrlSetData($ctrlEditDir, $dir, "")	; refresh directory name
				EndIf
				If $ctrlComboDir Then
					GUICtrlSetData($ctrlComboDir, "")	; clear bombo
					For $i = 2 To UBound($flist)
						GUICtrlSetData($ctrlComboDir, $flist[$i-1], $flist[1])
					Next
				EndIf
				Return $dir
		EndSwitch
	Else
		MsgBox(0, "", $dir & " is not a directory")
	EndIf
	Return ""
EndFunc


; Check whether given $path present and is a directory
; In    : $path - directory to check with
; Ret   : 0 - not exist or not a directory
;         1 - a directory
Func _isDir($path)
	Local $result = 0
	Local $attr
	If FileExists($path) Then
		$attr = FileGetAttrib($path)
		If @error Then
			; MsgBox(4096, "Error", "Could not obtain the file attributes.")
			Return $result
		EndIf
	EndIf

	; a directory ?
	If StringInStr($attr, "D") Then
		$result = 1
	EndIf
	
	Return $result
EndFunc	;==>_isDir


; Select a directory until confirmed
; In    : $d4Path - default path to start with
; Ret   : full path of directory selected
Func _pickDir($d4Path)
	Local $dir
	If $d4Path = "" Then
		$dir = @WorkingDir
	Else
		$dir = $d4Path
	EndIf
	
	; 1: show create folder button
	; 4: show edit control to type a folder name
	Return	FileSelectFolder("Choose a folder.", "", 5, $dir)
EndFunc   ;==>_pickDir


