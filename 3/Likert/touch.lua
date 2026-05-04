local function indexOf(startPosList, lenList, x)
    for i, v in ipairs(startPosList) do
        local len = lenList[i]
        if x >= v and x <= (v + len - 1) then
            return i
        end
    end
    return 0
end

local function resetScreen()
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
end

local likertOptions = { "Szornyu", "Gyenge", "Semleges", "Jo", "Kiraly!" }
local likertColors = { colors.red, colors.orange, colors.yellow, colors.lime, colors.green}

resetScreen()
print(("%d. kerdes: Milyen a taborunk?"):format(1))
print()
term.write("  ")

local startPosList = {}
local lenList = {}
local currentX = 4
for i = 1, #likertOptions do
    local label = (" [%s]"):format(likertOptions[i])
    startPosList[i] = currentX
    lenList[i] = #label

    term.setTextColor(likertColors[i])
    term.write(label)

    currentX = currentX + #label
end

local activeLine = 3 -- Hosszabb kerdesekre ki kell majd számolni hova kerül a képernyőn

selected = 0
while selected == 0 do
    local event, button, x, y = os.pullEvent("mouse_click")
    if y == activeLine then
        selected = indexOf(startPosList, lenList, x)
        if selected > 0 then
            resetScreen()
            term.setTextColor(colors.lightBlue)
            print(("Kattintott valasz: %d"):format(selected))
        end
    end
end

