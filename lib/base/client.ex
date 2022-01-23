defmodule Snowtracex.Client do
  @moduledoc false

  require Logger
  use Tesla

  @base_url "https://api.snowtrace.io/api"

  plug(Tesla.Middleware.BaseUrl, @base_url)
  plug(Tesla.Middleware.JSON)

  @typedoc "Snowtrace API module (i.e. `proxy`)"
  @type api_module ::
          :account | :block | :contract | :logs | :proxy | :stats | :transaction

  @typedoc "Snowtrace API action (i.e. `eth_call`)"
  @type api_action :: binary()

  @typedoc "Snowtrace API parameter (i.e. `fromBlock`)"
  @type api_param :: binary()

  @type api_params :: keyword(api_param())

  @spec request(api_module(), api_action, api_params()) :: {:ok, any()} | {:error, any()}
  def request(module, action, params) do
    query_params = build_params(module, action, params)
    url = Tesla.build_url(@base_url, query_params)

    with {:ok, response} <- Tesla.get(url),
         %{result: result} <- Jason.decode!(response.body, keys: :atoms) do
      {:ok, result}
    else
      {:error, reason} ->
        Logger.error(reason)
        {:error, reason}
    end
  end

  @spec build_params(api_module(), api_action(), api_params()) :: api_params()
  def build_params(module, action, params) do
    [module: Atom.to_string(module), action: action]
    |> Keyword.merge(params)
    |> Keyword.merge(apikey: get_api_key())
  end

  @spec get_api_key() :: binary()
  def get_api_key(), do: Application.fetch_env!(:snowtracex, :api_key)
end
