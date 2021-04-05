defmodule Database.Models.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :body, :string
    field :kind, :string
    has_many :critiques, Database.Models.Critique
    has_many :answers, Database.Models.Answer
    belongs_to :requisit_answer, Database.Models.Answer, primary_key: true

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:body, :kind])
      |> cast_assoc(:answers, with: &Database.Models.Answer.changeset/2)
      |> cast_assoc(:requisit_answer, with: &Database.Models.Answer.changeset/2)
      |> validate_required([:body, :kind])
  end
end
