defmodule Server.Sources.Source do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sources" do
    field :body, :string
    field :file_name, :string
    field :exec_result, :string

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:file_name, :body])
    |> validate_required([:file_name, :body])
  end
end
