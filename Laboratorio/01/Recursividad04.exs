defmodule Cadena do
  def mas_larga(lista) do

    Enum.max_by(lista, &String.length/1)
  end
end

datos = ["hola", "recursividad", "programación", "elixir", "computadora"]

ganadora = Cadena.mas_larga(datos)

IO.puts "la cadena mas larga es: #{ganadora}"
IO.puts "tiene una longitud de: #{String.length(ganadora)} caracteres"
