defmodule API.Snowtrace.Contracts do
  @moduledoc """
  Provides access to Snowtrace Contracts API.
  [API Documentation](https://snowtrace.io/apis#contracts)
  """

  @module :contract

  use Snowtracex.APIModule

  @spec get_contract_abi(binary()) :: {:ok, map()} | {:error, any()}
  def get_contract_abi(address) do
    Client.request(@module, "getabi", address: address)
    |> case do
      {:ok, "Contract source code not verified"} ->
        {:error, :not_verified}

      response ->
        response
    end
  end
end
