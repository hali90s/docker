###制作默认开启ssh服务的CentOS7.2镜像
FROM centos:7.2.1511
LABEL version="1.1"\
      maintainer="zjliuwei@126.com"\
      description="this scripts will build a CentOS7.2 container with ssh"
RUN yum -y update \
    && yum -y install openssh-server \
	&& yum clean all \
	&& ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
	&& ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
	&& ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN mkdir -p /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN echo 123456 | passwd --stdin root
EXPOSE 22
CMD ["/run.sh"]
