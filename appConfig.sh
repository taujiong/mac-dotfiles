echo "[INFO] 打开任意来源app..."
sudo spctl --master-disable

echo "[INFO] 安装oh_my_zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "[INFO] 配置自动语法高亮..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "[INFO] 配置自动补全命令..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "[INFO] 下载powerlevel10k主题..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# 配置文件同步
touch ~/.gitconfig
rm ~/.gitconfig
ln -s ~/.dotfiles/backups/.gitconfig ~/.gitconfig

touch ~/.npmrc
rm ~/.npmrc
ln -h ~/.dotfiles/backups/.npmrc ~/.npmrc

touch ~/.zshrc
rm ~/.zshrc
ln -s ~/.dotfiles/backups/.zshrc ~/.zshrc

mkdir -p ~/.ssh
ln -h ~/.dotfiles/backups/config ~/.ssh/config

mkdir -p ~/.config/powershell/PoshThemes
ln -s ~/.dotfiles/backups/Powerlevel10k.psm1 ~/.config/powershell/PoshThemes/Powerlevel10k.psm1

ln -s ~/.dotfiles/backups/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1

# ssh 私钥配置
ln -h ~/Documents/ssh-configs/deepin ~/.ssh/deepin
ln -h ~/Documents/ssh-configs/tencent ~/.ssh/tencent
chmod 600 ~/.ssh/deepin ~/.ssh/tencent

# Choose default app icons to live in the Dock
defaults write com.apple.dock persistent-apps -array ""
for app in "Microsoft Edge" "Mail" "MWeb" "WeChat" "QQ" "Visual Studio Code" \
  "NeteaseMusic" "System Preferences"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${app}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done
killall "Dock"
