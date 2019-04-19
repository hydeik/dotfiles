"-----------------------------
" Configuration for vkmap.vim
"-----------------------------

" --- Configure variables
let g:vkmap#col_width = 18
let g:vkmap#outer_padding = 1
let g:vkmap#inner_padding = 16
let g:vkmap#floating = 1
let g:vkmap#height = 10

" --- Space mappings
let s:space_map = {
      \ 'key': '<Space>',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'a', 'dscpt': 'diagnostics'   },
      \     { 'key': 'b', 'dscpt': 'buffers'       },
      \     { 'key': 'c', 'dscpt': 'commands'      },
      \     { 'key': 'd', 'dscpt': 'Defx'          },
      \     { 'key': 'e', 'dscpt': 'extensions'    },
      \     { 'key': 'f', 'dscpt': 'files'         },
      \     { 'key': 'j', 'dscpt': 'CocNext'       },
      \     { 'key': 'k', 'dscpt': 'CocPrev'       },
      \     { 'key': 'm', 'dscpt': 'mru'           },
      \     { 'key': 'l', 'dscpt': 'locationlist'  },
      \     { 'key': 'L', 'dscpt': 'lists'         },
      \     { 'key': 'o', 'dscpt': 'outline'       },
      \     { 'key': 'O', 'dscpt': 'symbols'       },
      \     { 'key': 'q', 'dscpt': 'quickfix'      },
      \     { 'key': 'r', 'dscpt': 'CocListResume' },
      \     { 'key': 's', 'dscpt': 'snippets'      },
      \     { 'key': 'y', 'dscpt': 'yank'          },
      \   ]
      \ }

" --- Leader mappings
let s:leader_map = {
      \ 'key': '<Leader>',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'g', 'dscpt': 'git', 'leader': 1    },
      \     { 'key': 'h', 'dscpt': 'hunk', 'leader': 1   },
      \     { 'key': 'J', 'dscpt': 'join with char'      },
      \     { 'key': 'q', 'dscpt': 'quit'                },
      \     { 'key': 'Q', 'dscpt': 'quit!'               },
      \     { 'key': 't', 'dscpt': 'toggle', 'leader': 1 },
      \     { 'key': 'w', 'dscpt': 'write'               },
      \     { 'key': 'W', 'dscpt': 'write all'           },
      \     { 'key': 'x', 'dscpt': 'text', 'leader': 1   },
      \     { 'key': ';', 'dscpt': ':{command}'          },
      \   ]
      \ }

let s:leader_map_g = {
      \ 'key': '<Leader>g',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'A', 'dscpt': 'changes (origin)' },
      \     { 'key': 'b', 'dscpt': 'branch'           },
      \     { 'key': 'c', 'dscpt': 'commit'           },
      \     { 'key': 'C', 'dscpt': 'commit (ammend)'  },
      \     { 'key': 'd', 'dscpt': 'changes (origin)' },
      \     { 'key': 'l', 'dscpt': 'log'              },
      \     { 'key': 'f', 'dscpt': 'ls'               },
      \     { 'key': 's', 'dscpt': 'status'           },
      \     { 'key': 't', 'dscpt': 'tag'              },
      \   ]
      \ }

let s:leader_map_h = {
      \ 'key': '<Leader>h',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'j', 'dscpt': 'next'     },
      \     { 'key': 'k', 'dscpt': 'previous' },
      \     { 'key': 's', 'dscpt': 'stage'    },
      \     { 'key': 'u', 'dscpt': 'undo'     },
      \     { 'key': 'v', 'dscpt': 'preview'  },
      \   ]
      \ }

let s:leader_map_t = {
      \ 'key': '<Leader>t',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'cc', 'dscpt': 'cursor column'   },
      \     { 'key': 'cl', 'dscpt': 'cursor line'     },
      \     { 'key': 'n',  'dscpt': 'line number'     },
      \     { 'key': 'l',  'dscpt': 'listchars'       },
      \     { 'key': 'p',  'dscpt': 'paste mode'      },
      \     { 'key': 'r',  'dscpt': 'relative number' },
      \     { 'key': 's',  'dscpt': 'spell check'     },
      \     { 'key': 'w',  'dscpt': 'wrap text'       },
      \   ]
      \ }

let s:leader_map_x = {
      \ 'key': '<Leader>x',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'a',  'dscpt': 'easy-align'     },
      \     { 'key': 'd',  'dscpt': 'fix whitespace' },
      \   ]
      \ }

" s key mappings
let s:s_map = {
      \ 'key': 's',
      \ 'mode': 'n',
      \ 'maps': [
      \     { 'key': 'f',  'dscpt': 'easymotion-overwin-{char}'       },
      \     { 'key': 's',  'dscpt': 'easymotion-overwin-{char}{char}' },
      \     { 'key': 'h',  'dscpt': 'easymotion-linebackward'         },
      \     { 'key': 'j',  'dscpt': 'easymotion-j'                    },
      \     { 'key': 'k',  'dscpt': 'easymotion-k'                    },
      \     { 'key': 'l',  'dscpt': 'easymotion-lineforward'          },
      \     { 'key': 'n',  'dscpt': 'easymotion-move-next'            },
      \     { 'key': 'p',  'dscpt': 'easymotion-move-prev'            },
      \     { 'key': '/',  'dscpt': 'easymotion-search'               },
      \     { 'key': 'a',  'dscpt': 'sandwich-add'                    },
      \     { 'key': 'd',  'dscpt': 'sandwich-delete'                 },
      \     { 'key': 'db', 'dscpt': 'sandwich-delete-between'         },
      \     { 'key': 'r',  'dscpt': 'sandwich-replace'                },
      \     { 'key': 'rb', 'dscpt': 'sandwich-replace-between'        },
      \     { 'key': '-',  'dscpt': 'window-split-below'              },
      \     { 'key': '|',  'dscpt': 'window-split-right'              },
      \     { 'key': '=',  'dscpt': 'window-balance'                  },
      \     { 'key': 'c',  'dscpt': 'window-close'                    },
      \     { 'key': 'o',  'dscpt': 'window-only'                     },
      \     { 'key': 't',  'dscpt': 'window-tabnew'                   },
      \     { 'key': 'x',  'dscpt': 'window-empty-buffer'             },
      \     { 'key': 'z',  'dscpt': 'windown-toggle-zoom'             },
      \   ]
      \ }

" --- Register dicts
let g:vkmap#menus = [
      \ s:space_map,
      \ s:leader_map,
      \ s:leader_map_g,
      \ s:leader_map_h,
      \ s:leader_map_t,
      \ s:leader_map_x,
      \ s:s_map,
      \ ]
