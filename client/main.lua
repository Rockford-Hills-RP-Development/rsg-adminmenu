local RSGCore = exports['rsg-core']:GetCoreObject()
local ShowingCoords = false

-- start menu
local menuLocation = 'topright'
local menuSize = 'size-125'
local mainMenu = MenuV:CreateMenu(false, Lang:t('menu.admin_menu'), menuLocation, 220, 20, 60, menuSize, 'qrcore', 'menuv', 'topmenu')
local developerOptions = MenuV:CreateMenu(false, Lang:t('menu.developer_options'), menuLocation, 220, 20, 60, menuSize, 'qrcore', 'menuv', 'devmenu')

local mainMenu_button1 = mainMenu:AddButton({
    icon = '🔧',
    label = Lang:t('menu.developer_options'),
    value = developerOptions,
    description = Lang:t('desc.developer_desc')
})

-- developer options
developerOptions:On('open', function(menu)
    menu:ClearItems()
    menu:AddCheckbox({
    icon = '📍',
    value = nil,
    label = Lang:t('menu.display_coords'),
    change = function(btn)
      ToggleShowCoordinates()
    end})
    menu:AddCheckbox({
    icon = '🛫',
    value = nil,
    label = Lang:t('menu.noclip'),
    change = function(btn)
      ToggleNoclip()
    end})
    menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_vector3'),
    select = function(btn)
      CopyToClipboard('coords3')
    end})
    menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_vector4'),
    select = function(btn)
      CopyToClipboard('coords4')
    end})
    menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_heading'),
    select = function(btn)
      CopyToClipboard('heading')
    end})
end)

CopyToClipboard = function(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        SendNUIMessage({ string = string.format('vector3(%s, %s, %s)', x, y, z) })
        RSGCore.Functions.Notify(Lang:t("success.coords_copied"), 'success')
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({ string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h) })
        RSGCore.Functions.Notify(Lang:t("success.coords_copied"), 'success')
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({ string = h })
        RSGCore.Functions.Notify(Lang:t("success.heading_copied"), 'success')
    end
end

ToggleShowCoordinates = function()
    ShowingCoords = not ShowingCoords
    CreateThread(function()
        while ShowingCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = round(coords.x, 2)
            c.y = round(coords.y, 2)
            c.z = round(coords.z, 2)
            c.w = round(heading, 2)
            Wait(0)
            DrawScreenText(string.format('~w~COORDS: ~b~vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, c.w), 0.4, 0.025, true)
        end
    end)
end

round = function(input, decimalPlaces)
  return tonumber(string.format('%.' .. (decimalPlaces or 0) .. 'f', input))
end

DrawScreenText = function(text, x, y, centred)
    SetTextScale(0.35, 0.35)
    SetTextColor(255, 255, 255, 255)
    SetTextCentre(centred)
    SetTextDropshadow(1, 0, 0, 0, 200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

ToggleNoclip = function()
    TriggerEvent('admin:client:ToggleNoClip')
end

RegisterNetEvent('admin:client:OpenMenu', function()
    MenuV:OpenMenu(mainMenu)
end)
