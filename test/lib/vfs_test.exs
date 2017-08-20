defmodule TheScratch.VfsTest do
  use TheScratch.ConnCase

  test "get" do
    content_vfs = TheScratch.Vfs.get("graphql/user")
    {:ok, content_fs} = File.read("web/graphql/user.graphql")

    assert content_vfs == {"graphql/user", content_fs}
  end

  test "get_value!" do
    content_vfs = TheScratch.Vfs.get_value!("graphql/user")
    {:ok, content_fs} = File.read("web/graphql/user.graphql")

    assert content_vfs == content_fs
  end
end
