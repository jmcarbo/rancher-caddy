build:
	docker build -t jmcarbo/rancher-caddy .

run:
	docker run -ti -e HOSTS="isawesome;blu.bla.com:80=8000,bla.fff.com:80=9999@world;addd:80=9999" jmcarbo/rancher-caddy /bin/sh

deploy:
	@RANCHER_URL=$(rancher_url) \
	RANCHER_ACCESS_KEY=$(rancher_access_key) \
	RANCHER_SECRET_KEY=$(rancher_secret_key) \
	rancher-compose up -d
