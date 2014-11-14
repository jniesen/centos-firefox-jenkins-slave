FROM centos:centos6
MAINTAINER Jonathan Niesen <jon.niesen@gmail.com>

# Override from docker run as needed
ENV JENKINS_USER jenkins
ENV JENKINS_USER_PASS jenkins
ENV RUBY_VERSION 2.0.0-p576

# Install dependencies
RUN yum install -y git
RUN yum install -y java-1.7.0-openjdk
RUN yum install -y firefox

# Install Ruby
COPY prep_for_ruby_install.sh /tmp/prep_for_ruby_install.sh
COPY install_ruby.sh /tmp/install_ruby.sh

RUN chmod +x /tmp/prep_for_ruby_install.sh
RUN chmod +x /tmp/install_ruby.sh

RUN /tmp/prep_for_ruby_install.sh
RUN /tmp/install_ruby.sh

# Create the Jenkins user and set the passowrd
RUN adduser ${JENKINS_USER}
RUN echo "${JENKINS_USER}:${JENKINS_USER_PASS}" | chpasswd

# Needed to connect to master
EXPOSE 22

# Start SSH daemon
CMD ["/usr/bin/sshd", "-D"]

