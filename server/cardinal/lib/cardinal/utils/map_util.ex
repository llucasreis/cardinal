defmodule Cardinal.Utils.MapUtil do
  def convert_map_string_to_atom(map) do
    map
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end

  def a ||| b do
    Map.merge(a, b)
  end
end
