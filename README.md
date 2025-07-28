# SupermicroController

这是一个使用 ipmitool 控制超微服务器的脚本，支持开机、关机、重启和点亮UID灯操作

## 使用说明

### 1.下载脚本

```bash
git clone https://github.com/muzihuaner/SupermicroController.git
cd SupermicroController
```

赋予执行权限：

```bash
chmod +x supermicro_ctl.sh
```

### 2.基本用法

```
# 开机
./supermicro_ctl.sh poweron

# 关机
./supermicro_ctl.sh poweroff

# 重启（硬重启）
./supermicro_ctl.sh reboot

# 点亮UID灯
./supermicro_ctl.sh uid

# 关闭UID灯
./supermicro_ctl.sh uid-off
```

### 3.自定义认证信息（如果非默认配置）

```
./supermicro_ctl.sh poweron 192.168.10.58 myadmin new_password
```

## 重要说明

### 1.依赖要求

- 确保本地已安装 ipmitool（脚本会自动检测）
- 服务器需开启IPMI/BMC功能，且网络可达

### 2.默认凭据

- 默认用户名：ADMIN
- 默认密码：ADMIN
  （根据您的BMC设置修改脚本中的 DEFAULT_USER 和 DEFAULT_PASS）

### 3.UID灯特性

- chassis identify force：UID灯蓝色常亮
- chassis identify 0：关闭UID灯
- UID灯物理位置通常在服务器前面板（蓝色LED）

### 4.重启类型

power reset 是硬重启（相当于断电后重新上电），比操作系统级别的重启更彻底。

## 常见问题解决

### 1.连接失败

- 检查IP地址是否正确
- 确认防火墙允许IPMI流量（默认UDP端口623）
- 验证BMC用户名/密码

### 2.权限问题

使用 sudo 执行脚本或当前用户加入 ipmi 用户组。

### 3.操作延迟

电源操作可能需要15-30秒生效，使用 ipmitool power status 可检查当前状态。

> 提示：首次使用建议先测试单条命令（如 ipmitool -H 192.168.10.58 -U ADMIN -P ADMIN power status）验证连通性。
