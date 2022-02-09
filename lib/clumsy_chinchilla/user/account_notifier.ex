defmodule ClumsyChinchilla.User.AccountNotifier do
  import Swoosh.Email

  alias ClumsyChinchilla.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"MyApp", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(account, url) do
    deliver(account.email, "Confirmation instructions", """

    ==============================

    Hi #{account.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a account password.
  """
  def deliver_reset_password_instructions(account, url) do
    deliver(account.email, "Reset password instructions", """

    ==============================

    Hi #{account.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a account email.
  """
  def deliver_update_email_instructions(account, url) do
    deliver(account.email, "Update email instructions", """

    ==============================

    Hi #{account.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

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
end
