-- module.lua

local M = {}
--Local to the file
local function internalMethod()
  print("This is only avalibale in the module file")
end

--exported and can by used like a class method
function M.sayhello(name)
  print("hello, " .. name)
end

--global method
function GlobalHello(name)
  print("hello, " ..name)
end

return M

-- MAIN FILE

local treeModule = require("module.lua")

treeModule.sayhello("ASD")

GlobalHello("ASD_GLOBAL")