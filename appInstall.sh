echo "[INFO] Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Homebrew library
cat app/taps.txt | while read tap
do
  echo "Installing ${tap}...";
  brew tap ${tap};
done

# cli
cat app/forlumns.txt | while read forlumn
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

# App Store 
cut -f 1,2 -d " " app/apps.txt | while read appid appname
do
  echo "Installing ${appname}...";
  mas install ${appid};
done

# Python module
cut -f 1 -d "=" app/pylibs.txt | while read module
do
  echo "Installing ${tap}...";
  pip3 install ${module}
done