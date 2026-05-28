#!/bin/bash
# 考研数学备考工具 - 本地开发服务器
# Usage:
#   bash start.sh           仅本机访问 (127.0.0.1)
#   bash start.sh --share   局域网共享 (iPhone/iPad可访问)

PORT=8080
BIND="127.0.0.1"

if [ "$1" = "--share" ]; then
  BIND="0.0.0.0"
  shift
fi

if [ -n "$1" ]; then
  PORT="$1"
fi

echo "====================================="
echo "  思明南路的路途"
echo "  考研数学三备考工具"
echo "  目标: 厦门大学会计学 405+"
echo "====================================="
echo ""

if [ "$BIND" = "0.0.0.0" ]; then
  LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || echo "未知")
  echo "  电脑访问: http://localhost:${PORT}"
  echo "  手机访问: http://${LOCAL_IP}:${PORT}"
  echo ""
  echo "  iPhone/iPad操作:"
  echo "  1. 确保手机和电脑在同一WiFi"
  echo "  2. Safari打开上面手机访问地址"
  echo "  3. 输入密码解锁"
  echo "  4. 点击底部分享按钮 -> 添加到主屏幕"
  echo ""
else
  echo "  浏览器打开: http://localhost:${PORT}"
  echo "  如需手机访问，用: bash start.sh --share"
  echo ""
fi

echo "  按 Ctrl+C 停止服务器"
echo ""

python3 -c "
from http.server import HTTPServer, SimpleHTTPRequestHandler
server = HTTPServer(('${BIND}', ${PORT}), SimpleHTTPRequestHandler)
print('已绑定 ${BIND}:${PORT}')
server.serve_forever()
"
