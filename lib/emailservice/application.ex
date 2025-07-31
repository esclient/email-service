defmodule Emailservice do
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.fetch_env!(:email_service, :grpc_port)

    children = [
      {Finch, name: EmailFinch},
      {GRPC.Server.Supervisor, {Emailservice.RPC.EmailServer, port, [cred: nil]}}
    ]

    Logger.info("gRPC EmailService running on :#{port}")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
