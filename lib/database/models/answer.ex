defmodule Database.Models.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :body, :string
    belongs_to :question, Database.Models.Question, primary_key: true
    has_many :critiques, Database.Models.Critique
    has_many :questions, Database.Models.Question, foreign_key: :requisit_answer_id


    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    record
      |> cast(attributes, [:body])
      |> cast_assoc(:questions, with: &Database.Models.Question.changeset/2)
      |> validate_required([:body])
  end
end
