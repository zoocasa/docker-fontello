FROM node:8.9.3-alpine

# Set the working directory
WORKDIR /data

# Set the Volume mount point which will store the config.json config
VOLUME /data/app

# Set arguments
ARG FONTELLO_CLI_VERSION="0.4.0"

# Install the rethink-migrate binary
RUN yarn global add fontello-cli@${FONTELLO_CLI_VERSION}

RUN apk add --update curl wget

COPY ./fontello.sh .

# Start the rethink-migrate binrary referencing the config data in the Volume
ENTRYPOINT ["./fontello.sh"]
