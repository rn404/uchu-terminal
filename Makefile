.PHONY: all init test lint run fmt tidy

all: fmt lint test

run:
	go run ./cmd/uchu-terminal

test:
	go test ./...

lint:
	golangci-lint run

fmt:
	go fmt ./...

tidy:
	go mod tidy

