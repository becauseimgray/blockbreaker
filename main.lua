lick = require "lick"
lick.reset = true -- reload the love.load everytime you save
require "TEsound"
require "map1"
--requirements for android gui
require "gooi/gooi"
require "gooi/component"
require "gooi/layout"

local rect1 = {}
local ball = {}
local screen = {}
numOfLives = 3

--map loading
local map1bool = false
local map2bool = false

function love.load()
  --load android functions
  pGame = gooi.newPanel("panelGameLayout", 0, 800, 200, 200, "game") -- this changes gui location
  pGame:add(gooi.newJoy("joy_1"), "b-l")-- Bottom-left

  screen.width, screen.height, screen.flags = love.window.getMode()

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
  --ball.velocity = ball.speed + rect1.speed

  startmsg = love.graphics.newImage("images/startmsg.png")
  start = true
  deathsnd = "audio/death.wav"
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
    --loads map, atm there is only one map
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
  gooi.update(dt)

  --keyboard controls for beginning game and pausing
  if love.keyboard.isDown('space') then
    start = false
  end

  if love.keyboard.isDown('escape') then
    start = true
    map1.reset()
  end

    -- controls for dock
  if love.keyboard.isDown('d') then
    rect1.x = rect1.x + (rect1.speed * dt)
  end
  if love.keyboard.isDown('a') then
    rect1.x = rect1.x - (rect1.speed * dt)
  end

  --android controls
    rect1.x = rect1.x + rect1.speed * gooi.get("joy_1"):xValue() * dt


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
  if (rect1.y + rect1.width) > screen.height then
    rect1.y = screen.height - rect1.height
  end
  --ball movement
  ball.x = ball.x + ball.speedx * dt
  ball.y = ball.y + ball.speedy * dt

  if ball.y < 0 then
      ball.speedy = math.abs(ball.speedy)
  elseif (ball.y + ball.h) > screen.height then
    ball.speedy = -math.abs(ball.speedy)
    start = true
    if numOfLives == 0 then
      map1.reset(true)
    end
    numOfLives = numOfLives - 1
    TEsound.play(deathsnd)
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
  --[[if love.keyboard.isDown(']') then
    points = points + 1
  end]]--
end

function love.draw()
  gooi.draw()
  map1.draw(ball, rect1, list, screen)


  --love.graphics.setColor(0, 0, 0, 255)

  titlebar.bar = love.graphics.rectangle("line", titlebar.x, titlebar.y,titlebar.w, titlebar.h)
  love.graphics.print(points, 10, 10)
  love.graphics.print("HS:" .. highscore, screen.width - 300, 10)
  love.graphics.setColor(255, 255, 255, 255)

  --lives
  if numOfLives == 3 then
  love.graphics.circle("fill", screen.width / 2 - 50, titlebar.h / 2, 10,10)
  love.graphics.circle("fill", screen.width / 2,      titlebar.h / 2, 10,10)
  love.graphics.circle("fill", screen.width / 2 + 50, titlebar.h / 2, 10,10)
elseif numOfLives == 2 then
  love.graphics.circle("fill", screen.width / 2,      titlebar.h / 2, 10,10)
  love.graphics.circle("fill", screen.width / 2 + 50, titlebar.h / 2, 10,10)
elseif numOfLives == 1 then
love.graphics.circle("fill", screen.width / 2,      titlebar.h / 2, 10,10)
end
if numOfLives == 0 then
  start = true
  map1.reset(true)
  numOfLives = 3
end
  if start then
    --ball starting location
      --print("X: " .. ball.x .."Y: " .. ball.y)
    ball.x = 0
    ball.y = 80
      --ball.x = screen.width / 2, screen.height / 2
      --ball.y = screen.width / 2, screen.height / 2
    --font setup
    love.graphics.setColor(255,255,255, alpha)
    font = love.graphics.newFont("fonts/Vera.ttf", 50)
    love.graphics.setFont(font)
    --Starting message
    love.graphics.draw(startmsg, 0, 0)
  end

    love.graphics.rectangle('fill', rect1.x, rect1.y, rect1.width,rect1.height)
    --draws level and does updates
  if start == false then
    love.graphics.circle('fill', ball.x,ball.y, ball.h, ball.w)
  end


--extras for touch
function love.mousereleased(x, y, button) gooi.released() end
function love.mousepressed(x, y, button)  gooi.pressed() start = false end

--enable this for touch support MAY GIVE ERRORS ON DESKTOP

function love.touchmoved(id, x, y, pressure) gooi.moved(id, x, y) start = false end
function love.touchpressed(id, x, y, pressure) gooi.pressed(id, x, y) end
function love.touchreleased(id, x, y, pressure) gooi.released(id, x, y) end

end
