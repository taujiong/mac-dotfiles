echo "[INFO] setting network proxy..."
export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087

bash sysConfig.sh
bash appInstall.sh
bash appConfig.sh
