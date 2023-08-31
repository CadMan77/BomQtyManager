#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         UMA (aka CADman77)

 Script Function:
	Autodesk Inventor UI-trick to force inherit custom 'Base Unit' value from the Base Quantity
	(https://forums.autodesk.com/t5/inventor-forum/make-a-part-count-as-0-5/m-p/9314514#M777874)
	
ONLY for English and Russian UIs

#ce ----------------------------------------------------------------------------

#include <Misc.au3>
;~ #include <GuiTab.au3>

Opt ("TrayIconDebug", 1)

If Not _Singleton (@scriptname, 1) = 0 And ProcessExists("inventor.exe") Then

	$WinTtl1 = "[REGEXPTITLE:( Document Settings$|^Процесс моделирования )]" ; !! En-Ru

	WinWait($WinTtl1)
	WinActivate($WinTtl1)
	WinWaitActive($WinTtl1)

#cs
;~  UNRELIABLE (tab content may not refresh):
 	$hTab = ControlGetHandle($WinTtl1, "", "[CLASS:SysTabControl32]")
 	_GUICtrlTab_SetCurSel($hTab, 4) ; zero-based index
#ce

	$TabName = "(Bill of Materials|Спецификация)" ; !! En-Ru
	Do
		ControlCommand($WinTtl1, "", "[CLASS:SysTabControl32]", "TabRight")
;~ 	Until	ControlCommand($WinTtl1, "", "[CLASS:SysTabControl32]", "CurrentTab") = 5 ; BOM tab ; UNRELIABLE (index changes)
;~ 	Until	WinExists($WinTtl1, $TabName) ; ??
	Until StringRegExp(WinGetText("[active]") , $TabName) = 1

	ControlClick($WinTtl1, "", 2795) ; 'Edit Parameters' button

	$WinTtl2 = "[REGEXPTITLE:^(Parameters|Параметры)$]" ; !! En-Ru
	WinWaitActive($WinTtl2)
	WinClose($WinTtl2)

	WinWait($WinTtl1, "OK")
	WinActivate($WinTtl1, "OK")
	WinWaitActive($WinTtl1, "OK")
	ControlClick($WinTtl1, "", "[Text:OK]")

EndIf