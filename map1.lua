require "lick"
block1 = {}
block2 = {}
map1 = {}

function map1.load()
block2.x = 165
block2.y = 80
block2.w = 164
block2.h = 64

block1.x = 0
block1.y = 80
block1.w = 164
block1.h = 64

block2.active = true
block1.active = true
end

function map1.update(dt, ball)
  if block1.active and CheckCollision(block1.x,block1.y,block1.w,block1.h,
    ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy)
    TEsound.play(list)
        points = points + 1
    block1.active = false
  end
  if block2.active and CheckCollision(block2.x,block2.y,block2.w,block2.h,
    ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy)
    TEsound.play(list)
    block2.active = false
    points = points + 1
  end
end

function map1.draw()
  if block1.active then
    love.graphics.rectangle("fill",block1.x, block1.y, block1.w, block1.h)
  end
  if block2.active then
    love.graphics.rectangle("fill",block2.x, block2.y, block2.w, block2.h)
  end
end
