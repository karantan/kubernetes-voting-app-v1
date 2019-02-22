# convenience makefile

.PHONY: pods
pods:
	@kubectl create -f pods/postgres-pod.yaml
	@kubectl create -f pods/redis-pod.yaml
	@kubectl create -f pods/result-app-pod.yaml
	@kubectl create -f pods/voting-app-pod.yaml
	@kubectl create -f pods/worker-app-pod.yaml

.PHONY: services
services:
	@kubectl create -f services/postgres-service.yaml
	@kubectl create -f services/redis-service.yaml
	@kubectl create -f services/result-service.yaml
	@kubectl create -f services/voting-service.yaml
