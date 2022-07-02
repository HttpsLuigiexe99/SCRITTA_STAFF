ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-----------------------------------------------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback("checkperms:fordisplay", function(source, cb)  --PERMESSI USER NON TOCCARE !!!
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerPems = player.getGroup()

        if playerPems ~= nil then 
            cb(playerPems)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------