defmodule API.Snowtrace.Logs do
  @moduledoc """
  Provides access to Snowtrace Logs API.
  [API Documentation](https://snowtrace.io/apis#logs)
  """

  use Snowtracex.APIModule

  @module :logs

  @spec get_event_logs(binary(), binary(), integer() | binary()) ::
          {:ok, list()} | {:error, any()}
  def get_event_logs(address, from_block, to_block) do
    action = "getLogs"

    params = [
      address: address,
      fromBlock: from_block,
      toBlock: to_block
    ]

    Client.request(@module, action, params)
  end

  def get_event_logs(address, from_block), do: get_event_logs(address, from_block, "latest")
end
