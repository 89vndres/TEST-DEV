ESX.RegisterServerCallback("p_house:g:reqgarage", function(source,cb,id)
    local slots = GetGarage(id)
    cb(slots)
end)

function GetGarage(casa)
    local slots  = {}

    if casas[casa].garage.slot1 ~= nil then
        local data = casas[casa].garage.slot1
        data.slot = "slot1"
        table.insert(slots,data)
    end

    if casas[casa].garage.slot2 ~= nil then
        local data = casas[casa].garage.slot2
        data.slot = "slot2"
        table.insert(slots,data)
    end

    return slots
end

ESX.RegisterServerCallback('p_house:garage:s:StoreCar', function(source, cb, gid, v, netid) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local ent = NetworkGetEntityFromNetworkId(netid)
    local res = MySQL.Sync.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {["@plate"] = v.plate})
    local can
    
    if SoloAutosPersonales then
        if res[1] and res[1].owner == xPlayer.getIdentifier() then
            can = true
        else
            xPlayer.showNotification(Translation.notyours)
            can = false
        end
    else
        can = true
    end

    if can then
        if casas[gid].garage.slot1 == nil then
            casas[gid].garage.slot1 = v
            reqsync[gid] = true

            if DoesEntityExist(ent) then
                DeleteEntity(ent)
            end

            cb(true)
        elseif casas[gid].garage.slot2 == nil then
            casas[gid].garage.slot2 = v
            reqsync[gid] = true

            if DoesEntityExist(ent) then
                DeleteEntity(ent)
            end

            cb(true)
        else
            xPlayer.showNotification(Translation.nospace)
            cb(false)
        end
    end
end)

RegisterServerEvent('p_house:garage:s:removeslot')
AddEventHandler('p_house:garage:s:removeslot', function(slot,gid)
    casas[gid].garage[slot] = nil
    reqsync[gid] = true
end)

-- RegisterCommand('refreshDB', function(sr)
-- 	if sr == 0 then
-- 		print('Starting...')
-- 		MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
-- 			for k,v in ipairs(result) do
-- 				if Config.EnableDebug then
-- 					print('^5['..GetCurrentResourceName()..'] ^2[Items]^5 ['..v.name..'] ['..v.label..'] ^2Registed!^7')
-- 				end
-- 				ESX.Items[v.name] = {
-- 					label = v.label,
-- 					weight = v.weight,
-- 					rare = v.rare,
-- 					canRemove = v.can_remove
-- 				}
-- 			end
-- 		end)
-- 		MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
-- 			for k,v in ipairs(jobs) do
-- 				if Config.EnableDebug then
-- 					print('^5['..GetCurrentResourceName()..'] ^2[Jobs]^5 ['..v.name..'] ['..v.label..'] ^2Registed!^7')
-- 				end
-- 				ESX.Jobs[v.name] = v
-- 				ESX.Jobs[v.name].grades = {}
-- 			end
-- 			MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
-- 				for k,v in ipairs(jobGrades) do
-- 					if ESX.Jobs[v.job_name] then
-- 						ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
-- 					else
-- 						print(('^5[es_extended] [^3WARNING^7] Ignoring job grades for "%s" due to missing job^7'):format(v.job_name))
-- 					end
-- 				end
-- 				for k2,v2 in pairs(ESX.Jobs) do
-- 					if ESX.Table.SizeOf(v2.grades) == 0 then
-- 						ESX.Jobs[v2.name] = nil
-- 						print(('^5[es_extended] [^3WARNING^7] Ignoring job "%s" due to no job grades found^7'):format(v2.name))
-- 					end
-- 				end
-- 			end)
-- 		end)
-- 		Wait(10000)
-- 		print('Finished')
-- 	else
-- 		print('Hola12312')
-- 	end
-- end,true)