echo "========================================================================"
echo " You can now connect to this ShadowSocks server:"
echo ""
echo " port: 666 password: xiaoke  "
echo " timeout: 300  encryption method: aes-256-cfb "
echo ""
echo " Please remember the password!"
echo "========================================================================"

ssserver -c /etc/shadowsocks.json
