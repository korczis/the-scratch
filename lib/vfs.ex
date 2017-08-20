defmodule TheScratch.Vfs do
  @moduledoc """
  In-Memory Virtual FileSystem

  Caches files in memory for quick retreival
  """

  use GenServer

  require Logger

  def start_link(entries) do
    :ets.new(:vfs, [:set, :protected, :named_table])

    _ = Enum.map(entries, fn(entry) ->
      load_vfs(entry)
    end)

    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get(key) do
    List.first(:ets.lookup(:vfs, key))
  end

  def get_value(key) do
    case List.first(:ets.lookup(:vfs, key)) do
      {_key, value} -> {:ok, value}
      nil -> {:err, "Invalid key"}
    end
  end

  def get_value!(key) do
    {:ok, value} = get_value(key)
    value
  end

  defp load_vfs(entry) do
    {:ok, regex} = Map.fetch(entry, :regex)
    {:ok, vfs_name} = Map.fetch(entry, :name)

    read_files = fn(path) ->
      Logger.debug fn ->
        "#{__MODULE__} Loading #{path}"
      end

      {:ok, content} = File.read(path)
      key = "#{vfs_name}/#{Regex.replace(regex, path, "\\1")}"

      :ets.insert(:vfs, {key, content})
    end

    {:ok, pattern} = Map.fetch(entry, :pattern)

    pattern
      |> Path.wildcard
      |> Enum.map(files, read_files)
  end
end
