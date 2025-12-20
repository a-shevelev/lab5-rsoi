FROM golang:1.24 AS build

WORKDIR /app

COPY go.mod go.sum ./

#COPY person-service.yaml ./person-service.yaml
COPY "cmd/" "./cmd"
COPY internal ./internal
COPY pkg ./pkg

RUN go mod tidy

WORKDIR /app/cmd/app

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o /server .


FROM alpine:latest AS certs
RUN apk update && apk add --no-cache ca-certificates curl

RUN curl -s -o /etc/ssl/certs/AmazonRootCA1.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem && \
    curl -s -o /etc/ssl/certs/StarfieldServicesRootCertificateAuthority-G2.pem https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem
#FROM build AS tests
#WORKDIR /app
#CMD ["go", "test", "./...", "-v"]

FROM scratch AS release
COPY --from=build /server /server

COPY --from=certs /etc/ssl/certs /etc/ssl/certs
ENV SSL_CERT_DIR=/etc/ssl/certs
ENV GOMAXPROCS=1

ENTRYPOINT ["/server"]
