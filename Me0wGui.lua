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

-- Función para mostrar la animación de bienvenida
local function showWelcomeMessage()
    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.Size = UDim2.new(0.4, 0, 0.2, 0) -- Tamaño del marco de bienvenida
    welcomeFrame.Position = UDim2.new(0.3, 0, 0.4, 0) -- Posición centrada
    welcomeFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Color de fondo (gris oscuro)
    welcomeFrame.BackgroundTransparency = 1 -- Inicialmente transparente
    welcomeFrame.Parent = gui

    -- Imagen de la miniatura del jugador
    local thumbnail = Instance.new("ImageLabel")
    thumbnail.Size = UDim2.new(0.2, 0, 0.8, 0) -- Tamaño de la miniatura
    thumbnail.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posición dentro del marco
    thumbnail.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) -- Obtener la miniatura
    thumbnail.BackgroundTransparency = 1 -- Fondo transparente
    thumbnail.Parent = welcomeFrame

    -- Nombre del jugador
    local username = Instance.new("TextLabel")
    username.Size = UDim2.new(0.6, 0, 0.3, 0) -- Tamaño del texto
    username.Position = UDim2.new(0.3, 0, 0.35, 0) -- Posición dentro del marco
    username.Text = "Welcome " .. player.Name
    username.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    username.BackgroundTransparency = 1 -- Fondo transparente
    username.TextScaled = true -- Escalar el texto
    username.Parent = welcomeFrame

    -- Animación de fade in
    local fadeIn = TweenService:Create(welcomeFrame, TweenInfo.new(1), {BackgroundTransparency = 0})
    fadeIn:Play()

    -- Esperar 3 segundos y luego hacer fade out
    delay(3, function()
        local fadeOut = TweenService:Create(welcomeFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        welcomeFrame:Destroy()
    end)
end

-- Crear el botón con la cabeza de Pikachu
local pikachuButton = Instance.new("ImageButton")
pikachuButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Tamaño del botón
pikachuButton.Position = UDim2.new(0, 0, 0, 0) -- Posición en la esquina superior izquierda
pikachuButton.BackgroundTransparency = 1 -- Fondo transparente
pikachuButton.Parent = gui

-- Cargar la imagen de Pikachu dinámicamente
local function loadImage()
    local success, result = pcall(function()
        -- Intenta cargar la imagen desde el AssetId
        pikachuButton.Image = "rbxassetid://14208141446"
        showNotification("Imagen cargada con éxito", false) -- Notificación de éxito
    end)
    if not success then
        showNotification("Error al cargar la imagen: " .. result, true) -- Notificación de error
    end
end

loadImage() -- Cargar la imagen al iniciar

-- Bordes redondeados para el botón
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.2, 0)
buttonCorner.Parent = pikachuButton

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
searchBox.PlaceholderText = "Buscar..."
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

-- Lista para guardar los scripts
local scriptsList = {}
local currentPage = 1
local scriptsPerPage = 6 -- Número de scripts por página

-- Función para mostrar los scripts en la página actual
local function showScripts()
    -- Limpiar los botones de la página actual
    for _, child in ipairs(menuFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Name == "ScriptButton" then
            child:Destroy()
        end
    end

    -- Calcular los scripts que deben mostrarse en la página actual
    local startIndex = (currentPage - 1) * scriptsPerPage + 1
    local endIndex = math.min(currentPage * scriptsPerPage, #scriptsList)

    -- Crear botones para los scripts de la página actual
    for i = startIndex, endIndex do
        local scriptData = scriptsList[i]
        local scriptButton = Instance.new("TextButton")
        scriptButton.Name = "ScriptButton"
        scriptButton.Size = UDim2.new(0.2, 0, 0.1, 0) -- Tamaño del botón
        scriptButton.Position = UDim2.new(0.05 + ((i - startIndex) % 3) * 0.25, 0, 0.3 + math.floor((i - startIndex) / 3) * 0.15, 0) -- Posición dinámica
        scriptButton.Text = scriptData.Name
        scriptButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
        scriptButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Color de fondo (gris oscuro)
        scriptButton.Parent = menuFrame

        -- Menú contextual (Ejecutar o Cancelar)
        local contextMenu = Instance.new("Frame")
        contextMenu.Size = UDim2.new(0.2, 0, 0.1, 0) -- Tamaño del menú contextual
        contextMenu.Position = UDim2.new(0, 0, 0.1, 0) -- Posición relativa al botón
        contextMenu.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3) -- Color de fondo (gris)
        contextMenu.Visible = false -- Inicialmente invisible
        contextMenu.Parent = scriptButton

        -- Botón "Ejecutar"
        local executeButton = Instance.new("TextButton")
        executeButton.Size = UDim2.new(0.8, 0, 0.4, 0) -- Tamaño del botón
        executeButton.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posición dentro del menú
        executeButton.Text = "Ejecutar"
        executeButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
        executeButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1) -- Color de fondo (azul)
        executeButton.Parent = contextMenu

        -- Botón "Cancelar"
        local cancelButton = Instance.new("TextButton")
        cancelButton.Size = UDim2.new(0.8, 0, 0.4, 0) -- Tamaño del botón
        cancelButton.Position = UDim2.new(0.1, 0, 0.6, 0) -- Posición dentro del menú
        cancelButton.Text = "Cancelar"
        cancelButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
        cancelButton.BackgroundColor3 = Color3.new(1, 0.2, 0.2) -- Color de fondo (rojo)
        cancelButton.Parent = contextMenu

        -- Mostrar/ocultar el menú contextual
        scriptButton.MouseButton1Click:Connect(function()
            contextMenu.Visible = not contextMenu.Visible
        end)

        -- Ejecutar el script
        executeButton.MouseButton1Click:Connect(function()
            local success, errorMessage = pcall(function()
                loadstring(scriptData.Content)() -- Ejecutar el script
            end)
            if not success then
                warn("Error al ejecutar el script: " .. errorMessage)
            end
            contextMenu.Visible = false
        end)

        -- Cancelar (ocultar el menú)
        cancelButton.MouseButton1Click:Connect(function()
            contextMenu.Visible = false
        end)
    end
end

-- Botón para ir a la página anterior
local prevButton = Instance.new("TextButton")
prevButton.Size = UDim2.new(0.1, 0, 0.05, 0) -- Tamaño del botón
prevButton.Position = UDim2.new(0.1, 0, 0.9, 0) -- Posición en la parte inferior izquierda
prevButton.Text = "Anterior"
prevButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
prevButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1) -- Color de fondo (azul)
prevButton.Parent = menuFrame

-- Botón para ir a la página siguiente
local nextButton = Instance.new("TextButton")
nextButton.Size = UDim2.new(0.1, 0, 0.05, 0) -- Tamaño del botón
nextButton.Position = UDim2.new(0.8, 0, 0.9, 0) -- Posición en la parte inferior derecha
nextButton.Text = "Siguiente"
nextButton.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
nextButton.BackgroundColor3 = Color3.new(0.2, 0.6, 1) -- Color de fondo (azul)
nextButton.Parent = menuFrame

-- Navegar a la página anterior
prevButton.MouseButton1Click:Connect(function()
    if currentPage > 1 then
        currentPage = currentPage - 1
        showScripts()
    end
end)

-- Navegar a la página siguiente
nextButton.MouseButton1Click:Connect(function()
    if currentPage < math.ceil(#scriptsList / scriptsPerPage) then
        currentPage = currentPage + 1
        showScripts()
    end
end)

-- Función para filtrar scripts por búsqueda
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = searchBox.Text:lower()
    showScripts() -- Mostrar todos los scripts primero
    if searchText ~= "" then
        for _, child in ipairs(menuFrame:GetChildren()) do
            if child:IsA("TextButton") and child.Name == "ScriptButton" then
                if not child.Text:lower():find(searchText) then
                    child.Visible = false -- Ocultar botones que no coincidan
                end
            end
        end
    end
end)

-- Función para abrir el menú de agregar script
addButton.MouseButton1Click:Connect(function()
    -- Crear un Frame para el menú de agregar script
    local addScriptFrame = Instance.new("Frame")
    addScriptFrame.Size = UDim2.new(0.4, 0, 0.3, 0) -- Tamaño del menú
    addScriptFrame.Position = UDim2.new(0.3, 0, 0.35, 0) -- Posición centrada
    addScriptFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Color de fondo (gris oscuro)
    addScriptFrame.Parent = menuFrame

    -- TextBox para el nombre del script
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(0.8, 0, 0.2, 0) -- Tamaño del TextBox
    nameBox.Position = UDim2.new(0.1, 0, 0.1, 0) -- Posición dentro del menú
    nameBox.Text = "Nombre del script"
    nameBox.TextColor3 = Color3.new(1, 1, 1) -- Color del texto (blanco)
    nameBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3) -- Color de fondo (gris)
    nameBox.Parent = addScriptFrame

    -- TextBox para el contenido del script
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(0.8, 0, 0.5, 0) -- Tamaño del TextBox
    scriptBox.Position = UDim2.new(0.1, 0, 0.4, 0) -- Posición dentro del menú
    scriptBox.Text = "Pega tu script aquí"
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

-- Variable para controlar si el menú está abierto o cerrado
local isMenuOpen = false

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

-- Conectar el botón de Pikachu para abrir/cerrar el menú
pikachuButton.MouseButton1Click:Connect(function()
    if isMenuOpen then
        closeMenu()
    else
        openMenu()
    end
end)

-- Función para mover el menú
local dragging = false
local dragStartPos = Vector2.new(0, 0)
local menuStartPos = Vector2.new(0, 0)

menuFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        menuStartPos = Vector2.new(menuFrame.Position.X.Offset, menuFrame.Position.Y.Offset)
    end
end)

menuFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local dragDelta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
        menuFrame.Position = UDim2.new(0, menuStartPos.X + dragDelta.X, 0, menuStartPos.Y + dragDelta.Y)
    end
end)

-- Mostrar la animación de bienvenida al iniciar
showWelcomeMessage()
