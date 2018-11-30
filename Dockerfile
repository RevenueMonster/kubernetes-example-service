# docker build --tag=kubernetes-example-service .
# docker run -it -p 8080:5000 kubernetes-example-service

FROM golang:1.10.3 as builder
ADD . /go/src/bitbucket.org/revenuemonster/kubernetes_example_service

# Install Dependencies
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get github.com/labstack/echo

WORKDIR  /go/src/bitbucket.org/revenuemonster/kubernetes_example_service

RUN make

FROM golang:1.10.3
RUN apt-get update
RUN apt-get install -y ca-certificates

COPY --from=builder /go/src/bitbucket.org/revenuemonster/kubernetes_example_service /go/src/app/kubernetes_example_service

ENV SYSTEM_NAME 'hello world'

WORKDIR  /go/src/app/kubernetes_example_service
ENTRYPOINT ./kubernetes_example_service