echo "[INFO] 打开任意来源app..."
sudo spctl --master-disable

echo "[INFO] 添加Hammerspoon配置文件..."
git clone https://github.com/TloveYing/hammerspoon-config.git ~/.hammerspoon

echo "[INFO] 安装oh_my_zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "[INFO] 配置自动语法高亮..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "[INFO] 配置自动补全命令..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "[INFO] 下载powerlevel9k主题..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

rm ~/.gitconfig
ln -s ~/.dotfiles/backups/.gitconfig ~/.gitconfig
rm ~/.zshrc
ln -s ~/.dotfiles/backups/.zshrc ~/.zshrc

# Dash
open configs/license.dash-license
open configs/snippets.dash

# Choose default app icons to live in the Dock
defaults write com.apple.dock persistent-apps -array ""
for app in "Safari" "Mail" "Wechat" "QQ" "Visual Studio Code" \
  "Notion" "iTunes" "System Preferences"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${app}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done
killall "Dock"