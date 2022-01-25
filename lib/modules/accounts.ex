defmodule Snowtracex.Accounts do
  @moduledoc """
  Provides access to Snowtrace Accounts API.
  [API Documentation](https://snowtrace.io/apis#accounts)
  """

  use Snowtracex.APIModule

  @module :account

  @spec get_logs(binary(), atom()) :: {:ok, list(any())} | {:error, any()}
  def get_logs(address, :normal), do: get_logs(address, "txlist")
  def get_logs(address, :internal), do: get_logs(address, "txlistinternal")
  def get_logs(address, :ERC20), do: get_logs(address, "tokentx")
  def get_logs(address, :ERC721), do: get_logs(address, "tokennfttx")

  def get_logs(address, action) when is_binary(action) do
    params = [address: address, sort: "asc"]

    Client.request(@module, action, params)
  end
end
