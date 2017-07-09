defmodule WebSpa.PageControllerTest do
  use WebSpa.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Web SPA"
  end
end
