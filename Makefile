ROOT_DIR := $(shell pwd)
BIN_DIR := $(ROOT_DIR)/bin
DB_DIR := $(ROOT_DIR)/db
DATA_DIR := $(ROOT_DIR)/data-admin-au

BIN_SERVER := $(BIN_DIR)/server
BIN_UPDATE_DB := $(BIN_DIR)/updatedb

build-server:
	GOOS=darwin GOARCH=amd64 go build -o $(BIN_SERVER) -ldflags="-s -w" $(ROOT_DIR)/cmd/server/main.go

build-updatedb:
	GOOS=darwin GOARCH=amd64 go build -o $(BIN_UPDATE_DB) -ldflags="-s -w" $(ROOT_DIR)/cmd/updatedb/main.go

updatedb:
	( test -s $(BIN_UPDATE_DB) || make build-updatedb ) && \
	$(BIN_UPDATE_DB) -db $(DB_DIR) -data $(DATA_DIR)

all: build-server build-updatedb

.SILENT: updatedb
