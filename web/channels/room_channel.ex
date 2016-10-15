defmodule Chat.RoomChannel do
  use Chat.Web, :channel

  intercept ["new_msg", "typing"]

  def join("rooms:lobby", _payload, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "Unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("typing", _, socket) do
    broadcast! socket, "typing", %{body: "typing"}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def handle_out("typing", payload, socket) do
    push socket, "typing", payload
    {:noreply, socket}
  end
end
