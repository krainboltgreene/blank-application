defmodule Database.Models.Critique do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "critiques" do
    field :guage, :integer
    belongs_to :author_account, Database.Models.Account, primary_key: true
    belongs_to :review, Database.Models.Review, primary_key: true
    belongs_to :answer, Database.Models.Answer, primary_key: true
    belongs_to :question, Database.Models.Question, primary_key: true

    timestamps()
  end

  @doc false
  #@spec changeset (Database.Models.Account.t(), map) :: Ecto.Changeset.t(Database.Models.Account.t())
  def changeset(record, attributes) do
    critique
      |> cast(attributes, [:guage])
      |> validate_required([:guage])
      |> foreign_key_constraint(:author_account_id)
      |> foreign_key_constraint(:review_id)
      |> foreign_key_constraint(:answer_id)
      |> foreign_key_constraint(:question_id)
  end
end
