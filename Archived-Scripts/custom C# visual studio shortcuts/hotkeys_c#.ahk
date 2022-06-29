:*:if ::
send if (
return

:*:dowhile ::
send {RAW}do `n{`n`t`n}
send {Up 1}
return

:*:while ::
send while (
return

:*:cwline::
send {raw} Console.WriteLine("");
send {left 3}
return

:*:cwrite::
send {raw} Console.Write("");
send {left 3}
return

:*:crline::
send {raw} Console.ReadLine();
send {left 2}
return

:*:crkey::
send {raw} Console.ReadKey();
return

:*:for (vul::
send {raw}for (int i = 0; i < ArrayLength; i++)
send {RAW}`n{`n`t Console.WriteLine(i);`n}
send {Up 1}
Return

:*:foreach (vul::
send {raw}foreach (int item in Array)
send {RAW}`n{`n`t`n}
send {Up 1}
return

:*:) ::
send {RAW})`n{`n`t`n}
send {Up 1}
return


:*:else ::
send {RAW}else`n{`n`t`n}
send {Up 1}
return

+enter:: 
Send {RAW};
send `n
return