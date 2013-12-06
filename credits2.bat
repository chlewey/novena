@echo off
for %%a in (0 1) do for %%b in (0 1 2 3 4 5 6 7 8 9) do for %%c in (0 1 2 3 4 5 6 7 8 9) do for %%d in (0 2 4 6 8) do convert creditos-1.png -crop 1920x1080+0+%%a%%b%%c%%d frames\creditos-dia-1-%%a%%b%%c%%d.png
