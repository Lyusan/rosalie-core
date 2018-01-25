FROM golang:latest

RUN go-wrapper download
RUN go-wrapper install

EXPOSE 8080

CMD ["go-wrapper", "run"]