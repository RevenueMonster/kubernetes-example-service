# docker build --tag=kubernetes-example-service .
# docker run -it -p 8080:5000 kubernetes-example-service

FROM golang:1.10.3 as builder
WORKDIR  /go/src/bitbucket.org/revenuemonster
ADD . /go/src/bitbucket.org/revenuemonster
# Install Dependencies
RUN go get github.com/labstack/echo
RUN make

FROM alpine
WORKDIR  /app
# install ca cert if you want expose the app directly using load balancer
# RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /go/src/bitbucket.org/revenuemonster/kubernetes-example-service /app
# Container Environment
ENV SYSTEM_NAME 'hello worlds'
ENTRYPOINT ./kubernetes-example-service