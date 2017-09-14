FROM       ubuntu:14.04
MAINTAINER Mysci

RUN apt-get update

RUN apt-get install -y openssh-server wget
RUN /bin/mkdir -p /var/run/sshd
RUN /bin/mkdir -p /root/.ssh/
RUN sed -ri 's/Port 22/Port 8022/g' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
RUN wget --no-check-certificate -O /root/.ssh/authorized_keys https://github.com/yu19930123/Dockerfile/raw/master/authorized_keys 
RUN chmod 700 /root/.ssh/authorized_keys 
EXPOSE 80 443 8022 8080 9080 9443
CMD    ["/usr/sbin/sshd", "-D"]
