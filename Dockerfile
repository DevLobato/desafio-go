FROM golang:1.22.3 as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

# Imagem que contem somente um binário para executar
FROM scratch

COPY --from=builder /app/server /server

ENTRYPOINT [ "/server" ]