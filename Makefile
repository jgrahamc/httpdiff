.PHONY: all
all: ; @go build httpdiff.go

.PHONY: install
install: ; @go install ./...

.PHONY: clean
clean: ; @rm httpdiff
