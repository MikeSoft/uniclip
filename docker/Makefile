UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
  NETWORK_OPT := --network host
  $(info Linux detected - using host network mode)
else
  NETWORK_OPT :=
  $(info MacOS/Windows detected - using standard port mapping)
endif

.PHONY: build run run-secure debug logs stop clean help

IMAGE_NAME := uniclip
CONTAINER_NAME := uniclip
PORT := 53701

build:
	@echo "Building Docker image..."
	cd .. && docker build -t $(IMAGE_NAME) --build-arg PORT=$(PORT) -f docker/Dockerfile .

run:
	@echo "Running Uniclip container on port $(PORT)..."
	docker run -d --name $(CONTAINER_NAME) \
		$(NETWORK_OPT) \
		-p $(PORT):$(PORT) \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(IMAGE_NAME) -p $(PORT)

run-secure:
	@echo "Running Uniclip container in secure mode on port $(PORT)..."
	docker run -it --name $(CONTAINER_NAME) \
		$(NETWORK_OPT) \
		-p $(PORT):$(PORT) \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(IMAGE_NAME) --secure -p $(PORT)

debug:
	@echo "Running Uniclip container in debug mode on port $(PORT)..."
	docker run -d --name $(CONTAINER_NAME) \
		$(NETWORK_OPT) \
		-p $(PORT):$(PORT) \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(IMAGE_NAME) --debug -p $(PORT)

logs:
	docker logs $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

clean: stop
	docker rmi $(IMAGE_NAME) || true

help:
	@echo "Available commands:"
	@echo "  make build      - Build Docker image"
	@echo "  make run        - Run container with default settings (port $(PORT))"
	@echo "  make run-secure - Run container in secure mode (interactive for password)"
	@echo "  make debug      - Run container in debug mode"
	@echo "  make logs       - Show container logs"
	@echo "  make stop       - Stop and remove container"
	@echo "  make clean      - Remove container and image"
	@echo ""
	@echo "Override variables:"
	@echo "  make run PORT=6666 - Run container on port 6666"
