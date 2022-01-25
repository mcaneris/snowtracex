defmodule Snowtracex.APIModule do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Snowtracex.Client
      require Logger
    end
  end
end
