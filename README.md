```bash
/bin/bash mgmt.sh build http2
/bin/bash mgmt.sh build debug
```

##  

```bash
grpcurl -plaintext -d '{"name":"World", "message": "Hello"}' localhost:9000 helloworld.Greeter/SayHello
```