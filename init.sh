sleep 5
#每次启动会自动的完成注册
warp-cli --accept-tos register
#。假如各位需要嵌入现有的license，此处自行修改
if [ -z "$WARP_KEY" ]; then 
  warp-cli --accept-tos  set-license $WARP_KEY
fi
if [ -z "$WARP_PORT" ]; then
  warp-cli --accept-tos   set-proxy-port $WARP_PORT
fi
#切换代理模式
warp-cli --accept-tos  set-mode proxy
warp-cli  --accept-tos connect
