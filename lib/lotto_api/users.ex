defmodule LottoAPI.Users do
  alias LottoAPI.{Repo, User}

  def fetch_user_by(params) do
    case Repo.get_by(User, params) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def create_user!(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert!()
  end
end
