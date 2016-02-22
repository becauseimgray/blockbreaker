lick = require "lick"
lick.reset = true -- reload the love.load everytime you save
require "TEsound"
require "map1"

local rect1 = {}
local ball = {}
local screen = {}

function love.load()

  screen.width = 1024
  screen.height = 768

  titlebar = {}
  titlebar.x, titlebar.y = 0,0
  titlebar.w = screen.width
  titlebar.h = 80
  points = 0
  highscore = 0
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
  alpha = 255
  list = {
    "audio/sound1.wav",
    "audio/sound2.wav",
    "audio/sound3.wav",
    "audio/sound4.wav",
    "audio/sound5.wav",
    "audio/sound6.wav",
    "audio/sound7.wav",
    "audio/sound8.wav",
    "audio/sound9.wav",
    "audio/sound10.wav",
  } --loads sounds and puts them into a list for TEsound work with
      map1.load()
end

-- Creating Collision Function for later usage
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.update(dt)
  TEsound.cleanup()

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
    block1.active = true
    block2.active = true
    if points >= highscore then
      highscore = points
    end
    points = 0
  end

  if ball.x < 0 then
      ball.speedx = math.abs(ball.speedx)
  elseif (ball.x + ball.w) > screen.width  then
      ball.speedx = -math.abs(ball.speedx)
  end

  map1.update(dt, ball)

  if CheckCollision(rect1.x,rect1.y,rect1.width,rect1.height,
    ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = -math.abs(ball.speedy)
    ball.speed = ball.speed + 10 * dt
    TEsound.play(list)
  end
  if CheckCollision(titlebar.x,titlebar.y,titlebar.w,titlebar.h,
    ball.x, ball.y, ball.w, ball.h) then
    ball.speedy = math.abs(ball.speedy)
  end
  --debugging points
  if love.keyboard.isDown(']') then
    points = points + 1
  end
end

function love.draw()
  --love.graphics.setColor(0, 0, 0, 255)
  titlebar.bar = love.graphics.rectangle("line", titlebar.x, titlebar.y,titlebar.w, titlebar.h)
  love.graphics.print(points, 10, 10)
  love.graphics.print("HS:" .. highscore, screen.width - 300, 10)
  love.graphics.setColor(255, 255, 255, 255)
  if start then
    ball.x = screen.width / 2, screen.height / 2
    ball.y = screen.width / 2, screen.height / 2
    love.graphics.setColor(255,255,255, alpha)
    font = love.graphics.newFont("fonts/Vera.ttf", 50)
    love.graphics.setFont(font)
    love.graphics.print("Press Space", screen.width / 2 - 150, screen.height / 2 - 100)
  end

    love.graphics.rectangle('fill', rect1.x, rect1.y, rect1.width,rect1.height)
        map1.draw()
  if start == false then
    love.graphics.circle('fill', ball.x,ball.y, ball.h, ball.w)
  end

end
