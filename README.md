# Maven Oracle JDK 8 (With Resources)

<p align="center">  
	<img
	  alt="Apache Maven"
	  src="https://maven.apache.org/images/maven-logo-black-on-white.png"
	  width="200"
	/>
</p>

<h2 align="center">Ubuntu-Maven-Oracle-JDK-8</h2>


* Maven 3.6.1
* Java Oracle JDK 1.8_281
* Adictional Resources curl tar git

*Docker Hub:* https://hub.docker.com/r/pcbarreto/maven-oracle

*Image Base Ubuntu `FROM Ubuntu:16.04` (Official Docker Hub Image):*
* DockerHub Repo: https://hub.docker.com/_/ubuntu

*Environments:*

* ENV JAVA_VERSION_MAJOR -> `Master version` Ex: 8, 9, 11
* ENV JAVA_VERSION_MINOR -> `Release Version` Ex: 181, 191, 281
* ENV JAVA_VERSION_BUILD -> `Number of the Build Version` Ex: 8, 13, 25
* ENV JAVA_PACKAGE       -> `jdk`
* ENV JAVA_SHA256_SUM    -> `Available on the Oracle download page of the specific version`
* ENV JAVA_URL_ELEMENT   -> `Element available in the download url of the chosen version`
* ENV MAVEN_VERSION      -> `Available on the Maven download page`

*How to identify that informations on Oracle Web Site: https://www.oracle.com/java/technologies/javase-downloads.html*

* `JAVA_SHA256_SUM:`
	- Find the version you want. Ex `Java SE 8u281`. And click in `JDK Download`
		- After that, find `JDK 8u281 checksum`, and look for the `SHA` of the version that will download
		- *https://www.oracle.com/webfolder/s/digest/8u281checksum.html*

* `JAVA_URL_ELEMENT:`
	- Return to the previous page, click on the version you want, accept the terms to provide the link below and right click on it, then copy the link address. The link will be similar to this https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/8u281-b09/`89d678f2be164786b292527658ca1605`/jdk-8u281-linux-x64.tar.gz.
	- The `JAVA_URL_ELEMENT` will be the hash contained in the link. *89d678f2be164786b292527658ca1605*.

* `JAVA_VERSION_MINOR:`
	- The same link contains the other information that I will highlight: https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/8u`281`-b09/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u281-linux-x64.tar.gz.

* `JAVA_VERSION_BUILD:`
	- https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/8u281-b`09`/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u281-linux-x64.tar.gz.

* `JAVA_VERSION_MAJOR:`
	- This is the base version you want: 6, 7, 8, 9...

* `MAVEN_VERSION:`
	- Go to https://maven.apache.org/download.cgi, and find de version you want: Ex: `3.6.0, 3.6.1, 3.5.4`.

* `JAVA_PACKAGE:`
	- This variable must be kept as `jdk`.

*Additional Resources*

- Git:
  - https://www.git-scm.com/ 
