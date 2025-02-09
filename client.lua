local screenWidth, screenHeight = guiGetScreenSize()
local windowWidth, windowHeight = 300, 200
local windowX, windowY = (screenWidth - windowWidth) / 2, (screenHeight - windowHeight) / 2

local isUIVisible = false
local isClosing = false
local animationProgress = 0
local targetFuncYes = nil
local targetFuncYesArgs = {}

local UI_Title = "Confirmación";
local UI_Description = "¿Estás seguro de que quieres hacer esto?";

function drawConfirmUI()
    if not isUIVisible then return end

    if isClosing then
        animationProgress = math.max(animationProgress - 0.05, 0)
        if animationProgress == 0 then
            isUIVisible = false
            removeEventHandler("onClientRender", root, drawConfirmUI)
            removeEventHandler("onClientClick", root, handleUIMouseClick)
            return
        end
    else
        animationProgress = math.min(animationProgress + 0.05, 1)
    end

    local animY = windowY - (50 * (1 - animationProgress))

    dxDrawRectangle(windowX, animY, windowWidth, windowHeight, tocolor(50, 50, 50, 200 * animationProgress), true)
    dxDrawText(UI_Title, windowX, animY + 10, windowX + windowWidth, animY + 30, tocolor(255, 255, 255, 255 * animationProgress), 1.2, "default-bold", "center", "center", false, false, true)
    dxDrawText(UI_Description, windowX + 20, animY + 60, windowX + windowWidth - 20, animY + 120, tocolor(255, 255, 255, 255 * animationProgress), 1, "default", "center", "center", true, true, true)

    local buttonYesX, buttonYesY = windowX + 50, animY + 130
    local buttonYesWidth, buttonYesHeight = 80, 30
    dxDrawRectangle(buttonYesX, buttonYesY, buttonYesWidth, buttonYesHeight, tocolor(0, 255, 0, 150 * animationProgress), true)
    dxDrawText("Sí", buttonYesX, buttonYesY, buttonYesX + buttonYesWidth, buttonYesY + buttonYesHeight, tocolor(255, 255, 255, 255 * animationProgress), 1, "default-bold", "center", "center", false, false, true)

    local buttonNoX, buttonNoY = windowX + 170, animY + 130
    local buttonNoWidth, buttonNoHeight = 80, 30
    dxDrawRectangle(buttonNoX, buttonNoY, buttonNoWidth, buttonNoHeight, tocolor(255, 0, 0, 150 * animationProgress), true)
    dxDrawText("No", buttonNoX, buttonNoY, buttonNoX + buttonNoWidth, buttonNoY + buttonNoHeight, tocolor(255, 255, 255, 255 * animationProgress), 1, "default-bold", "center", "center", false, false, true)
end

function handleUIMouseClick(button, state, absoluteX, absoluteY)
    if not isUIVisible or button ~= "left" or state ~= "up" then return end

    local buttonYesX, buttonYesY = windowX + 50, windowY - (50 * (1 - animationProgress)) + 130
    local buttonYesWidth, buttonYesHeight = 80, 30

    local buttonNoX, buttonNoY = windowX + 170, windowY - (50 * (1 - animationProgress)) + 130
    local buttonNoWidth, buttonNoHeight = 80, 30

    if absoluteX >= buttonYesX and absoluteX <= buttonYesX + buttonYesWidth and absoluteY >= buttonYesY and absoluteY <= buttonYesY + buttonYesHeight then
        if targetFuncYes then
            playSoundFrontEnd(6)
            targetFuncYes(unpack(targetFuncYesArgs))
        end
        startClosingAnimation()
    end

    if absoluteX >= buttonNoX and absoluteX <= buttonNoX + buttonNoWidth and absoluteY >= buttonNoY and absoluteY <= buttonNoY + buttonNoHeight then
        playSoundFrontEnd(4)
        startClosingAnimation()
    end
end

function startClosingAnimation()
    isClosing = true
    showCursor(false)
end

function dxConfirm(title, description, funcYes, ...)
    isUIVisible = true
    isClosing = false
    animationProgress = 0
    targetFuncYes = funcYes
    targetFuncYesArgs = {...} -- Almacenar los argumentos para la función
    UI_Title = title;
    UI_Description = description;
    showCursor(true)
    playSoundFrontEnd(13)
    addEventHandler("onClientRender", root, drawConfirmUI)
    addEventHandler("onClientClick", root, handleUIMouseClick)
end