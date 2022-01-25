defmodule ClientTest do
  use ExUnit.Case
  doctest Snowtracex.Client

  import Tesla.Mock

  alias Snowtracex.Client

  setup do
    module = :proxy
    action = "eth_call"
    params = [to: "0x", data: "0x"]

    query_params =
      [module: Atom.to_string(module), action: action]
      |> Keyword.merge(params)
      |> Keyword.merge(apikey: "TEST_API_KEY")
      |> Enum.map_join("&", fn {k, v} -> "#{k}=#{v}" end)

    mock(fn
      %{
        method: :get,
        url: "https://api.snowtrace.io/api?" <> ^query_params
      } ->
        %Tesla.Env{status: 200, body: Jason.encode!(%{result: "0x"})}
    end)

    %{args: [module, action, params]}
  end

  test "request/3", %{args: args} do
    {:ok, result} = apply(Client, :request, args)

    assert result === "0x"
  end
end
