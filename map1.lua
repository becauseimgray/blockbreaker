require "lick"
map1 = {}


function map1.load()
  block1 = {x = 0,              y = 80, w = 164, h = 64, active = true}
  block2 = {x = block1.x + 165, y = 80, w = 164, h = 64, active = true}
  block3 = {x = block2.x + 165, y = 80, w = 164, h = 64, active = true}
  block4 = {x = block3.x + 165, y = 80, w = 164, h = 64, active = true}
  block5 = {x = block4.x + 165, y = 80, w = 164, h = 64, active = true}
  block6 = {x = block5.x + 165, y = 80, w = 164, h = 64, active = true}
  --block7 = {x = block6.x + 165, y = 80, w = 164, h = 64, active = true}
end

function map1.update(dt, ball)

  if block1.active and CheckCollision(block1.x,block1.y,block1.w,block1.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block1.active = false
  end

  if block2.active and CheckCollision(block2.x,block2.y,block2.w,block2.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block2.active = false
  end

  if block3.active and CheckCollision(block3.x,block3.y,block3.w,block3.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block3.active = false
  end
  if block4.active and CheckCollision(block4.x,block4.y,block4.w,block4.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block4.active = false
  end
  if block5.active and CheckCollision(block5.x,block5.y,block5.w,block5.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block5.active = false
  end
  if block6.active and CheckCollision(block6.x,block6.y,block6.w,block6.h, ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy) TEsound.play(list) points = points + 1
    block6.active = false
  end

end

function map1.draw()
  if block1.active then love.graphics.rectangle("fill",block1.x, block1.y, block1.w, block1.h) end
  if block2.active then love.graphics.rectangle("fill",block2.x, block2.y, block2.w, block2.h) end
  if block3.active then love.graphics.rectangle("fill",block3.x, block3.y, block3.w, block3.h) end
  if block4.active then love.graphics.rectangle("fill",block4.x, block4.y, block4.w, block4.h) end
  if block5.active then love.graphics.rectangle("fill",block5.x, block5.y, block5.w, block5.h) end
  if block6.active then love.graphics.rectangle("fill",block6.x, block6.y, block6.w, block6.h) end
  --if block7.active then love.graphics.rectangle("fill",block7.x, block7.y, block7.w, block7.h) end
end

function map1.reset(bool)
  block1.active = bool
  block2.active = bool
  block3.active = bool
  block4.active = bool
  block5.active = bool
  block6.active = bool
end
