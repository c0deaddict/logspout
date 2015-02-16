FROM gliderlabs/alpine:3.1
ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 8000

RUN apk-install go git mercurial

COPY . /go/src/github.com/progrium/logspout

RUN cd /go/src/github.com/progrium/logspout \
	&& export GOPATH=/go \
	&& go get \
	&& go build -ldflags "-X main.Version $(cat VERSION)" -o /bin/logspout

RUN rm -rf /go && apk del go git mercurial
