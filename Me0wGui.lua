local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

-- Función para mostrar notificaciones
local function showNotification(message, isError)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0.4, 0, 0.1, 0) -- Tamaño de la notificación
    notification.Position = UDim2.new(0.3, 0, 0.8, 0) -- Posición en la parte inferior
    notification.Text = message
    notification.TextColor3 = if isError then Color3.new(1, 0, 0) else Color3.new(0, 1, 0) -- Rojo para error, verde para éxito
    notification.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Color de fondo (gris oscuro)
    notification.TextScaled = true -- Escalar el texto
    notification.Parent = gui

    -- Animación de fade out y eliminar la notificación
    local fadeOut = TweenService:Create(notification, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1})
    delay(3, function()
        fadeOut:Play()
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

-- Crear el botón con la imagen de Pikachu
local pikachuButton = Instance.new("ImageButton")
pikachuButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Tamaño del botón
pikachuButton.Position = UDim2.new(0, 0, 0, 0) -- Posición en la esquina superior izquierda
pikachuButton.Image = "http://www.roblox.com/asset/?id=14208141422" -- Imagen de Pikachu
pikachuButton.BackgroundTransparency = 1 -- Fondo transparente
pikachuButton.Parent = gui

-- Animación de oscurecimiento al hacer clic
local function animateButton(button)
    local originalBrightness = button.ImageTransparency
    local darkenTween = TweenService:Create(button, TweenInfo.new(0.2), {ImageTransparency = 0.5}) -- Oscurecer
    local brightenTween = TweenService:Create(button, TweenInfo.new(0.2), {ImageTransparency = originalBrightness}) -- Restaurar brillo

    darkenTween:Play()
    darkenTween.Completed:Wait()
    brightenTween:Play()
end

-- Conectar el botón de Pikachu para abrir/cerrar el menú
local isMenuOpen = false
pikachuButton.MouseButton1Click:Connect(function()
    animateButton(pikachuButton) -- Animación de oscurecimiento
    if isMenuOpen then
        closeMenu()
    else
        openMenu()
    end
end)

-- Crear el menú (Frame)
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0.6, 0, 0.7, 0) -- Tamaño del menú (más grande)
menuFrame.Position = UDim2.new(0.2, 0, 0.15, 0) -- Posición centrada
menuFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Color oscuro
menuFrame.Visible = false -- Inicialmente invisible
menuFrame.Parent = gui

-- Bordes redondeados para el menú
local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0.1, 0)
menuCorner.Parent = menuFrame

-- Añadir un título al menú
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.1, 0) -- Tamaño del título
title.Position = UDim2.new(0, 0, 0, 0) -- Posición en la parte superior
title.Text = "Me0wKid Gui"
title.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
title.BackgroundTransparency = 1 -- Fondo transparente
title.Parent = menuFrame

-- Barra de búsqueda
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0.8, 0, 0.05, 0) -- Tamaño de la barra de búsqueda
searchBox.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posición debajo del título
searchBox.PlaceholderText = "Buscar..." -- Texto predeterminado
searchBox.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
searchBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Color de fondo (gris oscuro)
searchBox.Parent = menuFrame

-- Botón "+" para agregar scripts
local addButton = Instance.new("TextButton")
addButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Tamaño del botón
addButton.Position = UDim2.new(0.05, 0, 0.2, 0) -- Posición dentro del menú
addButton.Text = "+"
addButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
addButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1) -- Color de fondo (azul)
addButton.Parent = menuFrame

-- Función para abrir el menú de agregar script
addButton.MouseButton1Click:Connect(function()
    -- Crear un Frame para el menú de agregar script
    local addScriptFrame = Instance.new("Frame")
    addScriptFrame.Size = UDim2.new(0.4, 0, 0.3, 0) -- Tamaño del menú
    addScriptFrame.Position = UDim2.new(0.3, 0, 0.35, 0) -- Posición centrada
    addScriptFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Color de fondo (gris oscuro)
    addScriptFrame.Parent = menuFrame

    -- Botón "X" para cerrar el menú de agregar script
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Tamaño del botón
    closeButton.Position = UDim2.new(0.9, 0, 0, 0) -- Posición en la esquina superior derecha
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    closeButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2) -- Color de fondo (rojo)
    closeButton.Parent = addScriptFrame

    -- Cerrar el menú de agregar script al hacer clic en "X"
    closeButton.MouseButton1Click:Connect(function()
        addScriptFrame:Destroy()
    end)

    -- TextBox para el nombre del script
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(0.8, 0, 0.2, 0) -- Tamaño del TextBox
    nameBox.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posición dentro del menú
    nameBox.PlaceholderText = "Nombre del script"
    nameBox.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    nameBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3) -- Color de fondo (gris)
    nameBox.Parent = addScriptFrame

    -- TextBox para el contenido del script
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.8, 0, 0.5, 0) -- Tamaño del TextBox
    scriptBox.Position = UDim2.new(0.1, 0, 0.4, 0) -- Posición dentro del menú
    scriptBox.PlaceholderText = "Pega tu script aquí"
    scriptBox.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    scriptBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3) -- Color de fondo (gris)
    scriptBox.TextWrapped = true -- Ajustar texto
    scriptBox.Parent = addScriptFrame

    -- Botón para guardar el script
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.4, 0, 0.2, 0) -- Tamaño del botón
    saveButton.Position = UDim2.new(0.3, 0, 0.8, 0) -- Posición dentro del menú
    saveButton.Text = "Guardar"
    saveButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    saveButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1) -- Color de fondo (azul)
    saveButton.Parent = addScriptFrame

    -- Guardar el script y crear un botón
    saveButton.MouseButton1Click:Connect(function()
        local scriptName = nameBox.Text
        local scriptContent = scriptBox.Text
        if scriptName ~= "" and scriptContent ~= "" then
            table.insert(scriptsList, {Name = scriptName, Content = scriptContent})
            showScripts()
            addScriptFrame:Destroy() -- Cerrar el menú de agregar script
        else
            warn("Por favor, ingresa un nombre y un script válidos.")
        end
    end)
end)

-- Configuración de la animación
local fadeInInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local fadeOutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local fadeIn = TweenService:Create(menuFrame, fadeInInfo, {BackgroundTransparency = 0})
local fadeOut = TweenService:Create(menuFrame, fadeOutInfo, {BackgroundTransparency = 1})

-- Función para abrir el menú
local function openMenu()
    menuFrame.Visible = true
    fadeIn:Play()
    isMenuOpen = true
end

-- Función para cerrar el menú
local function closeMenu()
    fadeOut:Play()
    fadeOut.Completed:Wait()
    menuFrame.Visible = false
    isMenuOpen = false
end
