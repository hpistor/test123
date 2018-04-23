defmodule ChatApi.Auth.Auth do
  alias Comeonin.Bcrypt

  import Ecto.Query, warn: false

  def authenticate_user(username, password) do
    query = Ecto.Query.from(u in ChatApi.ChatApi.User, where: u.username == ^username)

    ChatApi.Repo.one(query)
    |> check_password(password)
  end

  defp check_password(nil, _), do: {:error, "incorrect username or password"}

  defp check_password(user, password) do
    IO.inspect(user)
    IO.inspect(password)

    case Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end
end
