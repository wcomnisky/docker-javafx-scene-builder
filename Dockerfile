FROM ubuntu:16.04

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/developer && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		software-properties-common && \
	apt-add-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --no-install-recommends \
		freeglut3 \
		gtk2-engines \
		libswt-gtk-3-java \
		libxslt1.1 \
		libxtst6 \
		libxxf86vm1 \
		oracle-java8-installer \
		oracle-java8-set-default \
		wget && \
	rm -rf /var/lib/apt/lists/* && \
	wget http://download.gluonhq.com/scenebuilder/8.3.0/scenebuilder-all-8.3.0-all.jar -O /home/developer/scenebuilder.jar

RUN chown developer: /home/developer/scenebuilder.jar

USER developer
ENV HOME /home/developer

WORKDIR $HOME

RUN pwd && echo "" && ls -la && echo "" && whoami && echo ""
   
CMD ["/usr/bin/java", "-jar", "./scenebuilder.jar"]
