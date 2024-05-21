let mapleader=" "
" Configuración de Prettier
let g:prettier#autoformat = 1

command! -nargs=0 ReloadInitVim :source $MYVIMRC | echom "Archivo init.vim recargado"

" testing
nnoremap <Leader>if <Plug>(JsFileImport)

nnoremap <Leader>iF <Plug>(JsFileImportList)

nnoremap <Leader>ig <Plug>(JsGotoDefinition)

nnoremap <Leader>iG <Plug>(JsGotoDefinition)

nnoremap <Leader>ip <Plug>(PromptJsFileImport)


function! PrintVariableName()
  let l:var_name = expand('<cword>')
  if &filetype ==# 'python'
    execute "normal! A\<CR>print(\"log:\", " . l:var_name . ")"
  elseif &filetype ==# 'kotlin'
    execute "normal! A\<CR>println(\"log:\", " . l:var_name . ")"
  elseif &filetype ==# 'javascript' || &filetype ==# 'typescript'
    execute "normal! A\<CR>console.log(\"log:\", " . l:var_name . ")"
  else
    execute "normal! A\<CR>log(\"log:\", " . l:var_name . ")"
  endif
endfunction

nnoremap <Leader>l :call PrintVariableName()<CR>

 
nnoremap <Leader>is <Plug>(SortJsFileImport)
"nnoremap <Leader>t :TestNearest<CR>
"nnoremap <Leader>T :TestFile<CR>
"nnoremap <Leader>TT :TestSuite<CR>

" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" quick semi
nnoremap <Leader>; $a;<Esc>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
" shorter commands
cnoreabbrev tree NERDTreeToggle
cnoreabbrev blame Gblame
cnoreabbrev find NERDTreeFind
cnoreabbrev diff Gdiff

" plugs
map <Leader>e :NERDTreeFind<CR>
map <Leader>p :Files<CR>
map <Leader>ag :Ag<CR>

" tmux navigator
" nnoremap <silent> <Leader><C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <Leader>pC-j> :TmuxNavigateDown<cr>
" nnoremap <silent> <Leadepp<C-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <Leader><C-k> :TmuxNavigateUp<cr>
" Usar Alt+h para moverse a la izquierda en tmux
nnoremap <leader>fh :TmuxNavigateLeft<cr>
" Usar Alt+l para moverse a la derecha en tmux
nnoremap <leader>fl :TmuxNavigateRight<cr>
" Usar Alt+j para moverse abajo en tmux
nnoremap <leader>fj :TmuxNavigateDown<cr>

" Usar Alt+k para moverse arriba en tmux
nnoremap <leader>fk :TmuxNavigateUp<cr>

" Método para formatear el documento y eliminar importaciones no utilizadas
" function! FormatAndCleanImports()
  "" Guarda la posición del cursor
  " let save_cursor = getpos('.')
" 
  "" Formatea el documento usando el comando correspondiente según el tipo de archivo
  " if &filetype ==# 'python'
    " silent execute '!autopep8 --in-place --aggressive %'
  " elseif &filetype ==# 'javascript' || &filetype ==# 'typescript' || &filetype ==# 'typescriptreact' || &filetype ==# 'javascriptreact' || &filetype ==# 'astro'
    " silent execute '!prettier --write %'
  " elseif &filetype ==# 'java'
    " silent execute '!java -jar ~/path/to/google-java-format-1.11.0-all-deps.jar --replace %'
  " elseif &filetype ==# 'kotlin'
    " silent execute '!ktlint -F %'
  " else
    " echo "No se ha configurado el formato para este tipo de archivo."
    " return
  " endif
" 
  "" Elimina importaciones no utilizadas (puede variar según el linter o herramienta de formato)
  " if &filetype ==# 'python'
    " silent execute '!isort %'
  " elseif &filetype ==# 'javascript' || &filetype ==# 'typescript' || &filetype ==# 'typescriptreact' || &filetype ==# 'javascriptreact' || &filetype ==# 'astro'
    " silent execute '!prettier --write %'
  " elseif &filetype ==# 'java'
    " silent execute '!java -jar ~/path/to/google-java-format-1.11.0-all-deps.jar --replace %'
  " elseif &filetype ==# 'kotlin'
    " silent execute '!ktlint -F %'
  " endif
" 
  "" Restaura la posición del cursor
  " call setpos('.', save_cursor)
" endfunction

function! FormatAndCleanImports()
  echom "Formateando..."
 " Guarda la posición del cursor
  let save_cursor = getpos('.')

  " Verifica si Prettier está instalado
  if !executable('biome')
    echo "Prettier no está instalado. Por favor, instálalo para formatear el código."
    return
  endif

  " Formatea el documento usando Prettier
  silent !biome format % --write
" 
  " Verifica si ESLint está instalado
  " if executable('eslint')
   " Ejecuta ESLint con la opción --fix para corregir automáticamente el código
    " silent !eslint --fix --max-warnings=0 %
  " else
    " echo "ESLint no está instalado. Por favor, instálalo para eliminar importaciones no utilizadas."
  " endif

  " Restaura la posición del cursor
  call setpos('.', save_cursor)
endfunction


""" Mapeo para llamar al método FormatAndCleanImports cuando se presiona <Space> ga
autocmd FileType * nnoremap <buffer> ga :call FormatAndCleanImports()<CR>

" Remap keys for gotos
"
"
"
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap surround to lowercase s so it does not add an empty space
xmap s <Plug>VSurround
" diagnostics
nnoremap <leader>P :let @*=expand("%")<CR>

" tabs navigation
"map <Leader>h :tabprevious<cr>
"pap <Leader>l :tabnext<cr>
" Cambiar al siguiente buffer con Tab en modo normal
nnoremap <Tab> :bnext<CR>
" Cambiar al buffer anterior con Shift+Tab en modo normal
nnoremap <S-Tab> :bprevious<CR>
" buffers
map <Leader>ob :Buffers<cr>

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>k :m .-2<CR>==
nnoremap <Leader>j :m .+1<CR>==

" faster scrolling
nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>
nmap <Leader>s <Plug>(easymotion-s2)

" git
nnoremap <Leader>G :G<cr>
nnoremap <Leader>gp :Gpush<cr>
nnoremap <Leader>gl :Gpull<cr>

" run current file
nnoremap <Leader>x :!bun %<cr>

" Use <c-space> to trigger completion.
"if &filetype == "javascript" || &filetype == "python"
  "inoremap <c-space> <C-x><C-u>
"else
  inoremap <silent><expr> <c-space> coc#refresh()
"endif


set splitright




inoremap <expr> <space> ParensSpacing()

function! ParensSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<space>\<space>\<left>"
  endif
  
  return "\<space>"
endfunction

inoremap <expr> <BS> ParensRemoveSpacing()

function! ParensRemoveSpacing()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')

  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<bs>\<right>\<bs>"
  endif
  
  if (prevChar == ' ' && afterChar == ' ')
    let prev = col('.') - 2
    let after = col('.') + 1
    let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
    let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
    if (prevChar == '"' && afterChar == '"') ||
  \    (prevChar == "'" && afterChar == "'") ||
  \    (prevChar == "(" && afterChar == ")") ||
  \    (prevChar == "{" && afterChar == "}") ||
  \    (prevChar == "[" && afterChar == "]")
      return "\<bs>\<right>\<bs>"
    endif
  endif
  
  return "\<bs>"
endfunction

inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

" Mapeo de teclas para Enter en modo de inserción
inoremap <expr> <CR> ParensIndent()
function! ParensIndent()
  let prev = col('.') - 1
  let after = col('.')
  let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (prevChar == '"' && afterChar == '"') ||
\    (prevChar == "'" && afterChar == "'") ||
\    (prevChar == "(" && afterChar == ")") ||
\    (prevChar == "{" && afterChar == "}") ||
\    (prevChar == "[" && afterChar == "]")
    return "\<CR>\<ESC>O"
  endif
  
  return "\<CR>"
endfunction
" Usa <Enter> para seleccionar la sugerencia cuando PUM es visible
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


let curly = "}"
inoremap <expr> } CheckNextParens(curly)

let bracket = "]"
inoremap <expr> ] CheckNextParens(bracket)

let parens = ")"
inoremap <expr> ) CheckNextParens(parens)

let quote = "'"
inoremap <expr> ' CheckNextQuote(quote)

let dquote = '"'
inoremap <expr> " CheckNextQuote(dquote)

let bticks = '`'
inoremap <expr> ` CheckNextQuote(bticks)

function CheckNextQuote(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  
  if (afterChar == a:c)
    return "\<right>"
  endif
  if (afterChar == ' ' || afterChar == '' || afterChar == ')' || afterChar== '}' || afterChar == ']')
    return a:c . a:c . "\<left>"
  endif
  if (afterChar != a:c)
    let bticks = '`'
    let dquote = '"'
    let quote = "'"
    if(afterChar == dquote || afterChar == quote || afterChar == bticks)
      return a:c . a:c . "\<left>"
    endif
  endif
  return a:c
endfunction

function CheckNextParens(c)
  let after = col('.')
  let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  if (afterChar == a:c)

    return "\<right>"
  endif
  return a:c
endfunction

set splitright
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "botright split term://zsh"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-j> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-k> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!
  endif
endfunction

nnoremap <Leader>t :call OpenTerminal()<CR>

" Función para comentar y descomentar líneas
function! ToggleComment()
  let l:filetype = &filetype
  let l:line_start = line('.')
  let l:line_end = line('.')

  " Si hay una selección visual, ajusta las posiciones de inicio y fin
  if mode() == 'v' || mode() == 'V'
    let l:line_start = line("'<")
    let l:line_end = line("'>")
  endif

  " Detecta el estilo de comentario según el tipo de archivo
  if l:filetype == 'vim'
    let l:comment_str = '"'
  elseif l:filetype == 'javascript' || l:filetype == 'typescript'
    let l:comment_str = '//'
  elseif l:filetype == 'python'
    let l:comment_str = '#'
  else
    echo "Tipo de archivo no soportado para comentar/descomentar"
    return
  endif

  " Itera sobre las líneas seleccionadas y las comenta o descomenta
  for l:line in range(l:line_start, l:line_end)
    let l:line_content = getline(l:line)
    if l:line_content =~? '^\s*'.l:comment_str.'\s*'
      " Si la línea está comentada, la descomenta
      let l:line_content = substitute(l:line_content, '^\(\s*\)'.l:comment_str.'\s*', '\1', '')
    else
      " Si la línea no está comentada, la comenta
      let l:line_content = substitute(l:line_content, '^\(\s*\)', '\1'.l:comment_str.' ', '')
    endif
    call setline(l:line, l:line_content)
  endfor
endfunction

" Mapea <Space>/ a la función ToggleComment
 nnoremap <silent> <Space>/ :call ToggleComment()<CR>
 xnoremap <silent> <Space>/ :call ToggleComment()<CR>

