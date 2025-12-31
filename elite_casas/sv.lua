ESX = exports["es_extended"]:getSharedObject()

local casas = {}
local reqsync = {}

-- Función auxiliar para generar IDs aleatorios
function gid(length)
    local res = ""
    for i = 1, length do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function GetIdentName(ident)
    local xPlayer = ESX.GetPlayerFromIdentifier(ident)

    if xPlayer ~= nil then
        return xPlayer.getName()
    else 
        local r = MySQL.Sync.fetchAll('SELECT firstname,lastname FROM users WHERE identifier = @i',{
            ["@i"] = ident
        })
        if r[1] then
            return (r[1].firstname .. " " .. r[1].lastname)
        else
            return "nil"
        end
    end
end

-- =====================================================
-- CARGA DE DATOS AL INICIAR (MODIFICADO PARA OX)
-- =====================================================
MySQL.ready(function()
    local awa = MySQL.Sync.fetchAll('SELECT * FROM p_houses')
    casas = {}
    for _,v in pairs(awa) do
        local poses = {}

        if v.positions then
            for k,pos in pairs(json.decode(v.positions)) do
                poses[k] = vector3(pos.x, pos.y, pos.z)
            end
        end

        local garageData = {}
        if v.garage then
            local decodedGarage = json.decode(v.garage)
            if decodedGarage then
                garageData = decodedGarage
                for k,o in pairs(garageData) do
                    if type(o) == "table" and o.x ~= nil and o.y ~= nil and o.z ~= nil then
                        garageData[k] = vector3(o.x , o.y , o.z)
                    end
                end
            end
        end

        casas[v.id] = {
            id = v.id,
            owner = v.owner,
            interior = v.interior,
            positions = poses,
            furnish = v.furnish and json.decode(v.furnish) or {},
            pinside = {},
            data = v.data and json.decode(v.data) or {},
            pingar = {},
            garage = garageData
        }

        -- [OX_INVENTORY] Registramos el stash de cada casa al cargar el servidor
        -- Configuración: 50 slots y 200kg (200000 gramos). Puedes editar esto.
        local stashId = 'house_' .. v.id
        exports.ox_inventory:RegisterStash(stashId, 'Almacenamiento Casa', 50, 200000, nil)
    end
    print("[p_houses] Casas cargadas: " .. #awa) 
end)

-- BUCLE DE SINCRONIZACIÓN (Guardado automático)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Guarda cada 60 segundos

        local count = 0
        for k in pairs(reqsync) do
            count = count + 1
            local tsh = casas[k]
            if tsh ~= nil then
                MySQL.Async.execute('UPDATE p_houses SET positions = @positions, furnish = @furnish, data = @data, garage = @garage WHERE id = @id', {
                    ["@id"] = tsh.id,
                    ["@furnish"] = json.encode(tsh.furnish),
                    ["@positions"] = json.encode(tsh.positions),
                    ["@data"] = json.encode(tsh.data),
                    ["@garage"] = json.encode(tsh.garage),
                })
            end
            reqsync[k] = nil
        end

        if count > 0 then
            print("[^2p_houses^0] Sincronizado propiedades: "..count)
        end
    end
end)

-- EVENTOS DE JUGADOR
AddEventHandler('esx:playerLoaded', function(source)
    Citizen.Wait(4000)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local data = MySQL.Sync.fetchAll('SELECT UltimaCasa FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })

        if data[1] ~= nil and data[1].UltimaCasa ~= nil and casas[data[1].UltimaCasa] ~= nil then
            TriggerClientEvent("p_houses:c:join", source, casas[data[1].UltimaCasa])
        end
    end
end)

AddEventHandler('playerDropped', function()
    local _src = source
    for _,v in pairs(casas) do
        for k,p in pairs(v.pinside) do
            if p == _src then
                v.pinside[k] = nil
            end
        end

        for k,p in pairs(v.pingar) do
            if p == _src then
                v.pingar[k] = nil
            end
        end
    end
end)

-- EVENTOS DEL SCRIPT

RegisterServerEvent('p_h:s:reqall')
AddEventHandler('p_h:s:reqall', function()
    TriggerClientEvent("p_h:c:updateall", source, casas)
end)

RegisterServerEvent('p_houses:s:leave')
AddEventHandler('p_houses:s:leave', function(id)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if xPlayer then
        MySQL.Async.execute('UPDATE users SET UltimaCasa = NULL WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    end

    if casas[id] then
        for k,p in pairs(casas[id].pinside) do
            if p == _src then
                casas[id].pinside[k] = nil
            end
        end
    end
end)

RegisterServerEvent('p_houses:s:join')
AddEventHandler('p_houses:s:join', function(id)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if casas[id] then
        table.insert(casas[id].pinside, _src)
        
        if xPlayer then
            MySQL.Async.execute('UPDATE users SET UltimaCasa = @last_property WHERE identifier = @identifier', {
                ['@last_property'] = id,
                ['@identifier']    = xPlayer.identifier
            })
        end

        TriggerClientEvent("p_houses:c:join", _src, casas[id])
    end
end)

RegisterServerEvent('p_houses:s:updatefurnish')
AddEventHandler('p_houses:s:updatefurnish', function(id,fur)
    if casas[id] then
        casas[id].furnish = fur
        reqsync[id] = true

        for _,v in pairs(casas[id].pinside) do
            TriggerClientEvent("p_houses:c:updatef", v, fur)
        end
    end
end)

RegisterServerEvent('p_houses:s:updatelock')
AddEventHandler('p_houses:s:updatelock', function(id,bol)
    if casas[id] then
        casas[id].data.lock = bol
        reqsync[id] = true
        for _,v in pairs(casas[id].pinside) do
            TriggerClientEvent("p_houses:c:updatehouse", v, id, casas[id])
        end
    end
end)

RegisterServerEvent('p_houses:s:createhouse')
AddEventHandler('p_houses:s:createhouse', function(data)
    local thisid = gid(5)
    while casas[thisid] ~= nil do
        thisid = gid(5)
    end

    casas[thisid] = {
        id = thisid,
        interior = data.Interior,
        positions = {
            enter = data.Entrada
        },
        furnish = {},
        pinside = {},
        data = {
            lock = true,
            pack = true,
            keys = {}
        },
        pingar = {},
        garage = {}
    }

    if data["Entrada_Garage"] ~= nil then
        casas[thisid].garage.pos = data["Entrada_Garage"]
        casas[thisid].garage.enter = data["Salida_Garage"]
        casas[thisid].garage.hdg = data["rot"]
    end

    if data["prc"] ~= nil then
        casas[thisid].data.price = data["prc"]
    end

    -- Nota: Mantenemos el campo inventory en SQL solo para evitar errores de estructura, 
    -- pero ox_inventory guardará los items en su propia tabla.
    MySQL.Async.execute('INSERT INTO p_houses (id,interior,positions,data,garage,inventory) VALUES (@id,@interior,@positions,@data,@garage,@inventory)',{
        ["@id"] = thisid,
        ["@interior"] = casas[thisid].interior,
        ["@positions"] = json.encode(casas[thisid].positions),
        ["@data"] = json.encode(casas[thisid].data),
        ["@garage"] = json.encode(casas[thisid].garage),
        ['@inventory'] = json.encode({items = {}, weapons = {}, money = 0, black_money = 0})
    })

    -- [OX_INVENTORY] Registramos la nueva casa inmediatamente al crearla
    exports.ox_inventory:RegisterStash('house_'..thisid, 'Almacenamiento Casa', 50, 200000, nil)

    TriggerClientEvent("p_h:c:updateall", -1, casas)
end)

-- CALLBACKS Y OTRAS FUNCIONES (SISTEMA ANTIGUO ANULADO PARA EVITAR CONFLICTOS)

ESX.RegisterServerCallback('p_houses:getInventory', function(source, cb, inv)
    -- Devolvemos vacío para evitar errores de script, OX maneja el inventario real.
    cb({items = {}, weapons = {}, money = 0, black_money = 0})
end)

RegisterServerEvent('p_houses:setInventory')
AddEventHandler('p_houses:setInventory', function(type, id, table)
    -- Anulado: OX Inventory guarda automáticamente
end)

RegisterServerEvent('p_houses:deleteItems')
AddEventHandler('p_houses:deleteItems', function(name, count)
    -- Anulado
end)

ESX.RegisterServerCallback('p_houses:getInvPlayer', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer then
        cb(xPlayer.inventory)
    else
        cb({})
    end
end)

ESX.RegisterServerCallback('p_houses:gethouseinfo', function(source, cb, id) 
    cb(casas[id])
end)

ESX.RegisterServerCallback("p_houses:getplayername", function(source, cb, ident)
    cb(GetIdentName(ident))
end)

ESX.RegisterServerCallback("p_houses:getplayersnames" ,function(source, cb)
    local n = {}
    for _,v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer then
            n[v] = xPlayer.getName()
        end
    end
    cb(n)
end)

RegisterServerEvent('p_houses:s:updateowner')
AddEventHandler('p_houses:s:updateowner', function(id,new)
    local xPlayer = ESX.GetPlayerFromId(new)
    if xPlayer and casas[id] then
        local ident = xPlayer.getIdentifier()
        casas[id].owner = ident

        MySQL.Async.execute('UPDATE p_houses SET owner = @owner WHERE id = @id',{
            ["@owner"] = ident,
            ["@id"] = id
        })
        
        TriggerClientEvent("p_h:c:updateall", -1, casas)
    end
end)

RegisterServerEvent('p_houese:s:delhouse')
AddEventHandler('p_houese:s:delhouse', function(id)
    if casas[id] then
        for _,v in pairs(casas[id].pinside) do
            TriggerClientEvent("p_houses:c:forceleave", v)
        end
        
        MySQL.Async.execute('DELETE FROM p_houses WHERE id = @id',{
            ["@id"] = id
        })

        -- [OX_INVENTORY] Limpiamos el stash si se borra la casa (opcional)
        -- exports.ox_inventory:ClearInventory('house_'..id)

        casas[id] = nil
        TriggerClientEvent("p_h:c:updateall", -1, casas)
    end
end)

ESX.RegisterServerCallback("p_houses:trytobuy", function(source,cb,price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.showNotification("Pagaste ~g~$"..price.."~w~")
        cb(true)
    elseif xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
        xPlayer.showNotification("Pagaste ~g~$"..price.."~w~ de tu banco.")
        cb(true)
    else
        xPlayer.showNotification("No tenes suficiente dinero!")
        cb(false)
    end
end)

ESX.RegisterServerCallback("p_houses:getkeylist", function(source,cb,houseid)
    local t = casas[houseid]
    local data = {}
    if t then
        for i=1,5 do
            if t.data.keys[i] ~= nil then
                local id = t.data.keys[i]
                local name = GetIdentName(id)
                table.insert(data,{label = "Llave "..i..": "..name, k = i,val = id})
            else
                table.insert(data,{label = "Llave "..i..": libre", k = i})
            end
        end
    end
    cb(data)
end)

ESX.RegisterServerCallback("elite_casas:s:buyhouse", function(source,cb,hid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()
    
    if casas[hid] then
        local price = casas[hid].data.price
        local can = false

        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.showNotification("Pagaste ~g~$"..price.."~w~")
            can = true
        elseif xPlayer.getAccount('bank').money >= price then
            xPlayer.removeAccountMoney('bank', price)
            xPlayer.showNotification("Pagaste ~g~$"..price.."~w~ de tu banco.")
            can = true
        else
            xPlayer.showNotification("No tenes suficiente dinero!")
            can = false
        end

        if can then
            casas[hid].owner = ident

            MySQL.Async.execute('UPDATE p_houses SET owner = @owner WHERE id = @id',{
                ["@owner"] = ident,
                ["@id"] = hid
            })

            TriggerClientEvent("p_h:c:updateall", -1, casas)
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('p_houses:s:givekey')
AddEventHandler('p_houses:s:givekey', function(llave, casa, id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer and casas[casa] then
        casas[casa].data.keys[llave] = xPlayer.getIdentifier()
        reqsync[casa] = true

        xPlayer.showNotification("Te dieron la llave de la propiedad "..casa)
        xPlayer.triggerEvent("p_houses:c:addkey", casa)
    end
end)

RegisterServerEvent('p_houses:s:removekey')
AddEventHandler('p_houses:s:removekey', function(llave, casa)
    if casas[casa] and casas[casa].data.keys[llave] then
        local targetIdentifier = casas[casa].data.keys[llave]
        local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
        
        casas[casa].data.keys[llave] = nil
        reqsync[casa] = true
        
        if xPlayer then
            xPlayer.showNotification("Te sacaron la llave de la propiedad "..casa)
            xPlayer.triggerEvent("p_houses:c:removekey", casa)
        end
    end
end)

RegisterServerEvent('p_houses:s:reqkeys')
AddEventHandler('p_houses:s:reqkeys', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local mykeys = {}
    if xPlayer then
        for ID,v in pairs(casas) do
            if v.data and v.data.keys then
                for _,m in pairs(v.data.keys) do
                    if m and m == xPlayer.identifier then
                        mykeys[ID] = true
                    end
                end
            end
        end
    end
    TriggerClientEvent("p_houses:c:reckeys",_src,mykeys)
end)

-- COMANDOS
local JobActivo = false -- Ajusta esto si usas un sistema de trabajos específico
local JobName = "realestateagent" -- Ajusta el nombre del trabajo

if JobActivo then
    ESX.RegisterCommand("propiedad", "user", function(xPlayer, args)
        if xPlayer.getJob().name == JobName then
            TriggerClientEvent("p_houses:c:crearpropiedad", xPlayer.source)
        end
    end)
else
    ESX.RegisterCommand("propiedad", "admin", function(xPlayer, args)
        TriggerClientEvent("p_houses:c:crearpropiedad", xPlayer.source)
    end)
end

-- DATOS DE VESTIMENTA (ESX_PROPERTY COMPATIBILIDAD)
ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local count  = store.count('dressing')
        local labels = {}

        for i=1, count, 1 do
            local entry = store.get('dressing', i)
            table.insert(labels, entry.label)
        end

        cb(labels)
    end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
    local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local outfit = store.get('dressing', num)
        cb(outfit.skin)
    end)
end)