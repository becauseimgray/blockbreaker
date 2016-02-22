levels = {}

function levels.load(map_number)
  if map_number == 1 then
    levels.map1 = {
           {{'r', 'r', 'r', 'r', 'r', 'r'}},
           {{'r', 'r', 'r', 'r', 'r', 'r'}},
           {{'r', 'r', 'r', 'r', 'r', 'r'}},
           }
  end
end

function levels.draw(map_number)
  for i in levels.map1 do
      for j in i do
        if 'r' then
          love.graphics.rectangle('fill', 0, 0, 10, 10)
        end
   end
 end
end
