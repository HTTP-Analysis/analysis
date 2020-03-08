defmodule Analysis.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/^(?!.*\.{2})[a-zA-Z0-9!.#$%&'*+"\/=?^_`{|}~-]+@[a-zA-Z\d\-]+(\.[a-zA-Z]+)*\.[a-zA-Z]+\z/

  schema "users" do
    field :fullname, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, hash_password(password))
      _ ->
        changeset
    end
  end

  def hash_password(password) do
    Bcrypt.hash_pwd_salt(password, [12, true])
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :fullname])
    |> validate_required([:email, :password, :fullname])
    |> unique_constraint(:email, [name: :user_email_unique_index, message: "Email has already been taken."])
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, @email_regex, [message: "Email format isn't valid!"])
    |> validate_length(:password, [min: 6, message: "Password should be at least 6 character(s)."])
    |> encrypt_password
  end
end
