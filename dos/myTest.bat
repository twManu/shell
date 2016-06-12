@echo off
for /R "c:\Users\a000989\Music\ITU-T P.50" %%f in (*.wav) do SttConsole -file "%%f" STT_evaluate >> test50.txt 2>&1
for /R "c:\Users\a000989\Music\ITU-T P.501\Chinese" %%f in (*.wav) do SttConsole -file "%%f" STT_evaluate >> test501.txt 2>&1

pause

