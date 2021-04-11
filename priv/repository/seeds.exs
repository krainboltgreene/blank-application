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

Database.Models.Permission.create(%{
  name: "Administrator"
})
Database.Models.Permission.create(%{
  name: "Default"
})

krainboltgreene =
  Database.Models.Account.create(%{
    name: "Kurtis Rainbolt-Greene",
    email_address: "kurtis@clumsy-chinchilla.club",
    username: "krainboltgreene",
    password: "password"
  })
alabaster =
  Database.Models.Account.create(%{
    name: "Alabaster Wolf",
    email_address: "alabaster@clumsy-chinchilla.club",
    username: "alabaster",
    password: "password"
  })

{:ok, _} =
  Database.Models.Organization.create(%{
    name: "Default"
  })

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
], fn name -> Database.Models.Diet.create(%{name: name}))

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
], fn name -> Database.Models.Allergy.create(%{name: name}))

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
], fn name -> Database.Models.PaymentType.create(%{name: name}))

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
  fn question -> Database.Models.Question.create(question) end
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
  fn establishment -> Database.Models.Establishment.create(question) end
)

krainboltgreene |> Core.Organization.join(default_organization, "administrator")
alabaster |> Core.Organization.join(default_organization)
=======
Core.Organization.join(krainboltgreene, "default", "administrator")
Core.Organization.join(alabaster, "default")=
