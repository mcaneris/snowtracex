defmodule Snowtracex.Module do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Snowtracex.Client
    end
  end
end
