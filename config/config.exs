import Config

config :snowtracex, :api_key, ""

import_config "#{config_env()}.exs"
