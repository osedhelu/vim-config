# Bienvenido a tu Markdown Elegante

## Características principales

Este archivo demuestra todas las características de renderizado elegante de Markdown en Neovim.

### Encabezados

Aquí puedes ver los títulos con iconos bonitos en diferentes niveles.

#### Nivel 4
##### Nivel 5
###### Nivel 6

---

## Listas

### Lista desordenada

- Item principal
  - Subitem
    - Sub-subitem
      - Nivel 4

### Listas con checkboxes

- [x] Tarea completada
- [ ] Tarea pendiente
- [x] Otra tarea hecha
- [ ] Trabajo en progreso

### Lista ordenada

1. Primer item
2. Segundo item
3. Tercer item

---

## Código

Aquí hay ejemplos de código con renderizado bonito:

```javascript
function saludar(nombre) {
  console.log(`¡Hola, ${nombre}!`);
  return nombre.toUpperCase();
}
```

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

```lua
local function setup_keybinds()
  vim.keymap.set('n', '<Leader>md', '<cmd>MarkdownPreview<CR>')
end
```

---

## Citas

> Esta es una cita importante
> que puede ocupar múltiples líneas
> y se verá elegante con un borde visual

> Otra cita más corta

---

## Tablas

| Característica | Estado | Descripción |
|---|---|---|
| Encabezados | ✅ | Renderizados con iconos |
| Código | ✅ | Con bordes y resaltado |
| Listas | ✅ | Soporte completo |
| Checkboxes | ✅ | Interactivos |
| Enlaces | ✅ | Con iconos especiales |

---

## Enlaces e imágenes

[Haz clic aquí para ir a Google](https://google.com)

[Link interno](#bienvenido-a-tu-markdown-elegante)

---

## Estilos de texto

**Texto en negrita** para énfasis

*Texto en cursiva* para diferenciación

***Texto en negrita y cursiva***

~~Texto tachado~~ para indicar cambios

`Código inline` para snippets pequeños

---

## Latex

$$
E = mc^2
$$

Inline: $a^2 + b^2 = c^2$

---

## Atajos útiles

- `<Leader>mdp` - Abrir vista previa en navegador
- `<Leader>mds` - Detener vista previa
- `<Leader>mdt` - Alternar renderizado de Markdown
- `<Space>` + espera para ver todos los atajos disponibles

---

Disfruta de tu nueva experiencia de Markdown elegante en Neovim! 🎨
