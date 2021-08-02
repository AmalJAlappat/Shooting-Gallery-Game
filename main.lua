function love.load () 

    target={}
    target.x=50
    target.y=100
    target.radius=50
    score=0
    timer=0
    fontSize=love.graphics.newFont(50)
    sprites={}
    sprites.sky=love.graphics.newImage('sprites/sky.png')
    sprites.target=love.graphics.newImage('sprites/target.png')
    sprites.crosshairs=love.graphics.newImage('sprites/crosshairs.png')
    love.mouse.setVisible(false)
    gameState=1

end

function love.update(dt)
    if gameState==2 then
        if timer>0 then
            timer=timer-dt
        end
    
        if timer<0 then
            timer=0
            gameState=1
        end
    end

end

function love.draw()

    love.graphics.draw(sprites.sky,0,0)
    love.graphics.setFont(fontSize)
    love.graphics.print("Score: "..score,5,5)
    love.graphics.print("Time Left: "..math.ceil(timer),(love.graphics.getWidth())/2,5)

    if gameState==1 then
        love.graphics.printf("Click anywhere to start the game",0,250,love.graphics.getWidth(),"center")
    end

    

    if gameState==2 then
        love.graphics.draw(sprites.target,target.x-target.radius,target.y-target.radius)
        love.graphics.draw(sprites.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
    
    end
    
    function love.mousepressed( x, y, button, istouch, presses )

        if button==1 and gameState==2 then
            local mouseTarget = distanceBetween(x,y,target.x,target.y)
            if mouseTarget <= target.radius then
                score = score+1
                target.x=math.random(target.radius,love.graphics.getWidth()-target.radius)
                target.y=math.random(target.radius,love.graphics.getHeight()-target.radius)
            elseif score>0 then
                score=score-1  
            end
    

        elseif button==1 and gameState==1 then
            gameState=2
            timer=10
            score=0
        end

        if button==2 and gameState==2 then
            local mouseTarget = distanceBetween(x,y,target.x,target.y)
            if mouseTarget <= target.radius then
                score = score+2
                timer = timer-1
                target.x=math.random(target.radius,love.graphics.getWidth()-target.radius)
                target.y=math.random(target.radius,love.graphics.getHeight()-target.radius)
            elseif score>0 then
                score=score-1  
            end
    

        elseif button==1 and gameState==1 then
            gameState=2
            timer=10
            score=0
        end
        

    end

    function distanceBetween(x1,y1,x2,y2)

        return math.sqrt( (x2-x1)^2 + (y2-y1)^2 )

    end

end