defmodule Snowtracex.Blocks do
  @moduledoc """
  Provides access to Snowtrace Blocks API.
  [API Documentation](https://snowtrace.io/apis#blocks)
  """
  alias Snowtracex.Client

  @module :block

  @type address :: WT.Address.t()
  @type timestamp :: integer() | DateTime.t()
  @type block_number :: integer()

  @spec get_block_number_by_timestamp(timestamp :: timestamp()) :: block_number() | nil
  def get_block_number_by_timestamp(timestamp) when is_integer(timestamp) do
    action = "getblocknobytime"
    params = [timestamp: "#{timestamp}", closest: "before"]

    case Client.request(@module, action, params) do
      {:ok, block} ->
        String.to_integer(block)

      _ ->
        nil
    end
  end

  def get_block_number_by_timestamp(timestamp) do
    DateTime.to_unix(timestamp)
    |> get_block_number_by_timestamp()
  end
end
