; #IfWinActive ������������ ahk_class V8TopLevelFrame
#IfWinActive ahk_class V8TopLevelFrame

; #include Clipboard_rus_subs.ahk

getTextFromFile() {
  FileRead, newText, tmp\module.txt
  ClipWait, 1
  Clipboard := newText
  ClipWait, 1
  
  Return %newText%
}

pasteTextFromFile() {
  FileRead, newText, tmp\module.txt
  ClipWait, 1
  Clipboard := newText
  ClipWait, 1
  SendInput +{ins}
}

set_locale_ru() {
	SendMessage, 0x50,, 0x4190419,, A
}

set_locale_en() {
  SendMessage, 0x50,, 0x4090409,, A 
}

putSelectionInFile(fileName=0, flagSaveClipboard = 1) {
	clipboard := 
	set_locale_ru()
	if (flagSaveClipboard = 1)
		SaveClipboard()

	if (fileName = 0) {
		fileName = tmp\module.txt	
	}

	module := fileName
	SendInput, ^{ins}
	ClipWait
	
	FileDelete %module%
	FileAppend, %clipboard%, %module%

	if (flagSaveClipboard = 1)
		RestoreClipboard()
}

putModuleInFile(fileName = 0) {

	if (fileName = 0) {
		module = tmp\module.txt
	} else {
		module = fileName
	}

	FileDelete %module%

	set_locale_ru()

	clipboard := ""
	SendInput, ^+{Home}^{ins}{Right}
	ClipWait
	ClipWait
	FileAppend, %clipboard%, %module%

	clipboard := ""
	SendInput, ^+{End}^{ins}{Left} 
	ClipWait
	ClipWait
	FileAppend, %clipboard%, %module%
	
}

getTextUp() {
	clipboard := 
	SendInput, ^+{Home}^{ins}{Right}
	ClipWait
	FileDelete tmp\module.txt
	FileAppend, %clipboard%, tmp\module.txt
}

getTextDown() {
	clipboard := 
	SendInput, ^+{End}^{ins}{Left} 
	ClipWait
	FileDelete tmp\module.txt
	FileAppend, %clipboard%, tmp\module.txt
}


PutCurrentModuleTextIntoFileFast(fileName, flagSaveClipboard = 1) {
	set_locale_ru()
	if (flagSaveClipboard = 1)
		SaveClipboard()

	module := fileName
	;set_locale_ru()

	;Sleep 30
	SendInput ^{SC01E}^{ins}{Left}
	ClipWait
	
	FileDelete %module%
	FileAppend, %clipboard%, %module%

	if (flagSaveClipboard = 1)
		RestoreClipboard()
}

; ����� ���������� ����� ������ �������� ���������� - ��� ����� ��� ��������� ��������
PutCurrentModuleTextIntoFile(fileName, flagSaveClipboard = 1) {
	set_locale_ru()
	if (flagSaveClipboard = 1)
		SaveClipboard()

	module := fileName
	;set_locale_ru()

	;Sleep 30
	SendInput ^{SC01E} ; CTRL-A
	;Sleep 30
	SendInput, ^{ins}
	;Sleep 30
	ClipWait
	
	FileDelete %module%
	FileAppend, %clipboard%, %module%

	if (flagSaveClipboard = 1)
		RestoreClipboard()
}

PutCurrentModuleTextIntoTempFile() {
	module = tmp\module.1s
	PutCurrentModuleTextIntoFile(module)
}

gClipSavedInner45 :=

SaveClipboard()
{
	global gClipSavedInner45 ;
	gClipSavedInner45 := ClipboardAll
	clipboard =

	ClipWait , 1
}

RestoreClipboard()
{
	global gClipSavedInner45 ;
	Clipboard := gClipSavedInner45
	gClipSavedInner45 =
}