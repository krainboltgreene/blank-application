[
  plugins: [HeexFormatter, Surface.Formatter.Plugin],
  import_deps: [:ecto, :phoenix, :surface],
  inputs: ["priv/*/seeds.exs", "{config,lib,test}/**/*.{heex,ex,exs,sface}"],
  subdirectories: ["priv/*/migrations"],
  locals_without_parens: [form_for: 3, form_for: 4, inputs_for: 3, inputs_for: 4]
]
