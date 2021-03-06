local PR = require("powerRule")
--function which allows you to create buttons the player can press with autosizing text optional
function button(xLocation,yLocation,width,height,lineWidth,color1,color2,color3,text,textColor,buttonFunctionNumber,hoverEvent,singlePress,dontStretchText)
    love.graphics.setLineWidth(lineWidth)
    love.graphics.setColor(color1/255,color2/255,color3/255)
    love.graphics.rectangle("line",xLocation,yLocation,width,height)
    mouse_x,mouse_y = love.mouse.getPosition()
    if textColor < 100 then
        textColor = 100
    end
    if mouse_x > xLocation and mouse_x < xLocation+width and mouse_y > yLocation and mouse_y < yLocation+height and hoverEvent then
        buttonColor = textColor-100
        if love.mouse.isDown(1) then
            buttonFunction(buttonFunctionNumber)
            if singlePress == true then
                pressed = true
            end
        end
    else
        buttonColor = textColor
    end
    love.graphics.setColor(buttonColor/255,buttonColor/255,buttonColor/255)
    if dontStretchText == false then
        love.graphics.print(text,staticFont,xLocation+(width/8),yLocation+(height/15),0,width/(#text*34.0136),height*0.0155)
    elseif dontStretchText == true then
        love.graphics.print(text,staticFont,xLocation+(width/2-10)-(12.3*#text),yLocation+(height/15),0,1,height*0.0155)
    end
end

--The function that is called when a user presses a button. The command that is run depends on the number.
function buttonFunction(number)
    if number == 1 then
        --Corresponds to the parameter "buttonFunctionNumber" in the button function. Allows you to choose what the button does
        functionBoxSelected = true
    elseif number == 2 then
        --How you add more functionality to the button
    end
end

function enterText()
    if functionBoxSelected == true then
        button(centeredBoxLocation(500),200,500,70,5,170,120,220,theFunction,245,1,false,false,true)
    elseif functionBoxSelected == false then
        button(centeredBoxLocation(500),200,500,70,5,130,80,180,theFunction,245,1,true,true,true)
    end

    if enterPressedOnce == true and functionBoxSelected == false then
        love.graphics.setColor(1,1,1)
        love.graphics.print("f'(x) = ",staticFont,(win_h/2-10)+(12.3*6),120,0,1,1)
    end
end

function love.keypressed(key)
    if key == "backspace" then
        theFunction = string.sub(theFunction,1,#theFunction-1)
    elseif key == "return" then
        enterPressedOnce = true
        functionBoxSelected = false
        theFunction = PR.power_rule(theFunction)
    elseif key == "c" then
        theFunction = ""
    end
end

function love.textinput(t)
    if not inList(t,invalidKeys) then
        theFunction = theFunction .. t
    end
end

function inList(character,lst)
    isInList = false
    for i=1,#lst do
        if character == lst[i] then
            isInList = true
            break
        end
    end
    return isInList
end

function centeredBoxLocation(boxWidth)
    return win_w/2 - (boxWidth/2)
end

function love.load()
    win_w = 1018
    win_h = win_w * 0.7
    love.window.setMode(win_w, win_h)
    love.window.setTitle (" Power Rule Calculator for Mr. Ritter's Class")
    love.graphics.setBackgroundColor(100/255,150/255,200/255)
    font = love.graphics.newFont("MonospaceTypewriter.ttf", 48/(80/(win_h/10)))
    staticFont = love.graphics.newFont("MonospaceTypewriter.ttf", 44.4,"normal",30)
    functionBoxSelected = false
    pressed = false
    enterPressedOnce = false
    invalidKeys = {'!','@', '#', '&', '[', '{', '}', ']', ':', ';', ',', '?', '~', '$','=', '<', '>','/','(',')','*'}
    theFunction = ""
end

--Updates the calculator every frame
function love.update(dt)
    --Quits the program if the player presses escape at any time
    if love.keyboard.isDown("escape") then
        os.exit()
    end
    --For all button functions that should only execute once----as soon as the user isn't pressing the mouse the button pressed resets
    if love.mouse.isDown(1) == false then
        pressed = false
    end
end

function love.draw()
    --Rectangles that set the background
    love.graphics.setColor(70/255,70/255,70/255)
    love.graphics.rectangle("fill",20,20,win_w-40,win_h-40)
    love.graphics.setLineWidth(30)
    love.graphics.rectangle("line",0,0,win_w,win_h)
    --Creates box for entering the function
    enterText()
end