$username = "dev." + $env:computername
$extensionDir ="C:\Users\" + $username + "\.vscode\extensions"
& 'C:\Program Files\Microsoft VS Code\bin\code' --install-extension yzhang.markdown-all-in-one --force --extensions-dir $extensionDir
& 'C:\Program Files\Microsoft VS Code\bin\code' --install-extension jebbs.plantuml --force --extensions-dir $extensionDir
& 'C:\Program Files\Microsoft VS Code\bin\code' --install-extension mauve.terraform --force --extensions-dir $extensionDir
& 'C:\Program Files\Microsoft VS Code\bin\code' --install-extension ms-vscode.powershell --force --extensions-dir $extensionDir