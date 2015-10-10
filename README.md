# Client Certificate Echoing Server

## Overview

This repo and Docker image provides a test image that listens on :9443 and echoes any client certificates presented to it.

To start, run like this:
```
docker run -p 9443:9443 -ti liggitt/client-cert
```

# Docker image setup

### Build the Docker image from source

```
make build
```

### Run the Docker image from source


```
make run
```
  
## Example Use

```
curl -k https://localhost:9443/test --cert ./client.crt --key ./client.key
```
