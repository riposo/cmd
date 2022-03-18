FROM golang:1-bullseye

WORKDIR /cmd/riposo
COPY . /cmd/riposo
ENTRYPOINT [ "./build.sh" ]
