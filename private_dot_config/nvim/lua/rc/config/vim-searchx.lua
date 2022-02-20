local M = {}

function M.setup()
  -- Overwrite / and ?.
  vim.keymap.set({ "n", "x" }, "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>")
  vim.keymap.set({ "n", "x" }, "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>")
  vim.keymap.set("n", "'", "<Cmd>call searchx#select()<CR>)")
  -- Move to next/prev match
  vim.keymap.set({ "n", "x" }, "N", "<Cmd>call searchx#prev_dir()<CR>")
  vim.keymap.set({ "n", "x" }, "n", "<Cmd>call searchx#next_dir()<CR>")
  vim.keymap.set({ "n", "x", "c" }, "<C-j>", "<Cmd>call searchx#next()<CR>")
  vim.keymap.set({ "n", "x", "c" }, "<C-k>", "<Cmd>call searchx#prev()<CR>")
  -- Clear highlights
  vim.keymap.set("n", "<Esc><Esc>", "<Cmd>call searchx#clear()<CR>)")
end

function M.config()
  vim.api.nvim_exec(
    [=[
    let g:searchx = {}
    " Auto jump if the recent input matches to any marker.
    let g:searchx.auto_accept = v:true
    " The scrolloff value for moving to next/prev.
    let g:searchx.scrolloff = &scrolloff
    " To enable scrolling animation.
    let g:searchx.scrolltime = 500
    " To enable auto nohlsearch after cursor is moved
    let g:searchx.nohlsearch = {}
    let g:searchx.nohlsearch.jump = v:true
    " Marker characters.
    let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')
    " Convert search pattern.
    function g:searchx.convert(input) abort
      if a:input !~# '\k'
        return '\V' .. a:input
      endif
      return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
    endfunction
    " Set highlight for markers
    highlight! link SearchxMarker DiffChange
    highlight! link SearchxMarkerCurrent WarningMsg
  ]=],
    false
  )
end

return M
