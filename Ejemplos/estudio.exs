defmodule Parcial do

  # ----------- MAIN -----------
  def main do
    IO.puts("Suma recursiva:")
    IO.inspect(sumar(5))

    IO.puts("Factorial:")
    IO.inspect(factorial(4))

    IO.puts("Suma de lista:")
    IO.inspect(suma_lista([1,2,3,4]))

    IO.puts("Laberinto (backtracking):")
    laberinto = [
      [0, 0, 1],
      [0, 0, 0],
      [1, 0, 0]
    ]

    IO.inspect(camino?(laberinto, 0, 0))
  end

  # ----------- RECURSIVIDAD BÁSICA -----------

  # suma: 5 + 4 + 3 + 2 + 1 + 0
  def sumar(0), do: 0
  def sumar(n), do: n + sumar(n - 1)

  # factorial: 4 * 3 * 2 * 1
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)

  # ----------- LISTAS -----------

  def suma_lista([]), do: 0
  def suma_lista([h | t]) do
    h + suma_lista(t)
  end

  # ----------- BACKTRACKING (LABERINTO) -----------

  def camino?(matriz, x, y) do
    cond do
      fuera?(matriz, x, y) -> false
      bloqueado?(matriz, x, y) -> false
      meta?(matriz, x, y) -> true
      true ->
        # marcar como visitado
        nueva = marcar(matriz, x, y)

        # explorar 4 direcciones
        camino?(nueva, x + 1, y) or
        camino?(nueva, x, y + 1) or
        camino?(nueva, x - 1, y) or
        camino?(nueva, x, y - 1)
    end
  end

  # ----------- FUNCIONES AUXILIARES -----------

  def fuera?(matriz, x, y) do
    x < 0 or y < 0 or x >= length(matriz) or y >= length(Enum.at(matriz, 0))
  end

  def bloqueado?(matriz, x, y) do
    Enum.at(Enum.at(matriz, x), y) == 1
  end

  def meta?(matriz, x, y) do
    x == length(matriz) - 1 and y == length(Enum.at(matriz, 0)) - 1
  end

  def marcar(matriz, x, y) do
    List.update_at(matriz, x, fn fila ->
      List.update_at(fila, y, fn _ -> 1 end)
    end)
  end

end
Parcial.main()
