local function indexOf(list, x)
    for i, v in ipairs(list) do
        if v == x then
            return i
        end
    end
    return 0
end

term.clear()

print("Milyen a táborunk?")
print()

term.setTextColor(colors.red)
term.write("   [Szörnyü]")
term.setTextColor(colors.orange)
term.write(" [Gyenge]")
term.setTextColor(colors.yellow)
term.write(" [Semleges]")
term.setTextColor(colors.lime)
term.write(" [Jó]")
term.setTextColor(colors.green)
term.write(" [Király!]")
term.setTextColor(colors.lightBlue)
print()
print()
selected = 0

while selected == 0 do
    local event, button, x, y = os.pullEvent("mouse_click")
    if y == 3 then
        selected = indexOf({4, 14, 23, 34, 39}, x)
        if selected > 0 then
            print(("Kattintott választás: %d"):format(selected))
        end
    end
end

