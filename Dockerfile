# docker build --tag=kubernetes-example-service .
# docker run -it -p 8080:5000 kubernetes-example-service

FROM golang:1.10.3 as builder
ADD . /go/src/bitbucket.org/revenuemonster/kubernetes-example-service

# Install Dependencies
RUN go get github.com/labstack/echo

WORKDIR  /go/src/bitbucket.org/revenuemonster/kubernetes-example-service

RUN make

FROM alpine
WORKDIR  /app

# install ca cert if you want expose the app directly using load balancer
# RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY --from=builder /go/src/bitbucket.org/revenuemonster/kubernetes-example-service /app/kubernetes-example-service

ENV SYSTEM_NAME 'hello world'

ENTRYPOINT ./kubernetes-example-service