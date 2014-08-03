"if v:lang =~ "utf8$" || v:lang =~ "utf-8$"
"   set fileencodings=utf-8,latin1
"endif
set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,chinese
"set fileencoding=gb188030
set langmenu=C
set fileencodings=utf-8,big5,gb2312,gbk,gb18030,utf-16
language messages C

syntax enable
set background=dark
"set background=light
colorscheme solarized
let g:solarized_termcolors=256

"colorscheme  koehler
set guifont=Inconsolata\ 14
let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936 

set nocompatible    " Use Vim defaults (much better!)
set bs=indent,eol,start        " allow backspacing over everything in insert mode
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

set cscopequickfix=s-,c-,d-,i-,t-,e-
"set encoding=utf-8

"-------Code ZheDie-----------------
"set foldcolumn=4
"set foldmethod=indent
"set foldmethod = syntax
"set foldlevel=100

let    Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
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



" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
	set t_Co=8
	set t_Sb=[4%dm
	set t_Sf=[3%dm
endif
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
"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"--------------------
" Function: Remap keys to make it more similar to firefox tab functionality
" Purpose:  Because I am familiar with firefox tab functionality
"--------------------
"map     <C-T>       :tabnew<CR>
"map     <C-N>       :!gvim &<CR><CR>
"map     <C-W>       :confirm bdelete<CR>


"##################################################
"omnicppcomplete
"##################################################
"參見http://easwy.com/blog/archives/advanced-vim-skills-omin-complete/
"for C,驗證方式: 輸入」gui「三個字符，然後按下<CTRL-X CTRL-O>，在vim的狀態行會顯示"OmniCompleteion"，
"表明現在進行的是全能補全，同時會彈出一個下拉菜單，顯示所有匹配的標籤。你可以使用來」CTRL-P「和」CTRL-N「上下選擇，
"在選擇的同時，所選中的項就被放在光標位置，不需要再按回車來把它放在光標位置（像Source Insight那樣）。
"filetype plugin indent on 
"打開預覽窗口會導致下拉菜單抖動，因此我一般都去掉預覽窗口的顯示
"set completeopt=longest,menu
"for C++,確保你已關閉了vi兼容模式，並允許進行文件類型檢測
"set nocp
"filetype plugin on

set completeopt=longest,menu
"let OmniCpp_GlobalScopeSearch = 1 
"let OmniCpp_NamespaceSearch = 1   
"let OmniCpp_DisplayMode = 1
"let OmniCpp_ShowScopeInAbbr = 0
"let OmniCpp_ShowPrototypeInAbbr = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 1

"<F8> 切換搜尋字串highlight
"map <F7> :set hls!<BAR>set hls?<CR>
"<F9> 切換顯示行號
"nmap <F9> :set nu!<CR>
"imap <F9> :set nu!<CR>
"<F10>呼叫TagList
"map <F10> :TlistToggle<CR>
"<F11>開啟torte配色
"map <F11> :color morning<CR>

"垂直分割視窗, 且在左邊開啟檔案管理員介面
"map <F12> :vs<CR>:Explore<CR>
" previous and next  (quickfix)
map <C-P> :cp<CR>
map <C-N> :cn<CR>
""""""""""""""""""""""""""""""""""""""""""""""
""omni completion
""""""""""""""""""""""""""""""""""""""""""""""
set ofu=syntaxcomplete#Complete
imap <silent> ` <C-X><C-O>
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black

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

"------------------------------------------------------------
"  auto complete
"------------------------------------------------------------

let g:acp_completeOption = '.,w,b,u,t,i,k' 


"------------------------------------------------------------
"    snipmate setting
"------------------------------------------------------------
"那麼開頭大寫的字母便會自動 trigger snipmate 的 completion。
:filetype plugin on
let g:acp_behaviorSnipmateLength=1

"------------------------------------------------------------
"   tabbar
"------------------------------------------------------------
map <S-x> <ESC>:call CloseTab()<CR>
func! CloseTab()
	let s:buf_nr = bufnr("%")
	echo s:buf_nr
	exec ":Tbbp "
	exec ":bdelete!".s:buf_nr
endfunction
let g:Tb_MaxSize = 5
let g:Tb_TabWrap = 1
"--------------------------------------------------------------
"Toggle taglist
"--------------------------------------------------------------
nnoremap <silent> <F12> :TlistToggle<CR>
"Trinity: Open and close all the three plugins on the same time
nmap <F8>   :TrinityToggleAll<CR>
"Trinity: Open and close the srcexpl.vim separately
nmap <F9>   :TrinityToggleSourceExplorer<CR>
"Trinity: Open and close the taglist.vim separately
nmap <F10>  :TrinityToggleTagList<CR>
"Trinity: Open and close the NERD_tree.vim separately
nmap <F11>  :TrinityToggleNERDTree<CR> 

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
