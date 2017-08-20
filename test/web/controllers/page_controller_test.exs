defmodule TheScratch.PageControllerTest do
  use TheScratch.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "The Scratch"
  end
end
