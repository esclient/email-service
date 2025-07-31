defmodule EmailService do
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.fetch_env!(:emailservice, :grpc_port)

    children = [
      {Finch, name: EmailService.Finch},
      {GRPC.Server.Supervisor, endpoint: EmailService.Endpoint, port: port, start_server: true},
      GrpcReflection
    ]

    Logger.info("gRPC EmailService running on :#{port}")
    Supervisor.start_link(children, strategy: :one_for_one, name: EmailService.Supervisor)
  end
end
