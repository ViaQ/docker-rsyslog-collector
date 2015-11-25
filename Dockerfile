FROM centos:centos7
MAINTAINER The BitScout Community <community@TBA>

EXPOSE 5141

ENV HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH \
    RSYSLOG_OMAMQP1_CONF=/opt/app-root/etc/omamqp1.conf

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y rsyslog rsyslog-gssapi python-qpid-proton \
    rsyslog-mmjsonparse rsyslog-mmsnmptrapd && \
    yum clean all

ADD rsyslog.conf /etc/rsyslog.conf
ADD rsyslog.d/* /etc/rsyslog.d/
ADD omamqp1.py /opt/app-root/bin/
ADD omamqp1.conf /opt/app-root/etc/
ADD omamqp1.conf /etc/
WORKDIR /var/lib/rsyslog

CMD ["/usr/sbin/rsyslogd", "-d", "-n"]
