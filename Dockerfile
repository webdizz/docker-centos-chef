FROM webdizz/centos-java8-sshd:latest

MAINTAINER Izzet Mustafaiev "izzet@mustafaiev.com"

# Set correct environment variables.
ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8

RUN	echo "root:123456" | chpasswd

RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN yum -y groupinstall 'Development Tools'; yum clean all
RUN /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc

#SSH support
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN /etc/init.d/sshd start && /etc/init.d/sshd stop

EXPOSE 22

