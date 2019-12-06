defmodule LottoAPIWeb.ErrorView do
  use LottoAPIWeb, :view

  alias Ecto.Changeset

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    message = Phoenix.Controller.status_message_from_template(template)
    render("error.json", message: message)
  end

  def render("error.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("error.json", %{changeset: %Changeset{} = changeset}) do
    %{errors: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    Changeset.traverse_errors(changeset, &translate_error/1)
  end
end
