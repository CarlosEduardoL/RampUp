FROM golang as builder
WORKDIR /app
COPY . .
RUN go build -o server -ldflags "-w -s" .
FROM ubuntu:20.04
RUN apt update && apt install ansible -y && rm -rf /var/lib/apt/lists/*
EXPOSE 5555
WORKDIR /home/ubuntu
COPY --from=builder /app .
COPY ./ansible.cfg .
CMD ["./server"]