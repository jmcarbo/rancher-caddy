build:
	docker build -t jmcarbo/rancher-caddy .


deploy:
	@RANCHER_URL=$(rancher_url) \
	RANCHER_ACCESS_KEY=$(rancher_access_key) \
	RANCHER_SECRET_KEY=$(rancher_secret_key) \
	rancher-compose up -d
