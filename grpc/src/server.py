import os
from concurrent import futures

import grpc.experimental

protos, services = grpc.protos_and_services("helloworld.proto")

endpoint = "0.0.0.0:{}".format(os.environ["SERVER_PORT"])

name = "Ipsum"
message = "Pong!"


class Greeter(services.GreeterServicer):
    def SayHello(self, request, context):
        print("Received '{}' from '{}'".format(request.message, request.name)),
        print("Sent '{}' as '{}'".format(message, name))
        print()

        return protos.HelloReply(name=name, message=message)


server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
services.add_GreeterServicer_to_server(Greeter(), server)
server.add_insecure_port(endpoint)
server.start()
server.wait_for_termination()
