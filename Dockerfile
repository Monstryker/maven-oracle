FROM ubuntu:16.04

LABEL maintainer "Paulo Barreto"

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 281
ENV JAVA_VERSION_BUILD 09
ENV JAVA_PACKAGE       jdk
ENV JAVA_SHA256_SUM    85e8c7da7248c7450fb105567a78841d0973597850776c24a527feb02ef3e586
ENV JAVA_URL_ELEMENT   89d678f2be164786b292527658ca1605

# Maven Version
ENV MAVEN_VERSION 3.6.1
ENV MAVEN_HOME /usr/share/maven

RUN apt update -y && apt install -y curl tar git && \
    curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
  	mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
  	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    rm -f *.tar.gz && \
    apt autoremove -y && \
    apt clean

RUN mkdir -p /opt && \
	curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_URL_ELEMENT}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz" && \
	echo "$JAVA_SHA256_SUM  java.tar.gz" | sha256sum -c - && \
	gunzip -c java.tar.gz | tar -xf - -C /opt && rm -f java.tar.gz && \
	ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
	rm -rf /opt/jdk/*src.zip \
    /opt/jdk/lib/missioncontrol \
    /opt/jdk/lib/visualvm \
    /opt/jdk/lib/*javafx* \
    /opt/jdk/jre/lib/plugin.jar \
    /opt/jdk/jre/lib/ext/jfxrt.jar \
    /opt/jdk/jre/bin/javaws \
    /opt/jdk/jre/lib/javaws.jar \
    /opt/jdk/jre/lib/desktop \
    /opt/jdk/jre/plugin \
    /opt/jdk/jre/lib/deploy* \
    /opt/jdk/jre/lib/*javafx* \
    /opt/jdk/jre/lib/*jfx* \
    /opt/jdk/jre/lib/amd64/libdecora_sse.so \
    /opt/jdk/jre/lib/amd64/libprism_*.so \
    /opt/jdk/jre/lib/amd64/libfxplugins.so \
    /opt/jdk/jre/lib/amd64/libglass.so \
    /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
    /opt/jdk/jre/lib/amd64/libjavafx*.so \
    /opt/jdk/jre/lib/amd64/libjfx*.so && \
    rm -rf /var/cache/apk/*

# Set environment
ENV JAVA_HOME /opt/jdk

ENV PATH ${PATH}:${JAVA_HOME}/bin

CMD ["mvn"]
