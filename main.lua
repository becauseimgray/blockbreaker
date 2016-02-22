lick = require "lick"
lick.reset = true -- reload the love.load everytime you save

local rect1 = {}
local ball = {}
local screen = {}
function love.load()

  screen.width = 1024
  screen.height = 768

  rect1.x = 466
  rect1.y = 720
  rect1.width = 100
  rect1.height = 10
  rect1.speed = 1000

  ball.x = screen.width / 2
  ball.y = screen.height / 2
  ball.h = 10
  ball.w = 10
  ball.speed = 500
  ball.speedx = -ball.speed
  ball.speedy = ball.speed
  ball.velocity = ball.speed + rect1.speed
  start = true
end

-- Creating Collision Function for later usage
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.update(dt)
  if love.keyboard.isDown('space') then
    start = false
  end
  if love.keyboard.isDown('escape') then
    start = true
  end
    -- controls for dock
  if love.keyboard.isDown('d') then
    rect1.x = rect1.x + (rect1.speed * dt)
  end
  if love.keyboard.isDown('a') then
    rect1.x = rect1.x - (rect1.speed * dt)
  end


  -- collision for dock
  if rect1.x <= 0 then
    rect1.x = 0
  end
  if rect1.y <= 0 then
    rect1.y = 0
  end
  if rect1.x >= screen.width then
    rect1.x = screen.width - rect1.width
  end
  if rect1.y > screen.height then
    rect1.y = screen.height - rect1.height
  end

  ball.x = ball.x + (ball.speedx * dt)
  ball.y = ball.y + (ball.speedy * dt)

  if ball.y < 0 then
      ball.speedy = math.abs(ball.speedy)
  elseif (ball.y + ball.h) > screen.height then
    ball.speedy = -math.abs(ball.speedy)
    start = true
  end
  if ball.x < 0 then
      ball.speedx = math.abs(ball.speedx)
  elseif (ball.x + ball.w) > screen.width  then
      ball.speedx = -math.abs(ball.speedx)
  end


  if CheckCollision(rect1.x,rect1.y,rect1.width,rect1.height,
  ball.x, ball.y, ball.w, ball.h) then
  ball.speedy = -math.abs(ball.speedy)
  ball.speed = ball.velocity + 10
  end
end

function love.draw()
  if start then
    ball.x = screen.width / 2, screen.height / 2
    ball.y = screen.width / 2, screen.height / 2

    font = love.graphics.newFont("fonts/Vera.ttf", 50)
    love.graphics.setFont(font)
    love.graphics.print("Press Space", screen.width / 2 - 150, screen.height / 2 - 100)
  end

  love.graphics.rectangle('fill', rect1.x, rect1.y, rect1.width,rect1.height)
  love.graphics.circle('fill', ball.x,ball.y, ball.h, ball.w)
end
