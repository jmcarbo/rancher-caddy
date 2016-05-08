build:
	docker build -t jmcarbo/rancher-caddy .

run:
	docker run -ti -e HOSTS="isawesome;blu.bla.com:80=8000,bla.fff.com:80=9999@world;addd:80=9999" jmcarbo/rancher-caddy /bin/sh

deploy:
	@RANCHER_URL=$(RANCHER_URL) \
	RANCHER_ACCESS_KEY=$(RANCHER_ACCESS_KEY) \
	RANCHER_SECRET_KEY=$(RANCHER_SECRET_KEY) \
	rancher-compose up -d

destroy:
	@RANCHER_URL=$(RANCHER_URL) \
	RANCHER_ACCESS_KEY=$(RANCHER_ACCESS_KEY) \
	RANCHER_SECRET_KEY=$(RANCHER_SECRET_KEY) \
	rancher-compose rm -f
