set number               " Muestra los números de línea
set mouse=a              " Habilita el uso del ratón en todas las modalidades
set numberwidth=1        " Establece el ancho mínimo de la columna de números de línea
set clipboard=unnamed    " Usa el portapapeles del sistema para copiar/pegar
syntax enable            " Habilita el resaltado de sintaxis
set showcmd              " Muestra el comando actual en la parte inferior
set ruler                " Muestra la posición del cursor todo el tiempo
set cursorline           " Resalta la línea donde está el cursor
set showmatch            " Resalta los paréntesis y corchetes emparejados
set sw=2                 " Establece el ancho de tabulación a 2 espacios
set relativenumber       " Muestra números de línea relativos
let g:python3_host_prog = '/usr/local/bin/python3'  " Especifica la ruta del intérprete de Python 3


so ~/.config/nvim/plugins.vim        " Carga el archivo de configuración de plugins
so ~/.config/nvim/maps.vim           " Carga el archivo de mapeos de teclas
so ~/.config/nvim/plugin-config.vim  " Carga el archivo de configuración de plugins específicos


syntax enable                         " Habilita el resaltado de sintaxis (de nuevo, por redundancia)
set background=dark                   " Establece el fondo oscuro (o light para modo claro)
let g:lightline = {}                  " Inicializa la configuración de Lightline (barra de estado)

" Indicador de comprobación
" Indicador de información
" Indicador de advertencias
" Indicador de errores
" Indicador de estado OK
 
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',   
      \  'linter_infos': 'lightline#ale#infos',         
      \  'linter_warnings': 'lightline#ale#warnings',   
      \  'linter_errors': 'lightline#ale#errors',       
      \  'linter_ok': 'lightline#ale#ok',               
      \ }
colorscheme gruvbox

