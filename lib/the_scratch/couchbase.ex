defmodule TheScratch.Couchbase do
  @moduledoc """
  Couchbase Worker
  """

  def add(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:add, id, Poison.encode!(doc)})
      end
    )
  end

  def append(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:append, id, Poison.encode!(doc)})
      end
    )
  end

  def get(id) do
    res = :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:get, id})
      end
    )

    case res do
      {:ok, doc} -> Poison.decode(doc)
      err -> err
    end
  end

  def prepend(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:prepend, id, Poison.encode!(doc)})
      end
    )
  end

  def remove(id) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:remove, id})
      end
    )
  end

  def replace(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:replace, id, Poison.encode!(doc)})
      end
    )
  end

  def set(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:set, id, Poison.encode!(doc)})
      end
    )
  end

  def upsert(id, doc) do
    :poolboy.transaction(
      Gauc.Worker,
      fn(pid) ->
        GenServer.call(pid, {:upsert, id, Poison.encode!(doc)})
      end
    )
  end
end
