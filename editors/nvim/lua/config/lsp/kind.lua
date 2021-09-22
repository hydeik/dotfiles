local M = {}

-- Completion kinds (icons for pum)
M.icons = {
  Text = " [text]",
  Method = "Ƒ [method]",
  Function = " [function]",
  Constructor = " [constructor]",
  Field = "ﰠ [field]",
  Variable = " [variable]",
  Class = " [class]",
  Interface = " [interface]",
  Module = " [module]",
  Property = " [property]",
  Unit = " [unit]",
  Value = " [value]",
  Enum = " [enum]",
  Keyword = " [key]",
  Snippet = "﬌ [snippet]",
  Color = " [color]",
  File = " [file]",
  Reference = " [reference]",
  Folder = " [folder]",
  EnumMember = " [enum member]",
  Constant = " [constant]",
  Struct = " [struct]",
  Event = "⌘ [event]",
  Operator = " [operator]",
  TypeParameter = "♛ [type]",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
