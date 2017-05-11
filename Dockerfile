FROM       ubuntu:14.04
MAINTAINER Mysci

RUN apt-get update

RUN apt-get install -y openssh-server wget
RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
RUN wget --no-check-certificate -O /root/.ssh/authorized_keys https://github.com/yu19930123/Dockerfile/raw/master/authorized_keys 
EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 8080
EXPOSE 9080
EXPOSE 9443

CMD    ["/usr/sbin/sshd", "-D"]
