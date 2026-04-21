defmodule Buscador do
  def contar([]), do: 0
  def contar([cabeza | cola]) do
    if cabeza == "a" or cabeza == "e" or cabeza == "i" or cabeza == "o" or cabeza == "u" or
       cabeza == "A" or cabeza == "E" or cabeza == "I" or cabeza == "O" or cabeza == "U" do
      1 + contar(cola)
    else
      contar(cola)
    end
  end
end

texto = Enum.at(System.argv(), 0, "Hola")

letras = String.split(texto, "")

resultado = Buscador.contar(letras)

IO.puts("Total de vocales: #{resultado}")
