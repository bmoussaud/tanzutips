build:
	pack build bmoussaud/myphpapp --run-image paketobuildpacks/run:full-cnb  --builder paketobuildpacks/builder:full  --buildpack paketo-buildpacks/php

push: build
	docker push bmoussaud/myphpapp

deploy: 
	kubectl apply -f k8s

undeploy: 
	kubectl delete -f k8s


foward:
	kubectl port-forward  service/myphp-service 1080:80
	
