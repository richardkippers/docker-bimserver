docker stop bimserver
docker rm bimserver

docker rmi richardkippers/bimserver

docker build -t  richardkippers/bimserver .

docker run -d \
	-e TOMCAT_USER=admin \
	-e TOMCAT_PASSWORD=Welkom01 \
	-p 1234:8080 \
	--name bimserver \
	--restart=always \
	richardkippers/bimserver