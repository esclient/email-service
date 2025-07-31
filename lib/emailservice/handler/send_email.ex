defmodule EmailService.Handler.SendEmail do
  @email_regex ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/

  @spec validate(Email.SendEmailRequest.t()) ::
          {:ok, %{to: String.t(), template: atom, assigns: keyword}}
          | {:error, atom}
  def validate(%Email.SendEmailRequest{} = req) do
    with :ok <- validate_email(req.destination_email),
         :ok <- validate_template(req.template),
         {:ok, assigns} <- vars_to_keyword(req.vars) do
      {:ok, %{to: req.destination_email, template: template_atom(req.template), assigns: assigns}}
    end
  end

  defp validate_email(email) when is_binary(email) do
    if Regex.match?(@email_regex, email), do: :ok, else: {:error, :invalid_email}
  end

  defp validate_template(:EMAIL_TEMPLATE_UNSPECIFIED), do: {:error, :template_required}
  defp validate_template(_), do: :ok

  defp vars_to_keyword(vars) do
    allowed = [:code, :another_key]

    kw =
      vars
      |> Enum.map(fn %{key: k, value: v} ->
        atom_key = String.to_atom(k)

        if atom_key in allowed do
          {atom_key, v}
        else
          nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    {:ok, kw}
  end

  defp template_atom(:EMAIL_TEMPLATE_VERIFICATION_CODE), do: :verification_code
end
