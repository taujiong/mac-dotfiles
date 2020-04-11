echo "[INFO] Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Homebrew library
cat app/taps.txt | while read tap
do
  echo "Installing ${tap}...";
  brew tap ${tap};
done

# formulaes
cat app/formulaes.txt | while read forlumn
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
pwsh ./app/ps-modules.ps1
