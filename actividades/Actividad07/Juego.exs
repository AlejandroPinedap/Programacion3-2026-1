defmodule PingPong do

  def jugador(nombre) do
    receive do
      {:mensaje, texto, desde} ->
        IO.puts("#{nombre} recibió: #{texto}")
        :timer.sleep(500)
        send(desde, {:mensaje, "Pong!", self()})
        jugador(nombre)

      :detener ->
        IO.puts("#{nombre} se detiene.")
    end
  end

end

# --- Uso ---
pid_a = spawn(fn -> PingPong.jugador("Jugador A") end)
pid_b = spawn(fn -> PingPong.jugador("Jugador B") end)

# A le manda el primer mensaje a B
send(pid_b, {:mensaje, "Ping!", pid_a})

:timer.sleep(4000)  # dejamos que jueguen un rato

send(pid_a, :detener)
send(pid_b, :detener)
