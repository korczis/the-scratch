defmodule TheScratch.VfsTest do
  use TheScratch.ConnCase

  test "get_value!" do
    content_vfs = TheScratch.Vfs.get_value!("graphql/user")
    {:ok, content_file} = File.read("web/graphql/user.graphql")

    assert content_vfs == content_file
  end
end
