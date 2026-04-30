defmodule Carreras do

  defp correr_con_padre(nombre, velocidad, padre) do
    pasos = 5
    Enum.each(1..pasos, fn paso ->
      :timer.sleep(velocidad)
      IO.puts("  #{nombre} — paso #{paso}/#{pasos}")
    end)
    IO.puts(">>> #{nombre} TERMINO! <<<")
    send(padre, {:gano, nombre})
  end

  defp esperar_ganador do
    receive do
      {:gano, nombre} ->
        IO.puts("\n============================")
        IO.puts("GANADOR: #{nombre}")
        IO.puts("============================")
    end
  end

  def abrir do
    padre = self()

    corredores = [
      {"Tortuga",  800},
      {"Liebre",   300},
      {"Caballo",  500},
      {"Caracol", 1200}
    ]

    Enum.each(corredores, fn {nombre, velocidad} ->
      spawn(fn ->
        :timer.sleep(:rand.uniform(200))
        correr_con_padre(nombre, velocidad, padre)
      end)
    end)

    esperar_ganador()
  end

end

Carreras.abrir()
