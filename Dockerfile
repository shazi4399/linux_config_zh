# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:20.04
# 环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
# 更换源
RUN sed -i 's@http://archive.ubuntu.com/ubuntu/@http://mirrors.aliyun.com/ubuntu/@g' /etc/apt/sources.list

# 安装 SSH 服务 和其他基础工具
RUN apt-get update && \
	apt-get install -y openssh-server \
	git \
	vim \
	tmux \
	sudo \
	wget

# 安装自己的工具配置
WORKDIR /root
RUN git clone https://gitee.com/shazi4399/linux_conf_zh.git && \
	cp ./linux_conf_zh/.vimrc . && \
	cp ./linux_conf_zh/.bashrc . && \
	cp ./linux_conf_zh/.tmux.conf .
		

# 创建用于 SSH 的目录
RUN mkdir /var/run/sshd

# 创建一个存放公钥的目录
RUN mkdir -p /root/.ssh

# 将宿主机的公钥复制到容器内
# 注意：你需要将宿主机的公钥文件放在与 Dockerfile 同一目录下，并确保文件名正确
COPY id_rsa.pub /root/.ssh/authorized_keys

# 设置正确的权限
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# 设置 root 密码（建议修改为更安全的密码）
RUN echo 'root:123456' | chpasswd

# 配置 SSH 以支持密钥登录和密码登录
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# 允许外部连接的 SSH 端口
EXPOSE 22

# 运行 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]

