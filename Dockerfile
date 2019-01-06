FROM openjdk:8-jdk

RUN apt-get update
RUN apt-get install -y maven

RUN apt-get install -y git
RUN apt-get install -y vim

ARG maven
RUN echo $maven
RUN mkdir /root/.m2
RUN echo "$maven" >> /root/.m2/settings.xml

ARG mongo_db_key
ENV MONGODB_KEY=$mongo_db_key

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN chmod +x /wait

COPY . /root/query-executor
WORKDIR /root/query-executor

RUN mvn clean install -DskipTests
RUN chmod +x run.sh

#EXPOSE 1234
#CMD /wait && mvn test && /bin/bash -e run.sh
