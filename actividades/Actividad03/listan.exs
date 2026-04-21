defmodule Impresora do
  def imprimir_lista([]), do: IO.puts("---")

  def imprimir_lista([h | t]) do
    IO.puts("Abriendo capa: #{h}")
    Process.sleep(500)
    imprimir_lista(t)
  end
end

Impresora.imprimir_lista([1, 2, 3, 4, 5])
