local M = {}
local indent = require("snippets.utils").match_indentation

function M.get_snippets()
  return {
    ["fn"] = indent [[
fn ${1:func_name}(${2|vim.trim(S.v)}) {
    ${0}
}
]],
    ["fn-"] = indent [[
pub fn ${1:func_name}(${2|vim.trim(S.v)}) -> ${3:()} {
    ${0}
}
]],
    ["pubfn"] = indent [[
pub fn ${1:func_name}(${2|vim.trim(S.v)}) -> ${3:()} {
    ${0}
}
]],
    ["extern crate"] = indent [[
"extern crate ${1:name}"
]],
    ["for"] = indent [[
for ${1:elem} in ${2:iter} {
    $0
}
]],
    ["macro_rules"] = indent [[
macro_rules! $1 {
    ($2) => {
        $0
    }
}
]],
    ["if let"] = indent [[
if let ${1:pattern} = ${2:value} {
    $3
}
]],
    ["deribe"] = indent "#[deribe($1)]",
    ["cfg"] = indent "#[cfg($1)]",
    ["test"] = indent [[
#[test($1)]
fn ${1:test_func_name}() {
    ${0:unimplemented!()}
}
]],
  }
end

return M
