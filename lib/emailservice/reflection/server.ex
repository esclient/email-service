defmodule EmailService.Reflection.Server do
  use GrpcReflection.Server,
    version: :v1alpha,
    services: [EmailService.RPC.EmailServer.Service]
end
