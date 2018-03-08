FROM centos:7.2.1511

#RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
#    && rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
#    && yum -y install epel-release.noarch


RUN yum -y install \    
    openssh-server \
    vim \
    && yum -y update bash \
    && rm -rf /var/cache/yum/* \
    && yum clean all


# UTC Timezone & Networking
#
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
    && echo "NETWORKING=yes" > /etc/sysconfig/network

COPY init_container.sh /bin/

RUN chmod 755 /bin/init_container.sh \
	&& echo "root:Docker!" | chpasswd 
	
COPY sshd_config /etc/ssh/

EXPOSE 2222	

EXPOSE 8080

CMD ["/bin/init_container.sh"]
