Invoke-WebRequest https://github.com/thebookisclosed/ViVe/releases/download/v0.3.4/ViVeTool-v0.3.4-IntelAmd.zip -OutFile ViVeTool.zip
Expand-Archive ViVeTool.zip

.\ViVeTool\ViVeTool.exe /disable /id:47205210 | Out-Null

Remove-Item ViVeTool* -Recurse
