defmodule EmailService.RPC.EmailServer do
  use GRPC.Server, service: Email.EmailService.Service
  require Logger

  alias Email.SendEmailResponse
  alias EmailService.Handler.SendEmail, as: Validator
  alias EmailService.Service.SendEmail, as: Sender

  @impl true
  def send_email(req, _stream) do
    case Validator.validate(req) do
      {:ok, %{to: to, template: tpl, assigns: assigns}} ->
        case Sender.execute(to, tpl, assigns) do
          :ok ->
            SendEmailResponse.new(success: true)

          {:error, reason} ->
            Logger.error("Send error: #{inspect(reason)}")
            SendEmailResponse.new(success: false)
        end

      {:error, reason} ->
        Logger.debug("Validation failed: #{inspect(reason)}")
        SendEmailResponse.new(success: false)
    end
  end
end
