let g:vkmap#col_width = 32
let g:vkmap#outer_padding = 1
let g:vkmap#inner_padding = 8
let g:vkmap#pos = 'float'
let g:vkmap#height = 12

" <Space> mappings {{{
let s:space_nmap = {
      \ 'key': '<Space>',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': ' ', 'dscpt': 'coc-lists'           },
      \   { 'key': ']', 'dscpt': 'coc-list-next'       },
      \   { 'key': '[', 'dscpt': 'coc-list-prev'       },
      \   { 'key': ';', 'dscpt': 'vim-commands'        },
      \   { 'key': ':', 'dscpt': 'vim-command-history' },
      \   { 'key': '/', 'dscpt': 'grep'                },
      \   { 'key': '*', 'dscpt': 'grep-from-selected'  },
      \   { 'key': 'F', 'dscpt': 'workspace-folders'   },
      \   { 'key': 'b', 'dscpt': 'buffers'             },
      \   { 'key': 'c', 'dscpt': 'coc-commands'        },
      \   { 'key': 'e', 'dscpt': 'coc-extensions'      },
      \   { 'key': 'f', 'dscpt': 'files'               },
      \   { 'key': 'g', 'dscpt': 'git-status'          },
      \   { 'key': 'h', 'dscpt': 'help'                },
      \   { 'key': 'k', 'dscpt': 'key-mappings'        },
      \   { 'key': 'l', 'dscpt': 'locationlist'        },
      \   { 'key': 'p', 'dscpt': 'coc-list-resume'     },
      \   { 'key': 'q', 'dscpt': 'quickfix'            },
      \   { 'key': 'r', 'dscpt': 'mru'                 },
      \   { 'key': 's', 'dscpt': 'snippets'            },
      \   { 'key': 'w', 'dscpt': 'words-in-buffer'     },
      \   { 'key': 'y', 'dscpt': 'yank'                },
      \   { 'key': 't', 'dscpt': 'tig', 'leader': 1    },
      \   { 'key': 'd', 'dscpt': 'defx-window'         },
      \   { 'key': 'v', 'dscpt': 'vista-window'        },
      \ ]}

let s:space_t_nmap = {
      \ 'key': '<Space>t',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': 'b', 'dscpt': 'tig-blame' },
      \   { 'key': 't', 'dscpt': 'tig-current-file' },
      \   { 'key': 'p', 'dscpt': 'tig-project' },
      \   { 'key': '/', 'dscpt': 'tig-grep' },
      \   { 'key': '*', 'dscpt': 'tig-grep-cword' },
      \   { 'key': 'r', 'dscpt': 'tig-grep-resume' },
      \ ]}
" }}}

" 'm' mappings {{{
let s:lsp_nmap = {
      \ 'key': 'm',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': '?', 'dscpt': 'diagnostic-info'     },
      \   { 'key': '[', 'dscpt': 'diagnostic-prev'     },
      \   { 'key': ']', 'dscpt': 'diagnostic-next'     },
      \   { 'key': 'A', 'dscpt': 'codeaction'          },
      \   { 'key': 'D', 'dscpt': 'declaration'         },
      \   { 'key': 'F', 'dscpt': 'fix-current'         },
      \   { 'key': 'R', 'dscpt': 'rename'              },
      \   { 'key': 'a', 'dscpt': 'codeaction-selected' },
      \   { 'key': 'd', 'dscpt': 'definition'          },
      \   { 'key': 'f', 'dscpt': 'format'              },
      \   { 'key': 'h', 'dscpt': 'document-hover'      },
      \   { 'key': 'i', 'dscpt': 'implementation'      },
      \   { 'key': 'j', 'dscpt': 'list-location'       },
      \   { 'key': 'L', 'dscpt': 'codelens'            },
      \   { 'key': 'o', 'dscpt': 'document-symbols'    },
      \   { 'key': 'q', 'dscpt': 'list-diagnostics'    },
      \   { 'key': 'r', 'dscpt': 'reference'           },
      \   { 'key': 's', 'dscpt': 'workspace-symbols'   },
      \   { 'key': 't', 'dscpt': 'type-definition'     },
      \ ]}
" }}}

" 's' mappings {{{
let s:s_nmap = {
      \ 'key': 's',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': 'f',  'dscpt': 'easymotion-overwin-f'     },
      \   { 'key': 's',  'dscpt': 'easymotion-overwin-f2'    },
      \   { 'key': 'h',  'dscpt': 'easymotion-linebackward'  },
      \   { 'key': 'j',  'dscpt': 'easymotion-j'             },
      \   { 'key': 'k',  'dscpt': 'easymotion-k'             },
      \   { 'key': 'l',  'dscpt': 'easymotion-lineforward'   },
      \   { 'key': 'n',  'dscpt': 'easymotion-next'          },
      \   { 'key': 'p',  'dscpt': 'easymotion-prev'          },
      \   { 'key': '/',  'dscpt': 'easymotion-sn'            },
      \   { 'key': 'a',  'dscpt': 'sandwich-add'             },
      \   { 'key': 'd',  'dscpt': 'sandwich-delete'          },
      \   { 'key': 'db', 'dscpt': 'sandwich-delete-between'  },
      \   { 'key': 'r',  'dscpt': 'sandwich-replace'         },
      \   { 'key': 'rb', 'dscpt': 'sandwich-replace-between' },
      \   { 'key': '-',  'dscpt': 'window-split'             },
      \   { 'key': '|',  'dscpt': 'window-vsplit'            },
      \   { 'key': '=',  'dscpt': 'window-balance'           },
      \   { 'key': 'c',  'dscpt': 'window-close'             },
      \   { 'key': 'o',  'dscpt': 'window-only'              },
      \   { 'key': 't',  'dscpt': 'window-tabnew'            },
      \   { 'key': 'x',  'dscpt': 'window-clear-buffer'      },
      \   { 'key': 'z',  'dscpt': 'window-toggle-zoom'       },
      \ ]}

" }}}

" <Leader> mappings {{{
let s:leader_nmap = {
      \ 'key': '<Leader>',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': 'J', 'dscpt': 'join-with-chars'      },
      \   { 'key': 'Q', 'dscpt': 'quit-without-saving'  },
      \   { 'key': 'W', 'dscpt': 'save-all-buffers'     },
      \   { 'key': 'a', 'dscpt': 'easy-align'           },
      \   { 'key': 'c', 'dscpt': 'comment', 'leader': 1 },
      \   { 'key': 'q', 'dscpt': 'quit'                 },
      \   { 'key': 't', 'dscpt': 'toggle',  'leader': 1 },
      \   { 'key': 'w', 'dscpt': 'save'                 },
      \   { 'key': 'x', 'dscpt': 'strip-whitespace'     },
      \   { 'key': ';', 'dscpt': ':{command}'           },
      \ ]
      \ }

let s:leader_c_nmap = {
      \ 'key': '<Leader>c',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': 'a', 'dscpt': 'caw:dollarpos:toggle'  },
      \   { 'key': 'b', 'dscpt': 'caw:box:toggle'        },
      \   { 'key': 'c', 'dscpt': 'caw:hatpos:toggle'     },
      \   { 'key': 'w', 'dscpt': 'caw:wrap:toggle'       },
      \   { 'key': '[', 'dscpt': 'caw:jump:comment-prev' },
      \   { 'key': ']', 'dscpt': 'caw:jump:comment-next' },
      \ ]
      \ }

let s:leader_t_nmap = {
      \ 'key': '<Leader>t',
      \ 'mode': 'n',
      \ 'maps': [
      \   { 'key': 'c', 'dscpt': 'cursor-column' },
      \   { 'key': 'h', 'dscpt': 'listchars'     },
      \   { 'key': 'l', 'dscpt': 'line-number'   },
      \   { 'key': 'n', 'dscpt': 'line-number'   },
      \   { 'key': 'p', 'dscpt': 'paste-mode'    },
      \   { 'key': 's', 'dscpt': 'spell-check'   },
      \   { 'key': 'w', 'dscpt': 'wrap-text'     },
      \ ]
      \ }

let s:leader_vmap = {
      \ 'key': '<Leader>',
      \ 'mode': 'v',
      \ 'maps': [
      \   { 'key': 'J', 'dscpt': 'join-with-chars'      },
      \   { 'key': 'Q', 'dscpt': 'quit-without-saving'  },
      \   { 'key': 'W', 'dscpt': 'save-all-buffers'     },
      \   { 'key': 'a', 'dscpt': 'easy-align'           },
      \   { 'key': 'c', 'dscpt': 'comment', 'leader': 1 },
      \   { 'key': 'q', 'dscpt': 'quit'                 },
      \   { 'key': 'w', 'dscpt': 'save'                 },
      \   { 'key': 'x', 'dscpt': 'strip-whitespace'     },
      \   { 'key': ';', 'dscpt': ':{command}'           },
      \ ]}

let s:leader_c_vmap = {
      \ 'key': '<Leader>c',
      \ 'mode': 'v',
      \ 'maps': [
      \   { 'key': 'a', 'dscpt': 'caw:dollarpos:toggle'  },
      \   { 'key': 'b', 'dscpt': 'caw:box:toggle'        },
      \   { 'key': 'c', 'dscpt': 'caw:hatpos:toggle'     },
      \   { 'key': 'w', 'dscpt': 'caw:wrap:toggle'       },
      \ ]}
" }}}

" Register dicts of mappings
let g:vkmap#menus = [
      \ s:space_nmap, s:space_t_nmap,
      \ s:lsp_nmap,
      \ s:s_nmap,
      \ s:leader_nmap, s:leader_c_nmap, s:leader_t_nmap,
      \ s:leader_vmap, s:leader_c_vmap,
      \ ]
