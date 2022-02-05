defmodule Snowtracex.Contracts do
  @moduledoc """
  Provides access to Snowtrace Contracts API.
  [API Documentation](https://snowtrace.io/apis#contracts)
  """

  @module :contract

  use Snowtracex.APIModule

  @spec get_abi(binary()) :: {:ok, map()} | {:error, any()}
  def get_abi(address) do
    Client.request(@module, "getabi", address: address)
    |> case do
      {:ok, "Contract source code not verified"} ->
        {:error, :not_verified}

      {:ok, response} ->
        Jason.decode(response, keys: :atoms)
    end
  end
end
