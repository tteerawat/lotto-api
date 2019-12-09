defmodule LottoAPI.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :uid, :string

    timestamps()
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> encrypt_password()
    |> put_change(:uid, generate_uid())
  end

  defp encrypt_password(%{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, Argon2.hash_pwd_salt(password))
    |> put_change(:password, nil)
  end

  defp encrypt_password(changeset) do
    changeset
  end

  defp generate_uid do
    "user-" <> Ecto.UUID.generate()
  end
end
