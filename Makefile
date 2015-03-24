NAME := httpdiff

.PHONY: all
all: $(NAME)

.PHONY: $(NAME)
$(NAME): bin/$(NAME)

.PHONY: bin/$(NAME)
bin/$(NAME): ; @GOPATH="${PWD}" go install $(NAME)
