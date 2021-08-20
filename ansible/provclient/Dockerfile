FROM ubuntu:20.04
RUN apt update && apt install ansible python3-pip -y && rm -rf /var/lib/apt/lists/*
RUN pip install boto boto3