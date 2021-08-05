local indent = require("snippets.utils").match_indentation

local M = {}

function M.get_snippets()
  return {
    func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]],
    req = [[local ${2:${1|S.v:match"%w+$"}} = require('$1')]],
    ["local"] = [[local ${2:${1|S.v:match"[^.]+$"}} = ${1}]],
    ["if"] = indent [[
if $1 then
  $0
end]],
    ["for"] = indent [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
	$0
end]],
    fori = indent [[
for ${1:i} = ${2:1}, ${3:#t} do
	$0
end]],
    forp = indent [[
for ${1:k}, ${2:v} in pairs(${3:t}) do
	$0
end]],

    -- Neovim specific.
    cmd = "vim.cmd [[$0]]",

    -- Busted (unit test framework) helpers
    describe = indent [[
describe('$1', function()
  $0
end)]],
    it = indent [[
it('$1', function()
  $0
end)]],
  }
end

return M
