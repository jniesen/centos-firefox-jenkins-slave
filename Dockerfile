FROM centos:centos6
MAINTAINER Jonathan Niesen <jon.niesen@gmail.com>

# Override from docker run as needed
ENV JENKINS_USER jenkins
ENV JENKINS_USER_PASS jenkins
ENV RUBY_VERSION 2.0.0-p576
ENV RUBYGEM_VERSION 2.0.7

# Install dependencies
RUN yum update -y
RUN yum install -y git
RUN yum install -y java-1.6.0-openjdk
RUN yum install -y firefox
RUN yum install -y xorg-x11-server-Xvfb
RUN yum install -y Xorg
RUN yum install -y openssh-server
RUN yum install -y which

# Fix D-bus error from Xvfb
RUN dbus-uuidgen > /var/lib/dbus/machine-id

# Copy ruby install scripts
COPY prep_for_ruby_install.sh /tmp/prep_for_ruby_install.sh
COPY install_ruby.sh /tmp/install_ruby.sh
COPY install_rubygems.sh /tmp/install_rubygems.sh

# Make scripts executable
RUN chmod +x /tmp/prep_for_ruby_install.sh
RUN chmod +x /tmp/install_ruby.sh
RUN chmod +x /tmp/install_rubygems.sh

# Run ruby install scripts
RUN /tmp/prep_for_ruby_install.sh
RUN /tmp/install_ruby.sh
RUN /tmp/install_rubygems.sh

# Install bundler
RUN gem install bundler --no-ri --no-rdoc

# Create the Jenkins user and set the passowrd
RUN adduser ${JENKINS_USER}
RUN echo "${JENKINS_USER}:${JENKINS_USER_PASS}" | chpasswd

# Add service account keys
RUN mkdir /home/jenkins/.ssh
COPY config /home/jenkins/.ssh/config
COPY id_rsa /home/jenkins/.ssh/id_rsa
COPY id_rsa.pub /home/jenkins/.ssh/id_rsa.pub

# Create server keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

# Needed to connect to master
EXPOSE 22

# Copy start script
COPY start.sh /home/root/start.sh
RUN chmod +x /home/root/start.sh

# Start xvfb, selenium and ssh daemon
CMD ["/home/root/start.sh"]
