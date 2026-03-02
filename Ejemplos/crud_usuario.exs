# ===============================================
# DEFINICIÓN DEL STRUCT
# ===============================================

defmodule Usuario do
  defstruct [:id, :nombre, :edad]
end


# ===============================================
# MÓDULO CRUD
# ===============================================

defmodule Usuarios do
  alias Usuario

  # CREATE
  def crear(usuarios, %Usuario{} = nuevo_usuario) do
    [nuevo_usuario | usuarios]
  end

  # READ - Listar todos
  def listar(usuarios), do: usuarios

  # READ - Obtener por ID
  def obtener(usuarios, id) do
    Enum.find(usuarios, fn usuario ->
      usuario.id == id
    end)
  end

  # UPDATE
  def actualizar(usuarios, id, attrs) do
    Enum.map(usuarios, fn
      %Usuario{id: ^id} = usuario ->
        struct(usuario, attrs)

      usuario ->
        usuario
    end)
  end

  # DELETE
  def eliminar(usuarios, id) do
    Enum.reject(usuarios, fn usuario ->
      usuario.id == id
    end)
  end
end


# ===============================================
# MÓDULO PRINCIPAL 
# ===============================================

defmodule Main do
  def run do
    usuarios = []

    u1 = %Usuario{id: 1, nombre: "Ana", edad: 25}
    u2 = %Usuario{id: 2, nombre: "Luis", edad: 30}

    usuarios = Usuarios.crear(usuarios, u1)
    usuarios = Usuarios.crear(usuarios, u2)

    IO.puts("=== LISTA INICIAL ===")
    IO.inspect(Usuarios.listar(usuarios))

    IO.puts("\n=== BUSCAR ID 1 ===")
    IO.inspect(Usuarios.obtener(usuarios, 1))

    usuarios = Usuarios.actualizar(usuarios, 1, %{edad: 26})

    IO.puts("\n=== DESPUÉS DE ACTUALIZAR ===")
    IO.inspect(usuarios)

    usuarios = Usuarios.eliminar(usuarios, 2)

    IO.puts("\n=== DESPUÉS DE ELIMINAR ===")
    IO.inspect(usuarios)
  end
end

# Ejecutamos todo
Main.run()
