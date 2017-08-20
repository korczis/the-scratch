defmodule TheScratch.Vfs do
  use GenServer

  require Logger

  def start_link(entries) do
    cache = Enum.reduce(entries, %{}, fn(entry, cache) ->
      {:ok, vfs_name} = Map.fetch(entry, :name)
      Map.put(cache, vfs_name, load_vfs(entry))
    end)

    Logger.debug(inspect(cache))

    # GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

    Task.start_link(fn -> loop(%{}) end)
  end

  def get(key) do
    send(self(), {:get, key})
    nil
  end

  defp load_vfs(entry) do
    {:ok, regex} = Map.fetch(entry, :regex)

    read_files = fn(path, cache) ->
      Logger.debug("#{__MODULE__} Loading #{path}")
      {:ok, content} = File.read(path)
      Map.put(cache, Regex.replace(regex, path, "\\1"), content)
    end

    {:ok, pattern} = Map.fetch(entry, :pattern)
    Path.wildcard(pattern)
      |> Enum.reduce(%{}, read_files)
  end

  defp loop(map) do
    receive do
      key -> Logger.debug("KEY: #{inspect(key)}")
    end
  end
end
