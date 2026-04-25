FROM golang:1.24 AS build
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o hello-platform .

FROM gcr.io/distroless/static-debian12

COPY --from=build /app/hello-platform /
ENV APP_ENV=dev
EXPOSE 8080
CMD ["./hello-platform"]