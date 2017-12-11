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

## nginx proxy example

```
server {
    listen {PORT};
    server_name {SERVER_NAME};

    location / {
        proxy_set_header      	X-Real-IP $remote_addr;
        proxy_set_header      	X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header      	X-Forwarded-Proto https;
        proxy_set_header      	X-Forwarded-Port 443;
        proxy_set_header      	Host $host;
        proxy_set_header 	 	Upgrade $http_upgrade;
        proxy_set_header 		Connection "upgrade";
        
        proxy_http_version 	1.1;
    
        proxy_pass            	http://localhost:{PORT}/BIMserver/;
    }

}
```