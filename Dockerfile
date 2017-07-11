FROM ubuntu:16.04
RUN apt-get update && apt-get install -y default-jre
ADD target/proxy-docker-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080 8081
ENV PORT1=8080 PORT2=8081
ADD run.sh /run.sh
RUN chmod +x ./run.sh
ENTRYPOINT ["/bin/bash","./run.sh"]
