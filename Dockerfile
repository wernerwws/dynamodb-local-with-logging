FROM amazon/dynamodb-local

USER root

RUN yum install -y zip unzip

RUN curl https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.13.3/log4j-core-2.13.3.jar -o /home/dynamodblocal/DynamoDBLocal_lib/log4j-core-2.13.3.jar
RUN unzip -d /tmp/jar DynamoDBLocal.jar

RUN sed -i 's/sqlite4java.jar/sqlite4java.jar DynamoDBLocal_lib\/log4j-core-2.13.3.jar/g' /tmp/jar/META-INF/MANIFEST.MF
RUN cd /tmp/jar && zip -u /home/dynamodblocal/DynamoDBLocal.jar META-INF/MANIFEST.MF

COPY log4j2.xml /home/dynamodblocal
RUN cd /home/dynamodblocal && zip -u DynamoDBLocal.jar log4j2.xml
