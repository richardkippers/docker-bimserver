# Dockerfile to install BIMserver 1.5.92 on Tomcat 8.5.24
# Based on jenca/docker-bimserver

FROM ubuntu:14.04

# Initialise

RUN apt-get update
RUN apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get -y update && apt-get -y install \
	openjdk-8-jdk \
	git \
	ant \
	wget \
	nano
RUN echo "Europe/Amsterdam" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Create Tomcat root directory, set up users and install Tomcat

RUN mkdir /opt/tomcat
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.44/bin/apache-tomcat-8.0.44.tar.gz \
	-O /tmp/apache-tomcat-8.0.44.tar.gz
RUN tar xvf /tmp/apache-tomcat-8.0.44.tar.gz -C /opt/tomcat --strip-components=1
RUN rm -f /tmp/apache-tomcat-8.0.44.tar.gz


# Set permissions for group and user to install BIMserver and edit conf

RUN chgrp -R tomcat /opt/tomcat/conf
RUN chmod g+rwx /opt/tomcat/conf
RUN chmod g+r /opt/tomcat/conf/*
RUN chown -R tomcat /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
RUN chown -R tomcat /opt && chown -R tomcat /opt/tomcat/webapps
RUN chmod a+rwx /opt && chmod a+rwx /opt/tomcat/webapps

# Add BIMserver java web archive

COPY bimserverwar-1.5.92.war /opt/tomcat/webapps/BIMserver.war

# Set environment paths for Tomcat

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
ENV CATALINA_HOME=/opt/tomcat
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

# Add roles and increase file size for webapps to 500Mb

ADD ./web.xml /opt/tomcat/webapps/manager/WEB-INF/web.xml
ADD ./run.sh /opt/run.sh

# Run application

USER tomcat
EXPOSE 8080
ENTRYPOINT ["bash", "/opt/run.sh"]