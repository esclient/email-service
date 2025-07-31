defmodule EmailService.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Server.Interceptors.Logger)
  run(EmailService.RPC.EmailServer)
  run(EmailService.Reflection.Server)
end
