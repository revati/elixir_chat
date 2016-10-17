defmodule Chat.PageController do
  use Chat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def pages(conn, _params) do
    json conn, %{pages: [%{title: "Title", contents: "Contents"}, %{title: "Another title", contents: "Another"}]}
  end
end
