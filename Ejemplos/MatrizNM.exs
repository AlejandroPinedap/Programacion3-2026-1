defmodule Matriz do
  def valor_maximo(matriz) do
    # Aplanamos la matriz en una sola lista y buscamos el máximo
    lista = Enum.concat(matriz)
    Enum.max(lista)
  end
end

# --- Prueba ---
matriz = [
  [3,  7,  2],
  [8,  1, 15],
  [4,  6,  9]
]

resultado = Matriz.valor_maximo(matriz)
IO.puts("Valor máximo: #{resultado}")
