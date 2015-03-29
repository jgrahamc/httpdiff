FROM alpine:latest
RUN apk upgrade --update && apk add \
    git \
    go \
    make \
    && rm -fr /var/cache/apk/*
RUN adduser -D developer
WORKDIR /home/developer
USER developer
ENTRYPOINT ["make"]
CMD ["static"]
COPY . /home/developer
