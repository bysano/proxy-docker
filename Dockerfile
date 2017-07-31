FROM ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir /root/.ssh/
ADD authorized_keys /root/.ssh/authorized_keys
RUN apt-get update && apt-get install -y default-jre
ADD target/proxy-docker-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080 8081 22
ENV PORT1=8080 PORT2=8081
ADD run.sh /run.sh
RUN chmod +x ./run.sh
ENTRYPOINT ["/bin/bash","./run.sh"]
