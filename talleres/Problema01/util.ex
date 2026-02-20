defmodule Util do
  def mostrar_mensaje(mensaje) do
    {output, status} = System.cmd("python", ["mostrar_dialogo.py", mensaje])
    IO.puts("Estado: #{status}")
    IO.puts("Salida: #{output}")
  end
end

