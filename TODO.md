  - [ ] Switch to https://hexdocs.pm/confex/readme.html#content
  - [x] Figure out how we're going to deliver the first html payload
  - [ ] Iterate over every asset in the manifest and create a route for it
  - [ ] Benchmark mode doesnt work for building?
  - [ ] Setup oauth
  - [ ] Rewrite server backend cloudbuild
  - [ ] Rewrite server backend dockerfile
  - [ ] Rewrite server backend kubernetes files
  - [ ] Deploy to GCP
  - [ ] https://www.simonewebdesign.it/how-to-get-the-ast-of-an-elixir-program/
  - [ ] switch from oban to faktory https://github.com/seated/faktory_worker
  - [ ] https://hexdocs.pm/crontab/basic-usage.html#content

## todo

  - elixir
    - [ ] modules
      - [ ] uses
    - [ ] functions
      - [ ] arguments
      - [ ] guard
      - [ ] source
      - [ ] tests
      - [ ] typespecs
      - [ ] traces
    - [ ] package
  - faktory
    - [ ] triggered workers
    - [ ] scheduled workers
  - ecto
    - [ ] models
      - [ ] changesets
      - [ ] fields
      - [ ] relationships
  - database
    - [ ] migrations
    - [ ] tables
      - [ ] table constraints
    - [ ] fields
      - [ ] column constraints
      - [ ] computed table columns
    - [ ] indexes
    - [ ] database views
  - phoenix
    - [ ] routes
    - [ ] configuration
  - graphql
    - [ ] resolvers
    - [ ] mutations
    - [ ] queries
    - [ ] types
    - [ ] input object
    - [ ] subscriptions


```
mix phx.gen.schema \
  Models.DatabaseModel database_models \
  name:text \
  version:integer \
  slug:text:unique

mix phx.gen.schema \
  Models.DatabaseField database_fields \
  type:text \
  name:text \
  version:integer \
  database_model_id:references:database_models \
  slug:text:unique \
  nullable:boolean \
  default:boolean \
  computed:boolean

mix phx.gen.schema \
  Models.DatabaseIndex database_indexes \
  type:text \
  name:text \
  version:integer \
  database_model_id:references:database_models \
  slug:text:unique \
  unique:boolean \
  concurrent:boolean

mix phx.gen.schema \
  Models.DatabaseIndexField database_index_field \
  database_index_id:references:database_indexes \
  database_field_id:references:database_fields

mix phx.gen.schema \
  Models.TriggeredWorker triggered_worker \
  name:text \
  slug:text:unique \
  elixir_function_id:references:elixir_functions

mix phx.gen.schema \
  Models.ScheduledWorker scheduled_worker \
  name:text \
  slug:text:unique \
  \
  elixir_function_id:references:elixir_functions
```
