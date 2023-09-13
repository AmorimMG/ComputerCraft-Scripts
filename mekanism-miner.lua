-- This a Computercraft script for automating Mekanism's Digital Miner - updated for version 1.19.2¨
-- Just place digital miner, the energy block and storage block into turtle.
 
-- mekanism:digital_miner - Digital Miner
-- mekanism:quantum_entangloporter - Quantum Entangloporter - you can use any other form of wireless energy, just copypast the id/name..
-- ..example: minecraft:diamond_sword
-- sophisticatedstorage:diamond_shulker_box - you can use any other chest
 
--Edit this here to match your blocks: 

energy_block = "mekanism:quantum_entangloporter"
storage_block = "sophisticatedstorage:diamond_shulker_box"
wireless_block = "mekanism:qio_importer"
 
function get_ores_left()
    p = peripheral.wrap("left")
 
    ores_left = p.getToMine()
 
    ores_left_1_perc = ores_left / 100
 
    ores_left = math.floor(((ores_left_1_perc * 9) * 10))
 
    p.reset()
    p.start()
 
    if p == nil then
        return 0
    else return ores_left
    end
end
 
function select_item(item_name)
    for i = 1, 16, 1 do
        item_info = turtle.getItemDetail(i)
 
        if item_info ~= nil then
            if item_info.name == item_name then
                turtle.select(i)
            end
        end
    end
end
 
function place_blocks()
    select_item("mekanism:digital_miner")
 
    turtle.placeUp()
    turtle.turnRight()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
 
    select_item(energy_block)
 
    turtle.placeUp()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.up()
    turtle.up()
 
    select_item(wireless_block)
 
    turtle.placeUp()
    turtle.down()
 
    select_item(storage_block)
 
    turtle.placeUp()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
 
    p = peripheral.wrap("left")
    p.start()
end
 
function destroy_blocks()
    turtle.turnLeft();
    turtle.dig()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.dig()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.up()
    turtle.up()
    turtle.turnLeft()
    turtle.dig()
    turtle.down()
    turtle.dig()
    turtle.down()
    turtle.down()
end 
 
function go_forward_32blocks()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.turnLeft()
 
    for j = 1, 32, 1 do
        turtle.forward()
    end
end
 
for i = 0, 16, 1 do
    place_blocks()
 
    os.sleep(2)
 
    for j = get_ores_left(), 0, -1 do
        print("Minerios Faltantes: "..j)
 
        if j == 0 then
            destroy_blocks()
 
            os.sleep(2)
 
            go_forward_32blocks()
        end
 
        os.sleep(0.5)
    end
 
    os.sleep(0.5)
end
