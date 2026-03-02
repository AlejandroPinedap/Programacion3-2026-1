# ==========================================
# STRUCT USUARIO
# ==========================================

defmodule Usuario do
  # Definimos los campos permitidos
  defstruct [:id, :nombre, :edad]
end

# ==========================================
# MÓDULO CRUD
# ==========================================

defmodule Usuarios do
  alias Usuario

  # CREATE
  def crear(lista, %Usuario{} = usuario) do
    [usuario | lista]
  end

  # READ - Listar todos
  def listar(lista) do
    if Enum.empty?(lista) do
      IO.puts("No hay usuarios registrados.")
    else
      Enum.each(lista, fn usuario ->
        IO.puts("ID: #{usuario.id} | Nombre: #{usuario.nombre} | Edad: #{usuario.edad}")
      end)
    end
  end

  # READ - Buscar por ID
  def buscar(lista, id) do
    Enum.find(lista, fn usuario -> usuario.id == id end)
  end

  # UPDATE
  def actualizar(lista, id, nuevo_nombre, nueva_edad) do
    Enum.map(lista, fn
      %Usuario{id: ^id} = usuario ->
        %Usuario{usuario | nombre: nuevo_nombre, edad: nueva_edad}

      usuario ->
        usuario
    end)
  end

  # DELETE
  def eliminar(lista, id) do
    Enum.reject(lista, fn usuario -> usuario.id == id end)
  end
end

# ==========================================
# MENÚ INTERACTIVO
# ==========================================

defmodule Menu do
  alias Usuario
  alias Usuarios

  def iniciar do
    loop([])
  end

  # Función recursiva que mantiene el estado
  defp loop(usuarios) do
    IO.puts("""
    ==========================
    1. Crear usuario
    2. Listar usuarios
    3. Buscar usuario
    4. Actualizar usuario
    5. Eliminar usuario
    6. Salir
    ==========================
    """)

    opcion = IO.gets("Seleccione una opción: ") |> String.trim()

    case opcion do
      "1" ->
        id = IO.gets("Ingrese ID: ") |> String.trim() |> String.to_integer()
        nombre = IO.gets("Ingrese nombre: ") |> String.trim()
        edad = IO.gets("Ingrese edad: ") |> String.trim() |> String.to_integer()

        usuario = %Usuario{id: id, nombre: nombre, edad: edad}
        nuevos_usuarios = Usuarios.crear(usuarios, usuario)

        IO.puts("Usuario creado correctamente.")
        loop(nuevos_usuarios)

      "2" ->
        Usuarios.listar(usuarios)
        loop(usuarios)

      "3" ->
        id = IO.gets("Ingrese ID a buscar: ") |> String.trim() |> String.to_integer()

        case Usuarios.buscar(usuarios, id) do
          nil ->
            IO.puts("Usuario no encontrado.")

          usuario ->
            IO.puts("Encontrado: #{usuario.nombre}, Edad: #{usuario.edad}")
        end

        loop(usuarios)

      "4" ->
        id = IO.gets("Ingrese ID a actualizar: ") |> String.trim() |> String.to_integer()
        nombre = IO.gets("Nuevo nombre: ") |> String.trim()
        edad = IO.gets("Nueva edad: ") |> String.trim() |> String.to_integer()

        nuevos_usuarios = Usuarios.actualizar(usuarios, id, nombre, edad)

        IO.puts("Usuario actualizado.")
        loop(nuevos_usuarios)

      "5" ->
        id = IO.gets("Ingrese ID a eliminar: ") |> String.trim() |> String.to_integer()

        nuevos_usuarios = Usuarios.eliminar(usuarios, id)

        IO.puts("Usuario eliminado.")
        loop(nuevos_usuarios)

      "6" ->
        IO.puts("Saliendo del programa...")

      _ ->
        IO.puts("Opción inválida.")
        loop(usuarios)
    end
  end
end

# ==========================================
# INICIO DEL PROGRAMA
# ==========================================

Menu.iniciar()
