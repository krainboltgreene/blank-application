defmodule Mailer.Accounts do
  @moduledoc false
  import Bamboo.Email
  use Bamboo.Phoenix, view: Mailer.AccountsView

  @spec onboarding_email(%{unconfirmed_email_address: String.t(), confirmation_secret: String.t()}) ::
          Bamboo.Email.t()
  def onboarding_email(%{
        unconfirmed_email_address: unconfirmed_email_address,
        confirmation_secret: confirmation_secret
      })
      when is_bitstring(unconfirmed_email_address) and is_bitstring(confirmation_secret) do
    Mailer.new_application_email()
    |> assign(:confirmation_secret, confirmation_secret)
    |> to(unconfirmed_email_address)
    |> subject("Finish setting up your Clumsy Chinchilla Account")
    |> render(:onboarding_email)
  end
end
