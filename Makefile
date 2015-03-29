.PHONY: all
all: ; @go build httpdiff.go

.PHONY: static
# https://medium.com/@kelseyhightower/optimizing-docker-images-for-static-binaries-b5696e26eb07
static: ; @GOPATH=~ CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -tags netgo -ldflags '-w' httpdiff.go

.PHONY: install
install: ; @go install ./...

.PHONY: clean
clean: ; @rm httpdiff
