@echo off
powershell -Command "Start-Process -FilePath 'rb.exe' -ArgumentList '-init build -l' -Verb RunAs"
