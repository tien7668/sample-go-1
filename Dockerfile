# Vendor stage
FROM golang:1.16 as dep
WORKDIR /build
COPY go.mod go.sum ./
RUN GO111MODULE=on go mod download
COPY . .
RUN go mod vendor

# Build binary stage
FROM golang:1.16 as build
WORKDIR /build
COPY --from=dep /build .
RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -a -installsuffix cgo -o server -tags nethttpomithttp2 ./cmd/app

FROM alpine:latest
WORKDIR /app
COPY internal/pkg/config internal/pkg/config
COPY migrations migrations
COPY --from=build /build/server server
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates
RUN apk --no-cache add tzdata
CMD ["./server", "main"]
