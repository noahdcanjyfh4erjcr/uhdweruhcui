function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

function love.load()
    --customizing the window
    love.window.setTitle("")
    love.window.setMode(1000, 1000, {resizable=true, vsync=0, minwidth=1920, minheight=720})
    --camera stuff idfk
    camera = require('libraries/camera')
    cam = camera()

    --sti or something
    sti = require('libraries/sti')
    testMap = sti('maps/overworldi1.lua')
    --defining the player
    player = {}
    player.x = 910
    player.y = 200
    player.speed = 3
    --adding menu music
    sounds = {}
    sounds.mainmenumusic = love.audio.newSource("assets/sounds/1-02 Main Menu.mp3", "stream")
    sounds.mainmenumusic.play(sounds.mainmenumusic)
        --adding funny 
    background = love.graphics.newImage("assets/sprites/BG/menu_i2.png")
end 

function love.update(dt)
    if love.keyboard.isDown("d") then
        player.x = player.x +player.speed
    end
    if love.keyboard.isDown("a") then
        player.x = player.x -player.speed
    end
    if love.keyboard.isDown("w") then
        player.y = player.y -player.speed
    end
    if love.keyboard.isDown("s") then
        player.y = player.y +player.speed
    end

    cam:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if cam.x < w/2 then
        cam.x = w/2
    end

    if cam.y < h/2 then
        cam.y = h/2
    end

    local mapW = testMap.width * testMap.tilewidth
    local mapH = testMap.height * testMap.tileheight

    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
end

function love.draw()
    cam:attach()
        -- love.graphics.draw(background, 0,0)
        testMap:drawLayer(testMap.layers["Tile Layer 1"])
        love.graphics.rectangle("fill", player.x, player.y, 40,40)
    cam:detach()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
        love.draw()
	end
end