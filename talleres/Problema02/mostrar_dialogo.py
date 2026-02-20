import sys
import tkinter as tk
from tkinter import simpledialog, messagebox

root = tk.Tk()
root.withdraw()

if len(sys.argv) > 1 and sys.argv[1] == "input":
    mensaje = sys.argv[2]
    respuesta = simpledialog.askstring("Entrada", mensaje)
    if respuesta is None:
        respuesta = ""
    print(respuesta)

elif len(sys.argv) > 2 and sys.argv[1] == "mensaje":
    messagebox.showinfo("Información", sys.argv[2])