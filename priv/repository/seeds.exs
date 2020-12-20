# Script for populating the database. You can run it as:
#
#     mix run priv/repository/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repository.insert!(%Database.Model.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Script for populating the database. You can run it as:
#
#     mix run priv/repository/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repository.insert!(%Database.Model.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  @moduledoc false
  def create_record(attributes, model) do
    struct(model)
    |> model.changeset(attributes)
    |> Database.Repository.insert!()
  end

  def assign_membership(account, organization, permission) do
    %{
      organization_membership:
        %{
          account: account,
          organization: organization
        }
        |> create_record(Database.Models.OrganizationMembership),
      permission: permission
    }
    |> create_record(Database.Models.OrganizationPermission)
  end
end

administrator_permissions =
  %{
    name: "Administrator"
  }
  |> Seeds.create_record(Database.Models.Permission)

dater_permissions =
  %{
    name: "Dater"
  }
  |> Seeds.create_record(Database.Models.Permission)

users_organization =
  %{
    name: "Users"
  }
  |> Seeds.create_record(Database.Models.Organization)

krainboltgreene =
  %{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  }
  |> Seeds.create_record(Database.Models.Account)

alabaster =
  %{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  }
  |> Seeds.create_record(Database.Models.Account)

krainboltgreene |> Seeds.assign_membership(users_organization, administrator_permissions)
alabaster |> Seeds.assign_membership(users_organization, dater_permissions)


Enum.each([
  "Diabetic",
  "Gluten-Free",
  "Halal",
  "Hindu",
  "Kosher",
  "Low-Calorie",
  "Low-Fat",
  "Low-Lactose",
  "Low-Salt",
  "Vegan",
  "Vegetarian"
], fn name -> %Database.Models.Diet{} |> Database.Models.Diet.changeset(%{name: name}) |> Database.Repository.insert_or_update!() end)

Enum.each([
  "Cow's Milk",
  "Peanuts",
  "Eggs",
  "Shellfish",
  "Fish",
  "Tree Nuts",
  "Soy",
  "Wheat",
  "Rice",
  "Fruit"
], fn name -> %Database.Models.Allergy{} |> Database.Models.Allergy.changeset(%{name: name}) |> Database.Repository.insert_or_update!() end)

Enum.each([
  "Cash",
  "Check",
  "Visa",
  "Discover Card",
  "Mastercard",
  "EBT/Foodstamps",
  "Giftcards",
  "Online Payments",
  "Bitcoin/Cryptocurrency"
], fn name -> %Database.Models.PaymentType{} |> Database.Models.PaymentType.changeset(%{name: name}) |> Database.Repository.insert_or_update!() end)

Enum.each(
  [
    %{
      body: "What kind of fries did you eat?",
      kind: "pick_one",
      answers: [
        %{body: "Sweet Potato"},
        %{body: "Steak"},
        %{body: "Shoestring"},
        %{body: "Curly"},
        %{body: "Classic Cut"},
        %{body: "Wedge Cut"},
        %{body: "Slap Chips"},
        %{body: "Tornado"},
        %{body: "Waffle Cut"},
        %{body: "Crinkle Cut"}
      ]
    },
    %{
      body: "How was the cheese prepared?",
      kind: "pick_one",
      answers: [
        %{
          body: "Curds",
          questions: [
            %{
              body: "How many cheese curds were there?",
              kind: "pick_one",
              answers: [
                %{body: "Very sparse"},
                %{body: "A handful"},
                %{body: "A solid layer"}
              ]
            },
            %{
              body: "Did the cheese curds squeak when bitten?",
              kind: "pick_one",
              answers: [
                %{body: "Yes"},
                %{body: "No"}
              ]
            }
          ]
        },
        %{body: "Shredded"},
        %{body: "Sliced"}
      ]
    },
    %{
      body: "Was the cheese Dairy or Vegan?",
      kind: "pick_one",
      answers: [
        %{body: "Dairy"},
        %{body: "Vegan"}
      ]
    }
  ],
  fn question -> %Database.Models.Question{} |> Database.Models.Question.changeset(question) |> Database.Repository.insert_or_update!() end
)

Enum.each(
  [
    %{
      name: "Smoke's Poutinerie",
      google_place_id: "ChIJLbNPx9E0K4gRIpDVnhmgUb8",
      menu_items: [
        %{
          name: "Traditional",
          body: "Smoke’s Signature Gravy, Québec Cheese Curd",
        }
      ]
    }
  ],
  fn establishment -> %Database.Models.Establishment{} |> Database.Models.Establishment.changeset(establishment) |> Database.Repository.insert_or_update!() end
)
