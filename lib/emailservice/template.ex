defmodule EmailService.Template do
  require EEx

  defp template_dir do
    :email_service
    |> :code.priv_dir()
    |> to_string()
    |> Path.join("templates")
  end

  @spec render(atom, keyword) :: {String.t(), String.t()}
  def render(:verification_code, assigns) do
    {render_file("verification_code.html.eex", assigns),
     render_file("verification_code.txt.eex", assigns)}
  end

  defp render_file(file, assigns) do
    template_dir()
    |> Path.join(file)
    |> EEx.eval_file(assigns)
  end
end
