defmodule ClientTest do
  use ExUnit.Case
  doctest Snowtracex.Client

  import Tesla.Mock

  alias Snowtracex.Client

  setup do
    module = :proxy
    action = "eth_call"
    params = [to: "0x", data: "0x"]

    path_params =
      [module: Atom.to_string(module), action: action]
      |> Keyword.merge(params)
      |> Keyword.merge(apikey: "TEST_API_KEY")

    mock(fn
      %{
        method: :get,
        url: "https://api.snowtrace.io/api",
        opts: [path_params: ^path_params]
      } ->
        %Tesla.Env{status: 200, body: %{result: "0x"}}
    end)

    %{args: [module, action, params], path_params: path_params}
  end

  test "request/3", %{args: args} do
    {:ok, %Tesla.Env{} = env} = apply(Client, :request, args)

    assert env.status === 200
    assert env.body.result === "0x"
  end

  test "build_params/3", %{args: args, path_params: path_params} do
    assert apply(Client, :build_params, args) === path_params
  end
end
