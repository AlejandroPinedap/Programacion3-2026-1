defmodule Estructura do
    def main do

      crear_lista_clientes()
      |>Cliente.escribir_csv("clientes.csv")



      "\ningrese los datos del cliente: "
      |>Cliente.ingresar(:clientes)
      #|>generar_mensaje_clientes()
      |>Cliente.escribir_csv("clientes.csv")
    end

    def generar_mensaje (cliente) do
      altura = cliente.altura |> Float.round(2)
      "Hola #{cliente.nombre},tu edad es de: #{cliente.edad} años y " <>
        "tienes una altura de: #{altura}\n"
    end

    defp generar_mensaje_clientes(lista_clientes) do
      lista_clientes
      |> Enum.map(&generar_mensaje/1)
      |> Enum.join
    end

    defp crear_lista_clientes() do
      [
        Cliente.crear("Ana", 16, 1.70),
        Cliente.crear("Juan", 16, 1.70),
        Cliente.crear("Diana", 16, 1.70),
        Cliente.crear("Isabella", 16, 1.70),
        Cliente.crear("Sara", 16, 1.70),
      ]
    end
end

Estructura.main()
