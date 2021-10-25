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
    |> assign(:call_to_action, account_confirmation_url(confirmation_secret))
    |> to(unconfirmed_email_address)
    |> subject("Finish setting up your #{Application.get_env(:clumsy_chinchilla, :application_name)} Account")
    |> render(:onboarding_email)
  end

  defp account_confirmation_url(secret) do
    Web.Router.Helpers.page_url(Web.Endpoint, :index, ["account_confirmation"], token: secret)
  end
end
