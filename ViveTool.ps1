Invoke-WebRequest https://github.com/thebookisclosed/ViVe/releases/download/v0.3.4/ViVeTool-v0.3.4-IntelAmd.zip -OutFile ViVeTool.zip
Expand-Archive ViVeTool.zip

Start-Process 'ViVeTool\\ViVeTool.exe' -ArgumentList '/disable /id:47205210' -Wait -NoNewWindow

Remove-Item ViVeTool -Recurse
Remove-Item ViVeTool.zip
