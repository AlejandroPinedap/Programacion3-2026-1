defmodule Contador do

  def iniciar do
    spawn(fn -> loop(0) end)
  end

  defp loop(n) do
    receive do
      {:incrementar, desde} ->
        send(desde, :ok)
        loop(n + 1)

      {:valor, desde} ->
        send(desde, {:resultado, n})
        loop(n)

      :detener ->
        IO.puts("Contador detenido en #{n}")
    end
  end

end

# --- Uso ---
pid = Contador.iniciar()

send(pid, {:incrementar, self()}) #self es nuestro proceso acual o que se este corriendo en ese momento.
receive do :ok -> :ok end

send(pid, {:incrementar, self()})
receive do :ok -> :ok end

send(pid, {:incrementar, self()})
receive do :ok -> :ok end

send(pid, {:valor, self()})
receive do
  {:resultado, n} -> IO.puts("El valor es: #{n}")
end

send(pid, :detener)
