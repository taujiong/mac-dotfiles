echo "[INFO] setting network proxy..."
export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087

sh sysConfig.sh
sh appInstall.sh
sh appConfig.sh
