echo "[INFO] Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Homebrew library
cat app/taps.txt | while read tap
do
  echo "Installing ${tap}...";
  brew tap ${tap};
done

# cli
cat app/cli.txt | while read forlumn
do
  echo "Installing ${forlumn}...";
  brew install ${forlumn};
done

# GUI app
cat app/casks.txt | while read cask
do
  echo "Installing ${cask}...";
  brew cask install ${cask};
done

# Powershell Plugins
pwsh
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module ZLocation -Scope CurrentUser
Install-Module PSReadLine -AllowPrerelease -Force
