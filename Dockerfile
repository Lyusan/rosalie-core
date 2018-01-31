FROM golang:latest

RUN mkdir -p /go/src/app
WORKDIR /go/src/app
EXPOSE 8080

CMD ["go-wrapper", "run"]

ONBUILD RUN go-wrapper download
ONBUILD RUN go-wrapper install
ONBUILD COPY . /go/src/app