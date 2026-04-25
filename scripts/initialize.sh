#!/usr/bin/env bash

set -euo pipefail

MODULE="github.com/rn404/uchu-terminal"

# go mod init
if [ ! -f go.mod ]; then
  go mod init "$MODULE"
fi

mkdir -p \
  cmd/uchu-terminal \
  internal/{app,core,engine,ui,data} \
  data/events \
  scripts

create_file() {
  local path="$1"
  local content="$2"

  if [ ! -f "$path" ]; then
    echo "create $path"
    printf "%s\n" "$content" >"$path"
  else
    echo "skip $path (already exists)"
  fi
}

# cmd
create_file cmd/uchu-terminal/main.go 'package main

import "fmt"

func main() {
	fmt.Println("hello world")
}
'

# internal
create_file internal/app/game_loop.go 'package app
'
create_file internal/core/state.go 'package core
'
create_file internal/core/stats.go 'package core
'
create_file internal/core/event.go 'package core
'
create_file internal/core/dice.go 'package core
'
create_file internal/core/ending.go 'package core
'
create_file internal/engine/event_picker.go 'package engine
'
create_file internal/engine/condition.go 'package engine
'
create_file internal/engine/resolver.go 'package engine
'
create_file internal/engine/ending_resolver.go 'package engine
'
create_file internal/ui/terminal.go 'package ui
'
create_file internal/ui/formatter.go 'package ui
'
create_file internal/data/loader.go 'package data
'
create_file internal/data/validator.go 'package data
'

# events
create_file data/events/early.yaml '# early events
events: []
'

# Makefile
create_file Makefile '.PHONY: all init test lint run fmt tidy

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
'

# tidy & test
go mod tidy
go fmt ./...
go test ./...
