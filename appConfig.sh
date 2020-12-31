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

touch ~/.p10k.zsh
rm ~/.p10k.zsh
ln -s ~/.dotfiles/backups/.p10k.zsh ~/.p10k.zsh

mkdir -p ~/.ssh
ln -h ~/.dotfiles/backups/config ~/.ssh/config

# ssh 私钥配置
ln -h ~/Documents/ssh-configs/id_rsa ~/.ssh/id_rsa
ln -h ~/Documents/ssh-configs/id_rsa.pub ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

# Choose default app icons to live in the Dock
defaults write com.apple.dock persistent-apps -array ""
for app in "Microsoft Edge" "Mail" "MWeb" "WeChat" "QQ" "Visual Studio Code" \
  "NeteaseMusic" "System Preferences"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${app}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done
killall "Dock"
