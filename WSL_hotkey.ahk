;既にスクリプトが起動している状態で、同じスクリプトを実行した時に、自動で既存のスクリプトを終了する（ダイアログ無効化）
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

PressTime := 0

Shift::
    if ((A_TickCount - PressTime) < 300)  ; 2回目の押下が300ミリ秒以内にあったかを確認
    {
        PressTime := 0
        wslWindow := "ahk_exe wsl.exe"  ; WSLウィンドウを識別するための設定
        if WinExist(wslWindow)  ; WSLウィンドウが存在するかチェック
        {
            if WinActive(wslWindow)  ; ウィンドウがアクティブな場合
            {
                WinMinimize, %wslWindow%  ; アクティブなら最小化する
            }
            else
            {
                WinRestore, %wslWindow%  ; 最小化されていれば元に戻す
                WinActivate, %wslWindow%  ; 最前面に表示
            }
        }
        else
        {
            Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\WSL.lnk"  ; ウィンドウが存在しない場合、WSLを起動する
        }
    }
    else
    {
        PressTime := A_TickCount  ; 最初の押下時間をセット
    }
return