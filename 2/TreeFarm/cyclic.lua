local sender = require "/TreeFarm/sender"

function turnToLargeChest()
    --Where is the chest?
    local face = ""
    local front = nil
    repeat
        front = peripheral.wrap("front")
        if front ~= nil then
            face = peripheral.getType(front)
            if face ~= "minecraft:chest" then
                turtle.turnRight()
            end
        else
            turtle.turnRight()
        end
    until face == "minecraft:chest"

    --Did I found the large one?
    local left = peripheral.wrap("left")
    if left ~= nil then
        face = peripheral.getType(left)
        if face == "minecraft:chest" then
            turtle.turnLeft()
        end
    end
end

function listChestContent()
    -- What is in the chest in front or me??
    local front = peripheral.wrap("front")

    local coalAvailable = 0
    local slotOccupiedInChest = 0

    for slot, item in pairs(front.list()) do
        --print(("%d x %s in slot %d"):format(item.count, item.name, slot))
        sender.tellInventory(item.name, item.count)
        slotOccupiedInChest = slotOccupiedInChest + 1
        if item.name == "minecraft:charcoal" then
            coalAvailable = coalAvailable + item.count
        end
    end

    print(("%d slots occupied in chest."):format(slotOccupiedInChest))
    print(("\t%d coals available."):format(coalAvailable))
end

function takeFuelFromChest()
    local front = peripheral.wrap("front")
    turtle.turnRight()
    local right = peripheral.wrap("front")
    turtle.turnLeft()

    local found = 0
    for slot, item in pairs(front.list()) do
        if item.name == "minecraft:charcoal" then
            found = slot
            break
        end
    end

    if found > 0 then
        front.pullItems(peripheral.getName(right), found)
        turtle.turnRight()
        turtle.suck()
        turtle.refuel()
        turtle.turnLeft()
    else
        print("No fuel in the chest!!")
    end
end

function refuel()
    -- Do I need to be refueled?
    local fuelLevel = turtle.getFuelLevel()
    local need = fuelLevel < 160 -- value 160 = 2 charcoals
    print(("Fuel level: %d"):format(fuelLevel))
    if need then
        print("Trutle needs to be refueled.")

        turtle.refuel()
        if fuelLevel == turtle.getFuelLevel() then
            print("No coal in my inventory to refuel!")
            takeFuelFromChest()
        end

        print(("Fuel level: %d"):format(turtle.getFuelLevel()))
    else
        print("No need to refuel.")
    end
end

function turnBack()
    turtle.turnRight()
    turtle.turnRight()
end

function turnRight()
    turtle.turnRight()
    local d = turtle.detect()
    if d == false then
        turtle.forward()
        turtle.turnRight()
    end
    return d
end

function turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
end

function goForward()
    local d = true
    repeat
        turtle.forward()
        d = turtle.detect()
    until d == true
end

--MAIN

local axe = peripheral.wrap("right")
print(peripheral.getNames(axe))

--setup
turnToLargeChest()
listChestContent()
refuel()
turnBack()

--loop
local pathEnd = false
repeat
    goForward()
    pathEnd = turnRight()
    goForward()
    turnLeft()
until pathEnd == true

print("END")
