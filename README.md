# Management

```bash
/bin/bash mgmt.sh build http2
/bin/bash mgmt.sh build debug
```

```bash
export USE_TLS="true"
export ENDPOINT="localhost:9443"

python3 client.py


export LISTEN_PORT="9000"
export LISTEN_PORT_TLS="9443"

python3 server.py
```

```bash
grpcurl -plaintext -d '{"name":"World", "message": "Hello"}' localhost:9000 helloworld.Greeter/SayHello
```