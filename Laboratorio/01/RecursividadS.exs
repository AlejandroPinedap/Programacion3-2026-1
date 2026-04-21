defmodule Ncarac do

  def contar_caracteres([]), do: :ok
  def contar_caracteres([cabeza | cola]) do
    IO.puts(cabeza)
    contar_caracteres(cola)
  end

  def contar([]), do: 0
  def contar([_cabeza | cola]), do: 1 + contar(cola)

end

palabra = String.graphemes("Programacion")

IO.puts("Recorrer")
Ncarac.contar_caracteres(palabra)

IO.puts("\nContar")
IO.puts(Ncarac.contar(palabra))
