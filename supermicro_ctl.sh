#!/bin/bash
# 超微服务器IPMI控制脚本
# 作者：muzihuaner
# https://github.com/muzihuaner/SupermicroController
# 用法：./supermicro_ctl.sh <operation> [ip] [user] [pass]

# 默认配置（根据实际情况修改）
DEFAULT_IP="192.168.10.58"
DEFAULT_USER="ADMIN"    # 默认用户名
DEFAULT_PASS="ADMIN"    # 默认密码

# 解析参数
OPERATION=$1
IP=${2:-$DEFAULT_IP}
USER=${3:-$DEFAULT_USER}
PASS=${4:-$DEFAULT_PASS}

# 检查ipmitool是否安装
if ! command -v ipmitool &> /dev/null; then
  echo "错误：未安装 ipmitool，请先安装"
  echo "Ubuntu/Debian安装: sudo apt install ipmitool"
  echo "CentOS/RHEL安装:   sudo yum install ipmitool"
  exit 1
fi

# 执行IPMI命令
case $OPERATION in
  poweron|开机)
    ipmitool -I lanplus -H $IP -U $USER -P $PASS power on
    echo "已发送开机指令"
    ;;
  poweroff|关机)
    ipmitool -I lanplus -H $IP -U $USER -P $PASS power off
    echo "已发送关机指令"
    ;;
  reboot|重启)
    ipmitool -I lanplus -H $IP -U $USER -P $PASS power cycle
    echo "已发送重启指令"
    ;;
  uid|点亮)
    # 点亮UID灯（蓝色常亮）
    ipmitool -I lanplus -H $IP -U $USER -P $PASS chassis identify force
    echo "UID灯已点亮（蓝色常亮）"
    ;;
  uid-off|关闭)
    # 关闭UID灯
    ipmitool -I lanplus -H $IP -U $USER -P $PASS chassis identify 0
    echo "UID灯已关闭"
    ;;
  *)
    echo "用法: $0 <operation> [ip] [user] [pass]"
    echo "支持的操作:"
    echo "  开机/poweron    - 启动服务器"
    echo "  关机/poweroff   - 关闭服务器电源"
    echo "  重启/reboot     - 硬重启服务器"
    echo "  点亮/uid        - 激活蓝色UID灯"
    echo "  关闭/uid-off    - 关闭UID灯"
    echo ""
    echo "示例:"
    echo "  $0 poweron"
    echo "  $0 reboot 192.168.10.58 myadmin mypassword"
    exit 1
    ;;
esac
