defmodule Emailservice.Reflection.Server do
  use GrpcReflection.Server,
    version: :v1alpha,
    services: [Emailservice.RPC.EmailServer.Service]
end
