local dispchannel = {}
local instances = {}

for i=1,64 do
    dispchannel[i] = true
end

function GetFreeChannel()
    for k,v in pairs(dispchannel) do
        if v == true then
            dispchannel[k] = false
            return k
        end
    end
end

AddEventHandler('playerDropped', function()
	LeaveInstance(source,true)
end)

RegisterServerEvent('p_instance:s:leave')
AddEventHandler('p_instance:s:leave', function()
    local _src = source
    exports[NombreDePma]:updateRoutingBucket(_src, 0)
    LeaveInstance(_src)
end)

function LeaveInstance(playerid, dropped)
    for k,v in pairs(instances) do
        local thisupdate = false
        for a,b in pairs(v.players) do
            if b == playerid then
                thisupdate = true
                v.players[a] = nil
                break
            end
        end
        if thisupdate then
            if #instances[k].players == 0 then
                dispchannel[instances[k].bucket] = true
                instances[k] = nil
            end
        end
    end
end

RegisterServerEvent('p_instance:s:join')
AddEventHandler('p_instance:s:join', function(id) --entrar a la instancia
    local _src = source
    if instances[id] == nil then -- si la instancia no existe la crea
        instances[id] = { 
            id = id, --nombr ede instancia
            bucket = GetFreeChannel(), -- canal de voz
            players = {source} -- jugadores dentro
        }
    else -- si existe te mete en esa
        table.insert(instances[id].players, source) 
    end
    SetRoutingBucketPopulationEnabled(instances[id].bucket,false)
    exports[NombreDePma]:updateRoutingBucket(_src,instances[id].bucket)
end)

RegisterCommand("instance_debug",function()
    print(json.encode(instances))
end)