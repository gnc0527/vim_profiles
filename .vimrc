"if v:lang =~ "utf8$" || v:lang =~ "utf-8$"
"   set fileencodings=utf-8,latin1
"endif
set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,chinese
"set fileencoding=gb188030
set fileencoding=utf-8
set langmenu=C
set fileencodings=ucs-bom,utf-8,cp950,big5,gb18030,euc-jp,euc-kr,latin1
language messages C
filetype off

syntax enable
set background=dark
"set background=light
colorscheme solarized
"colorscheme koehler
set guifont=monospace\ 12 " for Linux

let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936 

set nocompatible    " Use Vim defaults (much better!)
set bs=indent,eol,start        " allow backspacing over everything in insert modeset
"set ai            " always set autoindenting on
"set backup        " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
            " than 50 lines of registers
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set cindent
set ts=4
set shiftwidth=4
syntax on
syntax enable

set cursorline
hi clear CursorLine
hi CursorLine gui=underline 
"hi cursorline guibg=#333333 
hi CursorColumn guibg=#333333

" status line appearance (??????)
"set laststatus=2 
"set statusline=
"set statusline=%4*%<\ %1*[%F] 
"set statusline+=%4*\ %5*[%{&encoding}, " encoding 
"set statusline+=%{&fileformat}]%m " file format 
"set statusline+=%4*%=\ \ %3*%l%4*/%L,\ %3*%c%4*\ \<\0x%02B\> 

"set encoding=utf-8
"##############################################################
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"##############################################################
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
	set t_Co=8
	set t_Sb=[4%dm
	set t_Sf=[3%dm
endif

let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

source /home/$USER/.vim/vundle.sh


"--------------------------------------------------------------
"    fuzzy finder
"--------------------------------------------------------------
"    FuzzyFinder 提供下列命令:
"
"	        FufBuffer      -  Buffer mode (fuf-buffer-mode)
"	        FufFile        -  File mode (fuf-file-mode)
"	        FufDir         -  Directory mode (fuf-dir-mode)
"	        FufMruFile     -  MRU-File mode (fuf-mrufile-mode)
"	        FufMruCmd      -  MRU-Command mode (fuf-mrucmd-mode)
"	        FufBookmark    -  Bookmark mode (fuf-bookmark-mode)
"	        FufTag         -  Tag mode (fuf-tag-mode)
"	        FufTaggedFile  -  Tagged-File mode (fuf-taggedfile-mode)
"	        FufJumpList    -  Jump-List mode (fuf-jumplist-mode)
"	        FufChangeList  -  Change-List mode (fuf-changelist-mode)
"	        FufQuickfix    -  Quickfix mode (fuf-quickfix-mode)
"	        FufLine        -  Line mode (fuf-line-mode)
"	        FufHelp        -  Help mode (fuf-help-mode)
"
"	    你可將常用命令 map 至快捷鍵，例如:
"		nnoremap <leader>ff  :FufFile<CR>
"		nnorempa <leader>fb  :FufBuffer<CR>
"		...
"		以此類推。
"		呼叫 FuzzyFinder 搜尋視窗之後，操作方式如下:
"		Ctrl-n , Ctrl-p 上下選擇項目
"	    Ctrl-j          開啟該檔案到水平分割視窗
"	    Ctrl-k          開啟該檔案到垂直分割視窗
"	    Ctrl-l          開啟檔案至新分頁
"       Ctrl-\ Ctrl-\   切換搜尋模式 ( fuzzy matching 或 partial matching )
nnoremap <leader>fb :FufBuffer<CR>
nnoremap <leader>ff :FufFile<CR>
nnoremap <leader>fl :FufLinel<CR>
nnoremap <leader>fd :FufDir<CR>
nnoremap <leader>ft :FufTag! <C-r>=expand('<cword>')<CR><CR>


"-------Code ZheDie-----------------
"set foldcolumn=4
"set foldmethod=indent
"set foldmethod = syntax
"set foldlevel=100


set cscopequickfix=s-,c-,d-,i-,t-,e-


" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
"au BufEnter /* call LoadCscope()
"
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
	call LoadCscope()
"   " add any database in current directory
"   if filereadable("cscope.out")
"      cs add cscope.out
"   " else add database pointed to by environment
"   elseif $CSCOPE_DB != ""
"      cs add $CSCOPE_DB
"   endif
   set csverb
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

"------------------------------------------------------------
"   tabbar
"------------------------------------------------------------
" 切換至下個視窗 Ctrl-Tab
" 切換至上個視窗 Ctrl-Shift-Tab
" 切換至第n個視窗(n為數字0-9) Alt-n
"

map <S-x> <ESC>:call CloseTab()<CR>
func! CloseTab()
	let s:buf_nr = bufnr("%")
	echo s:buf_nr
	exec ":Tbbp "
	exec ":bdelete!".s:buf_nr
endfunction
let g:Tb_MaxSize = 5
let g:Tb_TabWrap = 1


""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
"if MySys() == "windows"                "設定windows系統中ctags程序的位置
 "  let Tlist_Ctags_Cmd = 'ctags'
"elseif MySys() == "linux"              "設定linux系統中ctags程序的位置
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"endif
let Tlist_Show_One_File = 1       "不同時顯示多個文件的tag，只顯示當前文件的
let Tlist_Exit_OnlyWindow = 1      "如果taglist窗口是最後一個窗口，則退出vim
let Tlist_Use_Left_Window = 1         "在右側窗口中顯示taglist窗口 =
"--------------------------------------------------------------
"Toggle taglist
"--------------------------------------------------------------
nnoremap <silent> <F12> :TlistToggle<CR>

"--------------------------------------------------------------
"Toggle Trinity
"--------------------------------------------------------------
"Trinity: Open and close all the three plugins on the same time
nmap <F8>   :TrinityToggleAll<CR>
"Trinity: Open and close the srcexpl.vim separately
nmap <F9>   :TrinityToggleSourceExplorer<CR>
"Trinity: Open and close the taglist.vim separately
nmap <F10>  :TrinityToggleTagList<CR>
"Trinity: Open and close the NERD_tree.vim separately
nmap <F11>  :TrinityToggleNERDTree<CR> 

"--------------------------------------------------------------
"Toggle ctags
"--------------------------------------------------------------
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

