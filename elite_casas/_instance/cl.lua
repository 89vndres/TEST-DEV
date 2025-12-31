local ininstance = false
local currentinstancedata = nil

function Join(instance)
    if not ininstance then
        TriggerServerEvent("p_instance:s:join", instance)
    else
        print("Ya estas en una instancia")
    end
end

--[[RegisterNetEvent('p_instance:c:join')
AddEventHandler('p_instance:c:join', function(data)
    ininstance = true
    currentinstancedata = data 
    LocalPlayer.state:set('currentInstance', currentinstancedata.id, true)
    while ininstance do
        

        local visibles = {}

        for _,v in pairs(currentinstancedata.players) do
            visibles[v] = true
        end

		for _,i in pairs(GetActivePlayers()) do
            if i ~= PlayerId() then
                if visibles[GetPlayerServerId(i)] then
                    SetEntityVisible(GetPlayerPed(i), true, true)
                    SetEntityNoCollisionEntity(GetPlayerPed(i), PlayerPedId(), false)
                else
                    SetEntityVisible(GetPlayerPed(i), false, false)
                    SetEntityNoCollisionEntity(GetPlayerPed(i), PlayerPedId(), true)
                end
            end
		end
        MumbleClearVoiceTargetChannels(2)
		MumbleAddVoiceTargetChannel(2, currentinstancedata.voicechannel)
        NetworkSetVoiceChannel(currentinstancedata.voicechannel)


        SetEntityVisible(PlayerPedId(), true, true)


        Citizen.Wait(0)
    end

    currentinstancedata = nil

    LocalPlayer.state:set('currentInstance', nil, true)
    
    for _,i in pairs(GetActivePlayers()) do		
        SetEntityVisible(GetPlayerPed(i), true, true)
        SetEntityNoCollisionEntity(GetPlayerPed(i), PlayerPedId(), false)
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('p_instance:c:updatedata')
AddEventHandler('p_instance:c:updatedata', function(data)
    currentinstancedata = data
end)

RegisterNetEvent('p_instance:c:leave')
AddEventHandler('p_instance:c:leave', function()
    ininstance = false
end)]]