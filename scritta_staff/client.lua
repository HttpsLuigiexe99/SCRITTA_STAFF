ESX = nil
local activated = false
-----------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
function DrawStaffOverSkin(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(2)
	SetTextProportional(4)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255,117,20,20)  --COLORE 
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 700
end
-----------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('staff', function()  --METTI TAG
    ESX.TriggerServerCallback("checkperms:fordisplay", function(permschecked)
        if permschecked == "superadmin" or permschecked == "admin" or permschecked == "mod" then  --PERMESSI
            if activated == false then
                TriggerServerEvent('on:logs')
            end
            activated = true
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local offset = 1
                    local Mycoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local coords = GetEntityCoords(PlayerPedId(), false)
                    local dist = Vdist2(Mycoords, coords)
                    if dist < 5 then
                        if activated == true then
                            DrawStaffOverSkin(Mycoords.x,  Mycoords.y,  Mycoords.z + 1, "STAFF", 2.0) --NOME STAFF//
                        end
                    end
                end
            end)
            ESX.ShowNotification("Modalità staff on")
        else
            ESX.ShowNotification("Non sei staff")
        end
    end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nostaff', function()   --TOGLI TAG
    ESX.TriggerServerCallback("checkperms:fordisplay", function(permschecked)
        if permschecked == "superadmin" or permschecked == "admin" or permschecked == "mod" then  --PERMESSI
            activated = false
            ESX.ShowNotification("Modalità staff of")
        else
            ESX.ShowNotification("Non sei staff")
        end 
    end)
    if activated == true then
        TriggerServerEvent('off:logs')
    end
end)
