import os
import time

import grpc.experimental

protos, services = grpc.protos_and_services("helloworld.proto")

endpoint = os.environ["ENDPOINT"]

name = "Lorem"
message = "Ping!"

while True:
    request = protos.HelloRequest(name=name, message=message)
    response = services.Greeter.SayHello(request, endpoint, insecure=True)

    print("Sent '{}' as '{}'".format(message, name))
    print("Received '{}', from '{}'".format(response.message, response.name))
    print()

    time.sleep(1)
