defmodule ClumsyChinchilla.UsersTest do
  use ClumsyChinchilla.DataCase

  import ClumsyChinchilla.UsersFixtures

  describe "get_account_by_email_address/1" do
    test "does not return the account if the email_address does not exist" do
      refute ClumsyChinchilla.Users.get_account_by_email_address("unknown@example.com")
    end

    test "returns the account if the email_address exists" do
      %{id: id} = account = account_fixture()
      assert %ClumsyChinchilla.Users.Account{id: ^id} = ClumsyChinchilla.Users.get_account_by_email_address(account.email_address)
    end
  end

  describe "get_account_by_email_address_and_password/2" do
    test "does not return the account if the email_address does not exist" do
      refute ClumsyChinchilla.Users.get_account_by_email_address_and_password(
               "unknown@example.com",
               "hello world!"
             )
    end

    test "does not return the account if the password is not valid" do
      account = account_fixture()
      refute ClumsyChinchilla.Users.get_account_by_email_address_and_password(account.email_address, "invalid")
    end

    test "returns the account if the email_address and password are valid" do
      %{id: id} = account = account_fixture()

      assert %ClumsyChinchilla.Users.Account{id: ^id} =
               ClumsyChinchilla.Users.get_account_by_email_address_and_password(
                 account.email_address,
                 valid_account_password()
               )
    end
  end

  describe "get_account!/1" do
    test "raises if id is invalid" do
      assert_raise Ecto.NoResultsError, fn ->
        ClumsyChinchilla.Users.get_account!("11111111-1111-1111-1111-111111111111")
      end
    end

    test "returns the account with the given id" do
      %{id: id} = account = account_fixture()
      assert %ClumsyChinchilla.Users.Account{id: ^id} = ClumsyChinchilla.Users.get_account!(account.id)
    end
  end

  describe "register_account/1" do
    test "requires email_address and password to be set" do
      {:error, changeset} = ClumsyChinchilla.Users.register_account(%{})

      assert %{
               password: ["can't be blank"],
               email_address: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "validates email_address and password when given" do
      {:error, changeset} =
        ClumsyChinchilla.Users.register_account(%{email_address: "not valid", password: "not valid"})

      assert %{
               email_address: ["must have the @ sign and no spaces"],
               password: ["should be at least 12 character(s)"]
             } = errors_on(changeset)
    end

    test "validates maximum values for email_address and password for security" do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        ClumsyChinchilla.Users.register_account(%{email_address: too_long, password: too_long})

      assert "should be at most 160 character(s)" in errors_on(changeset).email_address
      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "validates email_address uniqueness" do
      %{email_address: email_address} = account_fixture()
      {:error, changeset} = ClumsyChinchilla.Users.register_account(%{email_address: email_address})
      assert "has already been taken" in errors_on(changeset).email_address

      # Now try with the upper cased email_address too, to check that email_address case is ignored.
      {:error, changeset} =
        ClumsyChinchilla.Users.register_account(%{email_address: String.upcase(email_address)})

      assert "has already been taken" in errors_on(changeset).email_address
    end

    test "registers accounts with a hashed password" do
      email_address = unique_account_email_address()

      {:ok, account} =
        ClumsyChinchilla.Users.register_account(valid_account_attributes(email_address: email_address))

      assert account.email_address == email_address
      assert is_binary(account.hashed_password)
      assert is_nil(account.confirmed_at)
      assert is_nil(account.password)
    end
  end

  describe "change_account_registration/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} =
               changeset = ClumsyChinchilla.Users.change_account_registration(%ClumsyChinchilla.Users.Account{})

      assert changeset.required == [:password, :email_address, :username]
    end

    test "allows fields to be set" do
      email_address = unique_account_email_address()
      password = valid_account_password()

      changeset =
        ClumsyChinchilla.Users.change_account_registration(
          %ClumsyChinchilla.Users.Account{},
          valid_account_attributes(email_address: email_address, password: password)
        )

      assert changeset.valid?
      assert get_change(changeset, :email_address) == email_address
      assert get_change(changeset, :password) == password
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "change_account_email_address/2" do
    test "returns a account changeset" do
      assert %Ecto.Changeset{} =
               changeset = ClumsyChinchilla.Users.change_account_email_address(%ClumsyChinchilla.Users.Account{})

      assert changeset.required == [:email_address]
    end
  end

  describe "apply_account_email_address/3" do
    setup do
      %{account: account_fixture()}
    end

    test "requires email_address to change", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.apply_account_email_address(account, valid_account_password(), %{})

      assert %{email_address: ["did not change"]} = errors_on(changeset)
    end

    test "validates email_address", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.apply_account_email_address(account, valid_account_password(), %{
          email_address: "not valid"
        })

      assert %{email_address: ["must have the @ sign and no spaces"]} = errors_on(changeset)
    end

    test "validates maximum value for email_address for security", %{account: account} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        ClumsyChinchilla.Users.apply_account_email_address(account, valid_account_password(), %{
          email_address: too_long
        })

      assert "should be at most 160 character(s)" in errors_on(changeset).email_address
    end

    test "validates email_address uniqueness", %{account: account} do
      %{email_address: email_address} = account_fixture()

      {:error, changeset} =
        ClumsyChinchilla.Users.apply_account_email_address(account, valid_account_password(), %{
          email_address: email_address
        })

      assert "has already been taken" in errors_on(changeset).email_address
    end

    test "validates current password", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.apply_account_email_address(account, "invalid", %{
          email_address: unique_account_email_address()
        })

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "applies the email_address without persisting it", %{account: account} do
      email_address = unique_account_email_address()

      {:ok, account} =
        ClumsyChinchilla.Users.apply_account_email_address(account, valid_account_password(), %{
          email_address: email_address
        })

      assert account.email_address == email_address
      assert ClumsyChinchilla.Users.get_account!(account.id).email_address != email_address
    end
  end

  describe "deliver_update_email_address_instructions/3" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_update_email_address_instructions(
            account,
            "current@example.com",
            url
          )
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email_address
      assert account_token.context == "change:current@example.com"
    end
  end

  describe "update_account_email_address/2" do
    setup do
      account = account_fixture()
      email_address = unique_account_email_address()

      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_update_email_address_instructions(
            %{account | email_address: email_address},
            account.email_address,
            url
          )
        end)

      %{account: account, token: token, email_address: email_address}
    end

    test "updates the email_address with a valid token", %{account: account, token: token, email_address: email_address} do
      assert ClumsyChinchilla.Users.update_account_email_address(account, token) == :ok
      changed_account = ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id)
      assert changed_account.email_address != account.email_address
      assert changed_account.email_address == email_address
      assert changed_account.confirmed_at
      assert changed_account.confirmed_at != account.confirmed_at
      refute ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not update email_address with invalid token", %{account: account} do
      assert ClumsyChinchilla.Users.update_account_email_address(account, "oops") == :error
      assert ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).email_address == account.email_address
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not update email_address if account email_address changed", %{account: account, token: token} do
      assert ClumsyChinchilla.Users.update_account_email_address(
               %{account | email_address: "current@example.com"},
               token
             ) == :error

      assert ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).email_address == account.email_address
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not update email_address if token expired", %{account: account, token: token} do
      {1, nil} = ClumsyChinchilla.Repo.update_all(ClumsyChinchilla.Users.AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      assert ClumsyChinchilla.Users.update_account_email_address(account, token) == :error
      assert ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).email_address == account.email_address
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end
  end

  describe "change_account_password/2" do
    test "returns a account changeset" do
      assert %Ecto.Changeset{} =
               changeset = ClumsyChinchilla.Users.change_account_password(%ClumsyChinchilla.Users.Account{})

      assert changeset.required == [:password]
    end

    test "allows fields to be set" do
      changeset =
        ClumsyChinchilla.Users.change_account_password(%ClumsyChinchilla.Users.Account{}, %{
          "password" => "new valid password"
        })

      assert changeset.valid?
      assert get_change(changeset, :password) == "new valid password"
      assert is_nil(get_change(changeset, :hashed_password))
    end
  end

  describe "update_account_password/3" do
    setup do
      %{account: account_fixture()}
    end

    test "validates password", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.update_account_password(account, valid_account_password(), %{
          password: "not valid",
          password_confirmation: "another"
        })

      assert %{
               password: ["should be at least 12 character(s)"],
               password_confirmation: ["does not match password"]
             } = errors_on(changeset)
    end

    test "validates maximum values for password for security", %{account: account} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        ClumsyChinchilla.Users.update_account_password(account, valid_account_password(), %{
          password: too_long
        })

      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "validates current password", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.update_account_password(account, "invalid", %{
          password: valid_account_password()
        })

      assert %{current_password: ["is not valid"]} = errors_on(changeset)
    end

    test "updates the password", %{account: account} do
      {:ok, account} =
        ClumsyChinchilla.Users.update_account_password(account, valid_account_password(), %{
          password: "new valid password"
        })

      assert is_nil(account.password)

      assert ClumsyChinchilla.Users.get_account_by_email_address_and_password(
               account.email_address,
               "new valid password"
             )
    end

    test "deletes all tokens for the given account", %{account: account} do
      _ = ClumsyChinchilla.Users.generate_account_session_token(account)

      {:ok, _} =
        ClumsyChinchilla.Users.update_account_password(account, valid_account_password(), %{
          password: "new valid password"
        })

      refute ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end
  end

  describe "generate_account_session_token/1" do
    setup do
      %{account: account_fixture()}
    end

    test "generates a token", %{account: account} do
      token = ClumsyChinchilla.Users.generate_account_session_token(account)
      assert account_token = ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, token: token)
      assert account_token.context == "session"

      # Creating the same token for another account should fail
      assert_raise Ecto.ConstraintError, fn ->
        ClumsyChinchilla.Repo.insert!(%ClumsyChinchilla.Users.AccountToken{
          token: account_token.token,
          account_id: account_fixture().id,
          context: "session"
        })
      end
    end
  end

  describe "get_account_by_session_token/1" do
    setup do
      account = account_fixture()
      token = ClumsyChinchilla.Users.generate_account_session_token(account)
      %{account: account, token: token}
    end

    test "returns account by token", %{account: account, token: token} do
      assert session_account = ClumsyChinchilla.Users.get_account_by_session_token(token)
      assert session_account.id == account.id
    end

    test "does not return account for invalid token" do
      refute ClumsyChinchilla.Users.get_account_by_session_token("oops")
    end

    test "does not return account for expired token", %{token: token} do
      {1, nil} = ClumsyChinchilla.Repo.update_all(ClumsyChinchilla.Users.AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      refute ClumsyChinchilla.Users.get_account_by_session_token(token)
    end
  end

  describe "delete_session_token/1" do
    test "deletes the token" do
      account = account_fixture()
      token = ClumsyChinchilla.Users.generate_account_session_token(account)
      assert ClumsyChinchilla.Users.delete_session_token(token) == :ok
      refute ClumsyChinchilla.Users.get_account_by_session_token(token)
    end
  end

  describe "deliver_account_confirmation_instructions/2" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_account_confirmation_instructions(account, url)
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email_address
      assert account_token.context == "confirm"
    end
  end

  describe "confirm_account/1" do
    setup do
      account = account_fixture()

      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_account_confirmation_instructions(account, url)
        end)

      %{account: account, token: token}
    end

    test "confirms the email_address with a valid token", %{account: account, token: token} do
      assert {:ok, confirmed_account} = ClumsyChinchilla.Users.confirm_account(token)
      assert confirmed_account.confirmed_at
      assert confirmed_account.confirmed_at != account.confirmed_at
      assert ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).confirmed_at
      refute ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not confirm with invalid token", %{account: account} do
      assert ClumsyChinchilla.Users.confirm_account("oops") == :error
      refute ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).confirmed_at
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not confirm email_address if token expired", %{account: account, token: token} do
      {1, nil} = ClumsyChinchilla.Repo.update_all(ClumsyChinchilla.Users.AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      assert ClumsyChinchilla.Users.confirm_account(token) == :error
      refute ClumsyChinchilla.Repo.get!(ClumsyChinchilla.Users.Account, account.id).confirmed_at
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end
  end

  describe "deliver_account_reset_password_instructions/2" do
    setup do
      %{account: account_fixture()}
    end

    test "sends token through notification", %{account: account} do
      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_account_reset_password_instructions(account, url)
        end)

      {:ok, token} = Base.url_decode64(token, padding: false)
      assert account_token = ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, token: :crypto.hash(:sha256, token))
      assert account_token.account_id == account.id
      assert account_token.sent_to == account.email_address
      assert account_token.context == "reset_password"
    end
  end

  describe "get_account_by_reset_password_token/1" do
    setup do
      account = account_fixture()

      token =
        extract_account_token(fn url ->
          ClumsyChinchilla.Users.deliver_account_reset_password_instructions(account, url)
        end)

      %{account: account, token: token}
    end

    test "returns the account with valid token", %{account: %{id: id}, token: token} do
      assert %ClumsyChinchilla.Users.Account{id: ^id} = ClumsyChinchilla.Users.get_account_by_reset_password_token(token)
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: id)
    end

    test "does not return the account with invalid token", %{account: account} do
      refute ClumsyChinchilla.Users.get_account_by_reset_password_token("oops")
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end

    test "does not return the account if token expired", %{account: account, token: token} do
      {1, nil} = ClumsyChinchilla.Repo.update_all(ClumsyChinchilla.Users.AccountToken, set: [inserted_at: ~N[2020-01-01 00:00:00]])
      refute ClumsyChinchilla.Users.get_account_by_reset_password_token(token)
      assert ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end
  end

  describe "reset_account_password/2" do
    setup do
      %{account: account_fixture()}
    end

    test "validates password", %{account: account} do
      {:error, changeset} =
        ClumsyChinchilla.Users.reset_account_password(account, %{
          password: "not valid",
          password_confirmation: "another"
        })

      assert %{
               password: ["should be at least 12 character(s)"],
               password_confirmation: ["does not match password"]
             } = errors_on(changeset)
    end

    test "validates maximum values for password for security", %{account: account} do
      too_long = String.duplicate("db", 100)

      {:error, changeset} =
        ClumsyChinchilla.Users.reset_account_password(account, %{password: too_long})

      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "updates the password", %{account: account} do
      {:ok, updated_account} =
        ClumsyChinchilla.Users.reset_account_password(account, %{password: "new valid password"})

      assert is_nil(updated_account.password)

      assert ClumsyChinchilla.Users.get_account_by_email_address_and_password(
               account.email_address,
               "new valid password"
             )
    end

    test "deletes all tokens for the given account", %{account: account} do
      _ = ClumsyChinchilla.Users.generate_account_session_token(account)

      {:ok, _} =
        ClumsyChinchilla.Users.reset_account_password(account, %{password: "new valid password"})

      refute ClumsyChinchilla.Repo.get_by(ClumsyChinchilla.Users.AccountToken, account_id: account.id)
    end
  end

  describe "inspect/2" do
    test "does not include password" do
      refute inspect(%ClumsyChinchilla.Users.Account{password: "123456"}) =~ "password: \"123456\""
    end
  end
end
