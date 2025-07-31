defmodule EmailService.Reflection.Server do
  use GrpcReflection.Server,
    version: :v1alpha,
    services: [Email.EmailService.Service]
end
