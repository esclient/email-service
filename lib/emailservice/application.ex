defmodule EmailService do
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.fetch_env!(:emailservice, :grpc_port)

    children = [
      {Finch, name: EmailFinch},
      {GRPC.Server.Supervisor, {EmailService.RPC.EmailServer, port, [cred: nil]}},
      {GRPC.Server.Supervisor, {EmailService.Reflection.Server, port, [cred: nil]}},
      GrpcReflection
    ]

    Logger.info("gRPC EmailService running on :#{port}")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
