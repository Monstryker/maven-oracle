FROM alpine:3.5

LABEL maintainer "Paulo Barreto"

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 251
ENV JAVA_VERSION_BUILD 08
ENV JAVA_PACKAGE       jdk
ENV JAVA_SHA256_SUM    777a8d689e863275a647ae52cb30fd90022a3af268f34fc5b9867ce32f1b374e
ENV JAVA_URL_ELEMENT   3d5a2bb8f8d4428bbe94aed7ec7ae784

# Maven Version
ENV MAVEN_VERSION 3.5.4

RUN apk add --update curl git gettext tar && \
    curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
  	mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
  	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.21-r2/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
	apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && \
	mkdir -p /opt && \
	curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_URL_ELEMENT}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
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
