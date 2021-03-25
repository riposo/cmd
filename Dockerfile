FROM golang:1-buster

WORKDIR /cmd/riposo
COPY . /cmd/riposo
ENTRYPOINT [ "./build.sh" ]
