defmodule Divi do
  def sumar_lista([]), do: 0

  def sumar_lista([x]) do
    IO.puts("caso base: #{x}")
    x
  end

  def sumar_lista(lista) do
    IO.puts("dividiendo: #{inspect(lista)}")

    mitad = div(length(lista), 2)
    {izq, der} = Enum.split(lista, mitad)

    Process.sleep(500)

    suma_izq = sumar_lista(izq)
    suma_der = sumar_lista(der)

    resultado = suma_izq + suma_der

    IO.puts("combinando #{inspect(izq)} + #{inspect(der)} = #{resultado}")

    resultado
  end
end

resultado = Divi.sumar_lista([1, 2, 3, 4, 5, 6])
IO.puts("RESULTADO FINAL: #{resultado}")
