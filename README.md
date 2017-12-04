# docker-bimserver

Dockerfile based on [jenca/docker-bimserver](https://github.com/jenca-services/docker-bimserver), runs bimserver 1.5.92 (2017-11-20) on Tomcat 8.5.24.

## Run

```
docker build -t  richardkippers/bimserver .

docker run -d \
	-e TOMCAT_USER=*** \
	-e TOMCAT_PASSWORD=*** \
	-p ***:8080 \
	--name bimserver \
	--restart=always \
	richardkippers/bimserver

```