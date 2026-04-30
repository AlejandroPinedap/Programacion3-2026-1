defmodule Restaurante do

  # --- COCINERO ---
  def cocinero(nombre) do
    receive do
      {:pedido, plato, mesa, mesero} ->
        IO.puts("  [#{nombre}] preparando '#{plato}' para mesa #{mesa}...")
        tiempo = 1000 + :rand.uniform(2000)
        :timer.sleep(tiempo)
        IO.puts("  [#{nombre}] listo! '#{plato}' para mesa #{mesa}")
        send(mesero, {:listo, plato, mesa})
        cocinero(nombre)

      :cerrar ->
        IO.puts("  [#{nombre}] cierra cocina.")
    end
  end

  # --- MESERO ---
  def mesero(cocineros) do
    receive do
      {:tomar_pedido, plato, mesa} ->
        IO.puts("[Mesero] Mesa #{mesa} pide '#{plato}'")
        cocinero = Enum.random(cocineros)
        send(cocinero, {:pedido, plato, mesa, self()})
        mesero(cocineros)

      {:listo, plato, mesa} ->
        IO.puts("[Mesero] Entregando '#{plato}' a mesa #{mesa}")
        mesero(cocineros)

      :cerrar ->
        IO.puts("[Mesero] cierra turno.")
    end
  end

  # --- RESTAURANTE ---
  def abrir do
    cocineros = [
      spawn(fn -> cocinero("Chef Ana") end),
      spawn(fn -> cocinero("Chef Luis") end)
    ]

    pid_mesero = spawn(fn -> mesero(cocineros) end)

    # Clientes hacen pedidos
    pedidos = [
      {1, "Tacos"},
      {2, "Sopa"},
      {3, "Pizza"},
      {1, "Agua"}
    ]

    Enum.each(pedidos, fn {mesa, plato} ->
      :timer.sleep(300)
      send(pid_mesero, {:tomar_pedido, plato, mesa})
    end)

    # Esperamos que todo se procese
    :timer.sleep(8000)

    # Cerramos todo
    send(pid_mesero, :cerrar)
    Enum.each(cocineros, fn c -> send(c, :cerrar) end)

    IO.puts("\nRestaurante cerrado.")
  end

end

# --- Uso ---
Restaurante.abrir()
