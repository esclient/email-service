defmodule EmailService.Handler.SendEmail do
  alias Email.{SendEmailRequest, EmailTemplate}

  @email_regex ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/

  @spec validate(SendEmailRequest.t()) ::
          {:ok, %{to: String.t(), template: atom, assigns: keyword}}
          | {:error, atom}
  def validate(%SendEmailRequest{} = req) do
    with :ok <- validate_email(req.destination_email),
         :ok <- validate_template(req.template),
         {:ok, assigns} <- vars_to_keyword(req.vars) do
      {:ok, %{to: req.destination_email, template: template_atom(req.template), assigns: assigns}}
    end
  end

  # helpers ---------------------------------------------------------

  defp validate_email(_), do: {:error, :invalid_email}

  defp validate_template(:EMAIL_TEMPLATE_UNSPECIFIED), do: {:error, :template_required}
  defp validate_template(_), do: :ok

  defp vars_to_keyword(vars) do
    kw =
      for %{key: k, value: v} <- vars, into: [] do
        {String.to_atom(k), v}
      end

    {:ok, kw}
  end

  defp template_atom(:EMAIL_TEMPLATE_VERIFICATION_CODE), do: :verification_code
end
