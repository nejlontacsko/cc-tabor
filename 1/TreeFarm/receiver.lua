local shouldListen = true

local modem = peripheral.wrap("right")
modem.open(1)

local function getTimestamp()
    return textutils.formatTime(os.time(), true)
end

local function split(str, separator)
  separator = separator or '%s'
  local t = {} 
  for token in string.gmatch(str, "[^"..separator.."]+") do
      table.insert(t, token)
  end
  return t
end

local function printMsg(message)
    local strs = split(message, ":")
    local msgType = strs[1]
    local msgContent = strs[2]

    -- timestamp
    term.setTextColor(colors.white)
    term.write("[")
    term.setTextColor(colors.lightGray)
    term.write(getTimestamp())
    term.setTextColor(colors.white)
    term.write("] [")

    -- message type
    term.setTextColor(colors.lightBlue)
    term.write(msgType)
    term.setTextColour(colors.white)
    term.write("] ")

    -- messsage content
    term.setTextColor(colors.cyan)
    term.write(msgContent)
    if strs[3] ~= nil then
        term.write("\t" .. strs[3])
    end
    print()
end


local function listenTerminal()
    while true do
        --io.write("> ") -- prompt
        local input = read()
        if input == "close" then
            shouldListen = false
            term.clear()
            break
        else
            print("Unknown command: " .. input)
        end
    end
end

local function receiveModem()
    while shouldListen == true do
        local event, modemSide, senderChannel,
          replyChannel, message,
          senderDistance = os.pullEvent("modem_message")

        printMsg(message)
    end
end


-- MAIN

term.setTextColor(colors.white)
term.setCursorPos(1,1)
parallel.waitForAny(receiveModem, listenTerminal)