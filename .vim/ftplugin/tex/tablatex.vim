"""""""""""""""""""""""""""""""""""""""
" TabLaTeX 1.1                        "
"                                     "
" Pedro Diaz (tablatex@cavecanen.org) "
"""""""""""""""""""""""""""""""""""""""

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin= 1


"""""""""""""
" Variables "
"""""""""""""
setlocal timeoutlen=300
setlocal ignorecase


"""""""""""""
" Typefaces "
"""""""""""""
" Bold
imap <buffer> b<Tab>			\textbf{}<Left>
nmap <buffer> <C-C>b			wbi\textbf{<Esc>ea}<Esc>

" Italic
imap <buffer> i<Tab>			\textit{}<Left>
nmap <buffer> <C-C>i			wbi\textit{<Esc>ea}<Esc>

" Smallcaps
imap <buffer> s<Tab>			\textsc{}<Left>
nmap <buffer> <C-C>s			wbi\textsc{<Esc>ea}<Esc>

" Verbatim
imap <buffer> v<Tab>			\verb++<Left>
nmap <buffer> <C-C>v			wbi\verb+<Esc>ea+<Esc>
imap <buffer> V<Tab>			<CR>\begin{verbatim}<CR><CR>\end{verbatim}<UP>

" Typewriter
imap <buffer> t<Tab>			\texttt{}<Left>
nmap <buffer> <C-C>t			wbi\texttt{<Esc>ea}<Esc>

" Underline
imap <buffer> _<Tab>			\underline{}<Left>
nmap <buffer> <C-C>_         wbi\underline{<Esc>ea}<Esc>



""""""""""""""""
" Enumerations "
""""""""""""""""
imap <buffer> I<Tab>			<CR>\begin{itemize}<CR><CR>\end{itemize}<UP><tab>
imap <buffer> E<Tab>			<CR>\begin{enumerate}<CR><CR>\end{enumerate}<UP><tab>
imap <buffer> p<Tab>			<Esc>$o\item{}<Left>



"""""""""""""
" Math mode "
"""""""""""""
imap <buffer> m<Tab>			$$<Left>


"""""""""""
" Tabular "
"""""""""""
imap <buffer> T<Tab>			<CR>\begin{tabular}{}<CR>\end{tabular}<UP><Esc>$i
imap <buffer> -<Tab>			\hline<CR>
inoremap <buffer> &              <space>&<space>



""""""""""""
" Graphics "
""""""""""""
imap <buffer> *<Tab>			\includegraphics[width=cm]{}<Esc>F=a


"""""""""""""""""
" Double quotes "
"""""""""""""""""
imap <buffer> "				``''<Left><Left>
inoremap <buffer> \"			"
nmap <buffer> <C-C>"			wbi``<Esc>ea''<Esc>



"""""""""""""""""
" Text position "
"""""""""""""""""
imap <buffer> L<Tab>			\begin{flushleft}<CR><CR>\end{flushleft}<UP>
nmap <buffer> <C-C>L			O\begin{flushleft}<Esc><down>o\end{flushleft}<UP>

imap <buffer> R<Tab>			\begin{flushright}<CR><CR>\end{flushright}<UP>
nmap <buffer> <C-C>R			O\begin{flushright}<Esc><down>o\end{flushright}<UP>

imap <buffer> C<Tab>			\begin{center}<CR><CR>\end{center}<UP>
nmap <buffer> <C-C>C			O\begin{center}<Esc><down>o\end{center}<UP>




"""""""""""""""""""
" New environment "
"""""""""""""""""""
imap <buffer> N<Tab>			<Esc>:call InsertEnv()<CR>

function! InsertEnv() 
	let s:t = input( "Environment? " )
	execute "normal o\\begin{".s:t."}\<CR>\<CR>\\end{".s:t."}\<UP>\<Esc>"
endfunction


""""""""
" Misc "
""""""""
vmap <buffer> %			:s/^/% <CR>
imap <buffer> <Del><Tab>		<Esc>F{d%a{}<Left>


""""""""""""
" Movement "
""""""""""""

" In/out of braces
imap <buffer> }<Tab>		<Esc>f}a<space>
imap <buffer> {<Tab>		<Esc>F{bi

" In/out of environments
imap <buffer> ]<Tab>		<Esc>/\\end{.*}<cr>f}a
map <buffer> ]				/\\end{.*}<cr>f}

imap <buffer> [<Tab>		<Esc>?\\begin{.*}<cr>i
map <buffer> [				?\\begin{.*}<cr>



"""""""""""
" Folding "
"""""""""""

" Environment folding
map <buffer> e< 			<Esc>[v]zf
map <buffer> e>             zd             


"""""""""""""""""""""""
" Compiling & viewing "
"""""""""""""""""""""""
map <buffer> <F5>		<Esc>:w<cr>:!xterm -e make clean all &<cr><cr>
map <buffer> <F9>        <Esc>:!gv *.ps&<cr>

