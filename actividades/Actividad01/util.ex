defmodule Util do

  # Ingresar texto
  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  # Ingresar entero con validación
  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_integer()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número entero\n"
        |> mostrar_error()

        mensaje
        |> ingresar(:entero)   # llamada recursiva
    end
  end

  # Ingresar real con validación
  def ingresar(mensaje, :real) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_float()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número real\n"
        |> mostrar_error()

        mensaje
        |> ingresar(:real)   # llamada recursiva
    end
  end

  # Mostrar mensaje normal
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  # Mostrar mensaje de error (stderr)
  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

end
