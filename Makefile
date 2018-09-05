
.PHONY: all build run
	
all: build run
	
build:
	docker build \
		-t nanobox/buildpack-build \
		build
		
	docker push nanobox/buildpack-build
	
run:
	docker build \
		-t nanobox/buildpack-run \
		run
	
	docker push nanobox/buildpack-run
