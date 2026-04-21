defmodule Matru do

  N_matru =
    "Ingrese cuántas matrushka: "
      |> Util.ingresar(:entero)


  def imprimirmatru(N_matru) when N_matru > 0 do

    for i <- N_matru..1 do
      IO.puts("Abreindo la matru #{i}")
    end
      for i <- 1..N_matru  do
        IO.puts("cerrando matru #{i}")
      end
    end

    def imprimirmatru2(N_matru) when N_matru > 0 do
      IO.puts("imprimir matru #{N_matru}")
      imprimirmatru2(N_matru - 1)
      IO.puts("cerrar #{n}")
    end
end

Matru.main()

#imprimir 1 lista de numeros de manera recursiva.
