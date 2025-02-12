## INTERFAZ DE CONFIRMACION SIMPLE

Tal y como lo explica su titulo, este sistema muestra una interfaz para confirmar cualquier accion que se requiera. Utilizando funciones `dxDraw` para ello con una animación de entrada y salida simple.

### SYNTAX
`dxConfirm(string title, string description, function funcYes, ...)`

#### <b>title</b> `string` - El titulo que tendrá la interfaz de confirmacion (default: `Confirmación`)
#### <b>description</b> `string` - El mensaje de confirmacion que desee mostrar (default: `¿Estás seguro de que quieres hacer esto?`)
#### <b>funcYes</b> `function` - La funcion que se ejecutará una vez se presione el boton 'Si'.
#### <b>(...)</b> `vars` - Las variables que contiene la funcion que se ejecutará al presionar el botón 'Si'.

### EJEMPLO PRACTICO
```
function myFunction(var1, var2)
    outputChatBox("¡Haz presionado que si!")
    outputChatBox("var1: "..var1)
    outputChatBox("var2: "..var2)
end
dxConfirm("Confirmacion", "¿Estas seguro?", myFunction, "hola mundo!", 15);
```
### IMAGEN DE LA INTERFAZ

![Interfaz de Confirmacion](https://i.imgur.com/ERHthpa.png)