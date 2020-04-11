Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module ZLocation -Scope CurrentUser
Install-Module PSReadLine -AllowPrerelease -Force