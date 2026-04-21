defmodule MatrizRecursiva do
  def recorrer_matriz([]), do: :ok

  def recorrer_matriz([fila | resto_filas]) do
    recorrer_fila(fila)
    IO.puts("")
    recorrer_matriz(resto_filas)
  end

  def recorrer_fila([]), do: :ok

  def recorrer_fila([elemento | resto]) do
    IO.write("#{elemento} ")
    recorrer_fila(resto)
  end


  def imprimir_diagonal(matriz), do: diagonal(matriz, 0)


  defp diagonal([], _i), do: []
  defp diagonal([fila | resto], i) do
    [Enum.at(fila, i) | diagonal(resto, i + 1)]
  end

  def sumar_diagonal2(matriz), do: diagonal(matriz,0)

  defp sumar([], _i), do: []
  defp sumar([fila | resto], i) do
    [Enum.at(fila,i) | diagonal(resto, i + 2)]
  end
end

matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

MatrizRecursiva.recorrer_matriz(matriz)
MatrizRecursiva.imprimir_diagonal(matriz) |> IO.inspect()


