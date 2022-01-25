defmodule Snowtracex.Blocks do
  @moduledoc """
  Provides access to Snowtrace Blocks API.
  [API Documentation](https://snowtrace.io/apis#blocks)
  """
  use Snowtracex.APIModule

  @module :block

  @type timestamp :: integer() | DateTime.t()

  @spec get_block_number_by_timestamp(timestamp()) ::
          {:ok, integer()} | {:error, any()}
  def get_block_number_by_timestamp(timestamp) when is_integer(timestamp) do
    action = "getblocknobytime"
    params = [timestamp: "#{timestamp}", closest: "before"]

    Client.request(@module, action, params)
    |> case do
      {:ok, block} -> String.to_integer(block)
      error -> error
    end
  end

  def get_block_number_by_timestamp(timestamp) do
    DateTime.to_unix(timestamp)
    |> get_block_number_by_timestamp()
  end
end
