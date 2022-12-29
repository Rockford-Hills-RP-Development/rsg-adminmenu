local RSGCore = exports['rsg-core']:GetCoreObject()

local permissions = {
    ['noclip'] = 'admin',
    ['showcoords'] = 'admin',
}

RSGCore.Commands.Add('admin', 'Open the admin menu (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('admin:client:OpenMenu', src)
end, 'admin')

RSGCore.Commands.Add('noclip', 'No Clip (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('admin:client:ToggleNoClip', src)
end, 'admin')

RSGCore.Functions.CreateCallback('admin:server:hasperms', function(source, cb, action)
    local src = source
    if RSGCore.Functions.HasPermission(src, permissions[action]) or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)
