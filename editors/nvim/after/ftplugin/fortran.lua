local ext = vim.fn.expand "%:e"
-- fixed or free format
if ext == "f" or ext == "for" then
  vim.b.fortran_free_source = 0
  vim.b.fortran_fixed_source = 1
else
  vim.b.fortran_free_source = 1
  vim.b.fortran_fixed_source = 0
end
-- Folding
vim.b.fortran_fold = 1
vim.b.fortran_fold_conditionals = 1
vim.b.fortran_fold_multilinecomments = 1
-- Indent do-enddo block
vim.b.fortran_do_enddo = 1
