.PHONY: build scan all

build:
	@echo "📦 Not Safe Build..."
	docker build -t docker-shield .

scan:
	@echo "🔍 Safe Build..."
	./build-and-scan.sh

all: scan
