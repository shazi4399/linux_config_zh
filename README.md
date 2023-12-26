# zh个性化配置：
包含vim、tmux、bash三个软件
.vimrc
.tmux.conf
.bashrc

# 二、Linux镜像文件
1. 以Ubuntu20.04为基础，替换成了国内源，并安装了常用工具。

2. 将vim、tmux、bash的配置文件替配置了自己熟悉的风格

3. 开启了ssh登录和免密登录（需要将远程登录的`~/.ssh/id_rsa.pub`文件放到与dockerfile文件同级目录）

4. 用户名root，密码123456

5. 修改了 SSH 配置文件 /etc/ssh/sshd_config，以允许既通过密钥也通过密码进行登录

## Linux镜像使用方式：
```
# 构建 Docker 镜像
docker build -t my_ssh_server .

# 运行 Docker 容器
docker run -d -p 2222:22 my_ssh_server

```




