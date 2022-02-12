local M = {}
local indent = require("snippets.utils").match_indentation

function M.get_snippets()
  return {
    ["#!"] = "#!/bin/sh\n$0",
    shbang = "#!/bin/sh\n$0",
    env = "#!/usr/bin/env $1",
    coding = "# -*- coding: utf-8 -*-",
    ["if"] = indent [[
if [ ${1} ]; then
    $0
fi
]],
    el = indent [[
else
    $0
]],
    elif = indent [[
elif [ $1 ]; then
    $0
]],
    ["for"] = indent [[
for $1 in $2; do
    $0
done
]],
    ["while"] = indent [[
while $1; do
    $0
done
]],
    ["until"] = indent [[
until $1; do
    $0
done
]],
    case = indent [[
case "${1:name}" in
    ${2:pattern*})
        $0
        ::
    *)
        ${3:echo "\$$1 Didn't match anything"}
esac
]],
    func = indent [[
function ${1:name}()
{
    $0
}
]],
    --     tmp = indent [[
    -- ${1:TMPFILE}=$(mktmp ${2:XXX})
    -- trap "rm -f \\${$1}" 0             # EXIT
    -- trap "rm -f \\${$1}; exit 1" 2     # INT
    -- trap "rm -f \\${$1}; exit 1" 1 15  # HUP TERM
    -- ${0}
    -- ]],
    heredoc = indent [[
<< ${1:EOF}
    $0
$1
]],
    warn = indent [[
echo "${0:TARGET}" 1>&2
]],
    abort = indent [[
echo "${0:TARGET}" 1>&2
exit 1
]],
  }
end

return M
