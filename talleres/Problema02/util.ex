defmodule Util do

  def mostrar_mensaje(mensaje) do
    System.cmd("python", ["mostrar_dialogo.py", "mensaje", mensaje])
  end

  def ingresar(mensaje, :texto) do
    case System.cmd("python", ["mostrar_dialogo.py", "input", mensaje]) do
      {output, 0} ->
        String.trim(output)

      {_, _} ->
        nil
    end
  end

end
