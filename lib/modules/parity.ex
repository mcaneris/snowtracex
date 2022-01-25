defmodule API.Snowtrace.Parity do
  @moduledoc """
  Provides access to Snowtrace GETH/Parity Proxy API.
  [API Documentation](https://snowtrace.io/apis#proxy)
  """

  use Snowtracex.APIModule

  @module :proxy

  @spec call(binary(), binary()) :: {:ok, any()} | {:error, any()}
  def call(address, data) do
    action = "eth_call"

    params = [
      to: address,
      data: data,
      tag: "latest"
    ]

    Client.request(@module, action, params)
  end

  @spec get_transaction(hash :: binary()) :: {:ok, any()} | {:error, any()}
  def get_transaction(tx_hash) do
    action = "eth_getTransactionByHash"
    params = [txhash: tx_hash]

    Client.request(@module, action, params)
  end
end
