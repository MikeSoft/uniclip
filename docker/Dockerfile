FROM golang:1.19-alpine AS builder

WORKDIR /app

COPY ../go.mod ../go.sum ./
RUN go mod download

COPY ../uniclip.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o uniclip .

FROM alpine:latest

RUN apk --no-cache add xclip

WORKDIR /root/

COPY --from=builder /app/uniclip /usr/local/bin/

EXPOSE 53701

COPY docker/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME ["/data"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
