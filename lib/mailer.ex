defmodule Mailer do
  @moduledoc """
  Contains all the core email logic
  """
  import Bamboo.Email
  use Bamboo.Phoenix, view: ClumsyChinchilla.EmailView

  @default_from_email_address "no-reply@clumsy-chinchilla.club"
  @default_replyto_email_address "no-reply@clumsy-chinchilla.club"

  def account_onboarding_email(account) do
    new_application_email()
    |> to(account.email_address)
    |> subject("Finish setting up your Clumsy Chinchilla Account")
    |> put_header("Reply-To", @default_replyto_email_address)
    |> render(:account_onboarding_email)
  end

  defp new_application_email() do
    new_email()
    |> from(@default_from_email_address)
    |> put_layout({ClumsyChinchillaWeb.LayoutView, :email})
    |> put_header("Reply-To", @default_replyto_email_address)
  end
end
