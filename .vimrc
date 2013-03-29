" .vimrc
" vim 設定ファイル

"文字コードの識別 (http://www.kawaz.jp/pukiwiki/?vim)
if &encoding !=# 'utf-8'
  set encoding=japan
endif
set fileencoding=japan
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','.  s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      let &encoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif

set fileformats=unix,dos,mac "改行コードの自動判別。 新規ファイルでは最初の改行コードが使用される?
set autoindent		"オートインデントする
set ignorecase		"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase		"検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan 		"検索時に最後まで行ったら最初に戻る
"set number		"行番号表示
"set tabstop=4		"タブ幅を４文字にする
"set shiftwidth=4	"cindentやautoindent時に挿入されるタブの幅（tabstop と揃えておくと良い）
set showmatch		"括弧入力時の対応する括弧を表示
syntax on		"シンタックスハイライトを有効にする
set laststatus=2	"ステータスラインを常に表示
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set list		"TAB, EOLの表示
