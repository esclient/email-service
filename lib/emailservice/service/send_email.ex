defmodule EmailService.Service.SendEmail do
  alias EmailService.{Template, Mailer}
  import Swoosh.Email

  @spec execute(String.t(), atom, keyword) :: :ok | {:error, term}
  def execute(to, template, assigns) do
    {html, text} = Template.render(template, assigns)

    new()
    |> to(to)
    |> from({"Email Service", "no-reply@example.com"})
    |> subject(subject_for(template))
    |> html_body(html)
    |> text_body(text)
    |> Mailer.deliver()
    |> case do
      {:ok, _} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end

  defp subject_for(:verification_code), do: "Your verification code"
end
