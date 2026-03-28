BINARY_NAME=thelastorg
BUILD_DIR=.

.PHONY: build test run clean lint

build:
	go build -o $(BUILD_DIR)/$(BINARY_NAME) ./cmd/thelastorg

test:
	go test ./...

run: build
	./$(BINARY_NAME)

clean:
	rm -f $(BUILD_DIR)/$(BINARY_NAME)
	go clean

lint:
	golangci-lint run ./...
