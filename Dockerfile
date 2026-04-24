FROM golang:1.24
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o hello-platform .
EXPOSE 8080
CMD ["./hello-platform"]