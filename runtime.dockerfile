FROM scratch
COPY httpdiff /
ENTRYPOINT ["/httpdiff"]
CMD ["-help"]
