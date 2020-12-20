defmodule Job.FetchGooglePlace do
  use Oban.Worker, queue: :google_places

  @impl Oban.Worker
  def perform(%{"id" => id}, _job) do
    record = Database.Repository.get(Database.Models.Establishment, id)

    GoogleMaps.place_details(record.google_place_id)
      |> case do
        # TODO: Move to model
        {:ok, place} -> record |> Ecto.Changeset.change(google_place_data: place) |> Poutineer.Database.Repo.update()
        {:error, exception, reason} -> {:error, {exception, reason}}
      end
  end
end
