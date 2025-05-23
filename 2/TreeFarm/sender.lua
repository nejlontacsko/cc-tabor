-- sender.lua

local Sender = {}

local modem = nil
local sendChannel = 1
local replyChannel = 2

local cntOfMessagesSent = 0

local function sendMsg(message)
    modem.transmit(sendChannel, replyChannel, message)
    cntOfMessagesSent = cntOfMessagesSent + 1
end

local function init()
    modem = peripheral.wrap("left")
    sendMsg("INF:Turtle online!")
end

local function check()
    if modem == nil then init() end
end

local function split(str, separator)
    separator = separator or '%s'
    local t = {} 
    for token in string.gmatch(str, "[^"..separator.."]+") do
        table.insert(t, token)
    end
    return t
end

function Sender.tellInventory(itemFullName, count)
    check()
    
    local itemName = split(itemFullName, ":")[2]
    sendMsg("INV" .. ":" .. itemName .. ":" .. tostring(count))
end

return Sender