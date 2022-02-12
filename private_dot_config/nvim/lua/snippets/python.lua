local indent = require("snippets.utils").match_indentation

local M = {}

function M.get_snippets()
  return {
    ["#!"] = "#!/usr/bin/env python3\n$0",
    shbang = "#!/usr/bin/env python3\n$0",
    coding = "# -*- coding: utf-8 -*-",
    class = indent [[
class $1(${2:object}):

    def __init__(self, ${3}):
        ${0:pass}
]],
    dataclass = indent [[
@dataclasses.dataclass
class $1:
    ${0:pass}
]],
    def = indent [[
def ${1:name}(${2|vim.trim(S.v)}) -> ${3:None}:
    ${0:pass}
]],
    defm = indent [[
def ${1:name}(self, ${2|vim.trim(S.v)}) -> ${3:None}:
    ${0:pass}
]],
    ["if"] = indent [[
if $1:
    ${0:pass}
]],
    ["elif"] = indent [[
elif $1:
    ${0:pass}
]],
    ["else"] = indent [[
else:
    ${0:pass}
]],
    ifmain = indent [[
if __name__ == '__main__':
    ${0:pass}
]],
    with = indent [[
with ${1:open}(${2:file}, '${2:r}') as ${3:f}:
    ${0:pass}
]],
    ["try"] = indent [[
try:
    ${1:pass}
except ${2:Exception} as ${3:e}:
    ${4:pass}
]],
    ["while"] = indent [[
while $1:
    ${0:pass}
]],
    property = indent [[
@property
def ${1:name}(self) -> ${2:Any}:
    return $0
]],
    getter = indent [[
@property
def ${1:name}(self) -> ${2:Any}:
    return self._$1
]],
    setter = indent [[
@${1:name}.setter
def $1(self, ${2:value}) -> None:
    self._$1 = $2
]],
    deleter = indent [[
@{$1:name}.deleter
def $1(self) -> None:
    del self._$1
]],
  }
end

return M
