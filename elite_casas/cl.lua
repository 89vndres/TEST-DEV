ESX = exports["es_extended"]:getSharedObject()

local props = {}
local propsid = {}
local selctmoveobj = nil
local selecting = 0
local mini = false
-- ========
local thishouse = nil
local inhouse = false
local hasjob = false
local mykeys = {}
local blips = {}
local playerloaded = false
local i = 0.0


AddEventHandler("esx:onPlayerSpawn",function()
    playerloaded = true
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    SetNuiFocus(bol, bol)

    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(1000)
    end
    TriggerServerEvent("p_h:s:reqall")
    TriggerServerEvent("p_houses:s:reqkeys")
    pd = ESX.GetPlayerData()

    if pd.job.name == JobName then
        hasjob = true
    else
        hasjob = false
    end
  

    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()
        Wait(5000) --The idle camera activates after 30 second so we don't need to call this per frame
        RefreshNear()
    end
    
end)

Citizen.CreateThread(function()
    Citizen.Wait(12000)
    SendNUIMessage({
        target = "setdata",
        name = GetCurrentResourceName(),
        data = Shop
    })
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    pd.job = job

    if pd.job.name == JobName then
        hasjob = true
    else
        hasjob = false
    end
end)

local creating = false

function creaobj(data) 
    creating = true
    local model = GetHashKey(data.m)
    local a,b = GetModelDimensions(model)
    local dim = b
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, dim.x + 1.0, -1.0 )
    local hdg = GetEntityHeading(PlayerPedId())    
    
    if type(name) == "number" then
        model = name
    end

    if IsModelValid(model) then
        creating = true
        if preprop and DoesEntityExist(preprop.ent) then
            DeleteEntity(preprop.ent)
            preprop = nil
        end

        while not HasModelLoaded(model) do
            Citizen.Wait(1)
            RequestModel(model)
        end

        local obj = CreateObject(model,coords,false,true) --poner local

        SetEntityAsMissionEntity(obj, true, true)

        SetEntityHeading(obj, hdg)

        FreezeEntityPosition(obj, true)

        preprop = {
            ent = obj,
            data = data
        }

        propsid[obj] = "test"
        creating = false
    else
        creating = false
        ESX.ShowNotification('Invalido')
    end
end

RegisterNUICallback("PONERLA", function(d)
    if preprop and preprop.ent then
        local si = nil

        if houses[thishouse].data.pack and not preprop.data.fp then
            si = true
        else
            si = nil
            ESX.TriggerServerCallback("p_houses:trytobuy", function(data) 
                si = data
            end, preprop.data.price)
            while si == nil do Citizen.Wait(0) end
        end

        if si then
            local ser = gid(5)
            while props[ser] ~= nil do
                ser = gid(5)
            end
                
            propsid[preprop.ent] = ser

            props[ser] = {
                crd = GetEntityCoords(preprop.ent),
                    rot = GetEntityRotation(preprop.ent, 2),
                data = preprop.data
            }

            TriggerServerEvent("p_houses:s:updatefurnish", thishouse, props)
            preprop = nil
            SendNUIMessage({
                target = "toggleselected",
                value = false
            })
        else
            DeleteEntity(preprop.ent)
            preprop = nil
        end
        
    end
end)

RegisterNUICallback("cancelpre", function(d)
    if preprop and preprop.ent then
        DeleteEntity(preprop.ent)
        preprop = nil
        SendNUIMessage({
            target = "toggleselected",
            value = false
        })
    end
end)

RegisterNUICallback("place", function(d,cb)
    if not creating then
        creaobj(d.obj)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNUICallback("escape", function()
    bol = false
    SetNuiFocus(bol, bol)
    if preprop and preprop.ent then
        DeleteEntity(preprop.ent)
        preprop = nil
    end
end)

local lastonent = 0
Citizen.CreateThread(function()
    while true do
        local w = 2000

        if inhouse then
            w = 500
            if bol and not mini then 
                w = 50 
            
                local hit,ent = ScreenToEnt()

                if lastonent ~= ent then
                    ResetEntityAlpha(lastonent)
                end
            
                if hit then
                    if propsid[ent] then
                        SetEntityAlpha(ent, 200)
                    end
                    lastonent = ent
                end
            else
                ResetEntityAlpha(lastonent)
            end        

            if bol and not selecting ~= 0 and selctmoveobj~=nil and DoesEntityExist(selctmoveobj) then
                local a,b = GetModelDimensions(GetEntityModel(selctmoveobj))
                local d = b-a
                w = 0
                DrawMarker(2, GetEntityCoords(selctmoveobj)+vector3(0.0,0.0,d.z), 0.0,0.0,0.0,0.0,0.0,0.0, 0.3, 0.3, -0.1, 255, 255, 255, 100, false, false,false,true)
            end
        end
        Citizen.Wait(w)
    end
end)

Citizen.CreateThread(function()
    while true do
        local w = 2000
        if inhouse then
            w = 100
            if bol and mini then
                w = 0 
                DisableControlAction(0, 19, true)
                DisableControlAction(0, 25, true)
                if IsDisabledControlJustReleased(0, 25) then
                    SetNuiFocus(true, true)
                    mini = false
                end
            end
        end

        Citizen.Wait(w)
    end
end)

RegisterNUICallback("FocusOff", function()
    SetNuiFocus(false, false)
    mini = true
end)


RegisterNUICallback("ToggleSelect", function(data)
    local this = data.v

    if this == selecting then
        this = 0
    end 

    selecting = this

    SendNUIMessage({
        target = "toggle",
        bol = this,
    })

    if this == 2 then
        selctmoveobj = nil
    end
    --selctmoveobj = nil
end)


local thisoffset = vector3(0.0,0.0,0.0)
RegisterNUICallback("OnClick", function()
    if selctmoveobj ~= nil then
        if selecting == 2 then --codigo de mover cosas
            SetEntityCollision(selctmoveobj, true, true)
            local thisser = propsid[selctmoveobj]
            if thisser ~= "test" then
                props[thisser].crd = GetEntityCoords(selctmoveobj)
                props[thisser].rot = GetEntityRotation(selctmoveobj, 2)
            end

            selctmoveobj = nil
            thisoffset = vector3(0.0,0.0,0.0)
            --print("refreshco")
            TriggerServerEvent("p_houses:s:updatefurnish", thishouse, props)
            pop()
            SendNUIMessage({
                target = "toggleselected",
                value = false
            })
        else
            local hit,ent = ScreenToEnt()
            if hit and IsEntityAnObject(ent) and propsid[ent] then
                selctmoveobj = nil
                thisoffset = vector3(0.0,0.0,0.0)
                pop()
                SendNUIMessage({
                    target = "toggleselected",
                    value = false
                })
            end
        end
        
    else
        local hit,ent = ScreenToEnt()
        if hit and IsEntityAnObject(ent) and propsid[ent] then
            pop()
            selctmoveobj = ent
            local hsh = GetEntityModel(selctmoveobj)
            local o , _ = GetModelDimensions(hsh)
            thisoffset = vector3(0.0,0.0,-o.z)
            SendNUIMessage({
                target = "toggleselected",
                value = true
            })

            SendNUIMessage({
                target = "refresh",
                coords = GetEntityCoords(selctmoveobj),
                rotation = GetEntityRotation(selctmoveobj, 2)
            })

            if selecting == 3 then
                selecting = 2

                SendNUIMessage({
                    target = "toggle",
                    bol = selecting,
                })
            end
        end
    end
end)

RegisterNUICallback("onmove", function(data)
    if selecting == 2 then
        if selctmoveobj ~= nil and IsEntityAnObject(selctmoveobj) then
            SetEntityCollision(selctmoveobj, false, false)
            local hit,c = ScreenToWorld()
            if hit then
                SetEntityCoords(selctmoveobj, c + thisoffset)
                if data then
                    local h = GetEntityHeading(selctmoveobj)
                    local roundh = math.ceil(math.floor(h)/2.5)*2.5
                    SetEntityHeading(selctmoveobj, roundh + data.val*2.5)
                end 
                SendNUIMessage({
                    target = "refresh",
                    coords = GetEntityCoords(selctmoveobj),
                    rotation = GetEntityRotation(selctmoveobj, 2)
                })
            end
        end
    end
end)

RegisterNUICallback("updatepos", function(data)
    local oc = GetEntityCoords(selctmoveobj)
    local ort = GetEntityRotation(selctmoveobj, 2)

    local nc = vector3(
        data.pos.x ~= nil and tonumber(data.pos.x) or oc.x,
        data.pos.y ~= nil and tonumber(data.pos.y) or oc.y,
        data.pos.z ~= nil and tonumber(data.pos.z) or oc.z
    )

    local nr = vector3(
        data.rot.x ~= nil and Round(tonumber(data.rot.x)) or ort.x,
        data.rot.y ~= nil and Round(tonumber(data.rot.y)) or ort.y,
        data.rot.z ~= nil and Round(tonumber(data.rot.z)) or ort.z
    )

    if data.refresh then
        local thisser = propsid[selctmoveobj]
        if thisser ~= "test" then
            props[thisser].crd = GetEntityCoords(selctmoveobj)
            props[thisser].rot = GetEntityRotation(selctmoveobj, 2)
        end
        TriggerServerEvent("p_houses:s:updatefurnish", thishouse, props)
    end 

    SetEntityCoords(selctmoveobj, nc)
    SetEntityRotation(selctmoveobj, nr, 2)

end)

RegisterNUICallback("DeleteObj", function()
    if selctmoveobj ~= nil then
        local thisser = propsid[selctmoveobj]
        DeleteEntity(selctmoveobj)
        selctmoveobj = nil
        SendNUIMessage({
            target = "toggleselected",
            value = false
        })
        props[thisser] = nil
        TriggerServerEvent("p_houses:s:updatefurnish", thishouse, props)
        SendNUIMessage({
            target = "toggleselected",
            value = false
        })
    end
end)

RegisterNetEvent('p_houses:c:updatef')
AddEventHandler('p_houses:c:updatef', function(data)
    spprops ={}
    for k,v in pairs(propsid) do
        spprops[v] = k
    end

    props = data

    for k,v in pairs(props) do
        if spprops[k] then
            if not preprop or spprops[k] ~= preprop.ent then
                local obj = spprops[k]
                SetEntityCoords(obj, v.crd.x,v.crd.y,v.crd.z)
                SetEntityRotation(obj, v.rot.x,v.rot.y,v.rot.z, 2)
                SetEntityCollision(obj, true, true)
            end
        else
            local model = GetHashKey(v.data.m)
            while not HasModelLoaded(model) do
                Citizen.Wait(1)
                RequestModel(model)
            end
    
            local obj = CreateObject(model,v.crd.x,v.crd.y,v.crd.z,false,true) --poner local
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityRotation(obj, v.rot.x,v.rot.y,v.rot.z, 2)
            FreezeEntityPosition(obj, true)
            propsid[obj] = k
        end        
    end

    for k,v in pairs(propsid) do
        if v ~= "test" and props[v] == nil then
            DeleteEntity(k)
        end
    end
end)

RegisterNetEvent('p_h:c:updateall')
AddEventHandler('p_h:c:updateall', function(data)
    houses = data
    RefreshNear()
    UpdateBlips()
end)

local lac = 0

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local lastType, lastText, lastButton, lastTitle = nil, nil, nil, nil

    while true do
        local p = PlayerPedId()
        local ps = GetEntityCoords(p)
        local wait = 1000
        local inZone = false
        local currentText, currentType, currentButton, currentTitle

        if next(nearhouses) ~= nil then
            for k,v in pairs(nearhouses) do
                local ds = #(v.positions.enter - ps)

                if ds < 1.0 then
                    inZone = true
                    wait = 5
                    currentType = 'show'
                    currentText = Translation.HelpEntry or "Entrar a la casa"
                    currentButton = "E"
                    currentTitle = "INTERACCIÓN"

                    if IsControlJustPressed(0, 38) then
                        local timer = GetGameTimer()
                        if timer - lac > 500 then
                            HomeDoorMenu(k, v)
                            lac = timer
                        end
                    end
                elseif ds < 30.0 then
                    DrawMarker(2, v.positions.enter, 0.0,0.0,0.0, 0.0,0.0,0.0, 0.2, 0.2, -0.12, 255, 200, 0, 100, false, true)
                    wait = 5
                end

                if (houses[k].owner and houses[k].owner == pd.identifier) or (mykeys[k] ~= nil) then
                    if v.garage.pos then
                        if IsPedInAnyVehicle(p) then
                            local ds = #(v.garage.enter - ps)
                            if ds < 2.5 then
                                inZone = true
                                wait = 5
                                currentType = 'garage'
                                currentText = Translation.SaveGarage or "Guardar Vehículo"
                                currentButton = "E"
                                currentTitle = "INTERACCIÓN"

                                if IsControlJustPressed(0, 38) then
                                    local timer = GetGameTimer()
                                    if timer - lac > 500 then
                                        -- [INTEGRACION LUNAR GARAGE] GUARDAR COCHE (Corregido: usando TriggerEvent)
                                        local garageName = "house_" .. k
                                        TriggerEvent('lunar_garage:open', {
                                            name = garageName,
                                            type = "house",
                                            owner = houses[k].owner
                                        })
                                        lac = timer
                                    end
                                end
                            elseif ds < 30.0 then
                                DrawMarker(2, v.garage.enter, 0.0,0.0,0.0, 0.0,0.0,0.0, 0.2, 0.2, -0.12, 255, 200, 0, 100, false, true)
                                wait = 5
                            end
                        else
                            local ds = #(v.garage.pos - ps)
                            if ds < 1.0 then
                                inZone = true
                                wait = 5
                                currentType = 'garage'
                                currentText = Translation.HelpGarage or "Abrir Garage"
                                currentButton = "E"
                                currentTitle = "INTERACCIÓN"

                                if IsControlJustPressed(0, 38) then
                                    local timer = GetGameTimer()
                                    if timer - lac > 500 then
                                        -- [INTEGRACION LUNAR GARAGE] ABRIR MENU (Corregido: usando TriggerEvent)
                                        local garageName = "house_" .. k
                                        TriggerEvent('lunar_garage:open', {
                                            name = garageName,
                                            type = "house",
                                            owner = houses[k].owner
                                        })
                                        lac = timer
                                    end
                                end
                            elseif ds < 30.0 then
                                DrawMarker(2, v.garage.pos, 0.0,0.0,0.0, 0.0,0.0,0.0, 0.2, 0.2, -0.12, 255, 200, 0, 100, false, true)
                                wait = 5
                            end
                        end
                    end
                end
            end
        end

        -- Mostrar u ocultar drawtextui
        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            lastType, lastText, lastButton, lastTitle = currentType, currentText, currentButton, currentTitle
            TriggerEvent('am_drawtextui:ShowUI', currentType, currentText, currentButton, currentTitle)
        elseif inZone and alreadyEnteredZone and (
            currentType ~= lastType or currentText ~= lastText or currentButton ~= lastButton or currentTitle ~= lastTitle
        ) then
            lastType, lastText, lastButton, lastTitle = currentType, currentText, currentButton, currentTitle
            TriggerEvent('am_drawtextui:ShowUI', currentType, currentText, currentButton, currentTitle)
        elseif not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('am_drawtextui:HideUI')
            lastType, lastText, lastButton, lastTitle = nil, nil, nil, nil
        end

        Citizen.Wait(wait)
    end
end)
function HomeDoorMenu(k,v) --agregar gestion para empleados
    ESX.TriggerServerCallback('p_houses:gethouseinfo', function(house)
        houses[k] = house
        local elems = {}
        table.insert(elems, {label = Translation.Entry, v= "join"})
    
        if houses[k].data.lock then
            table.insert(elems, {label = Translation.Locked, v= "lock"})
        else
            table.insert(elems, {label = Translation.Unlocked, v= "lock"})
        end

        if hasjob or (houses[k].owner and houses[k].owner == pd.identifier) then
            table.insert(elems, {label = Translation.Administrar, v= "admin"})
        end

        if houses[k].data.price and houses[k].owner == nil then
            table.insert(elems, {label = Translation.Buy..houses[k].data.price, v= "buy"})
        end
    
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_door_xd', {
            title    = Translation.PrTitle,
            align    = 'bottom-right',
            elements = elems
        }, function(data, menu)
            local c = data.current 
            if c.v == "join" then
                if houses[k].data.lock then 
                    ESX.ShowNotification(Translation.DoorClosed)
                else
                    TriggerServerEvent("p_houses:s:join", k)
                    menu.close()
                end
            elseif c.v == "lock" then
                local t = houses[k]
                if (t.owner == nil and hasjob) or (v.owner and v.owner == pd.identifier) or (mykeys[t.id] ~= nil) then
                    houses[k].data.lock = not houses[k].data.lock

                    if houses[k].data.lock then
                        c.label = Translation.Locked
                    else
                        c.label = Translation.Unlocked
                    end
                    TriggerServerEvent("p_houses:s:updatelock", k, houses[k].data.lock)
                    menu.update({v = c.v}, c)
                    menu.refresh()
                else
                    ESX.ShowNotification(Translation.NoKeys)
                end
            elseif c.v == "admin" then
                AdminMenu(k)
                menu.close()
            elseif c.v == "buy" then
                local res = nil

                ESX.TriggerServerCallback("elite_casas:s:buyhouse", function(ndd) 
                    res = ndd
                end, k)

                while res == nil do Citizen.Wait(100) end

                if res then
                    menu.close()
                end
            end        
        end, function(data, menu)
            menu.close()
        end)
    end,k)    
end

function AdminMenu(houseid)
    ESX.TriggerServerCallback('p_houses:gethouseinfo', function(house)
        houses[houseid] = house
        local this = {}

        if houses[houseid].owner == nil then
            table.insert(this,{label = Translation.Ownerselect, v = "dueno"})
            table.insert(this,{label = Translation.DeleteProperty, v = "elm"})
        else    
            local n = nil
            ESX.TriggerServerCallback("p_houses:getplayername", function(name) 
                n = name
            end, houses[houseid].owner)
            while n == nil do Citizen.Wait(0) end

            table.insert(this,{label = Translation.OwnerHouse..n})

            if houses[houseid].owner == pd.identifier then
                table.insert(this, {label = Translation.TransferProp, v = "dueno"})
            end 
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_admin_dyn', {
            title    = 'Administrar propiedad',
            align    = 'bottom-right',
            elements = this
        }, function(data, menu)
            local c = data.current
            if c.v == "mub" then
                c.value = not c.value
                if c.value then
                    c.label = "Pack muebles: <span style = 'color:green;'> SI"
                else
                    c.label = "Pack muebles: <span style = 'color:red;'> NO"
                end
                TriggerServerEvent("p_houses:s:packasao",houseid, c.value)
                menu.update({v = c.v}, c)
                menu.refresh()
            elseif c.v == "dueno" then
                local nametable = nil

                ESX.TriggerServerCallback("p_houses:getplayersnames", function(data) 
                    nametable = data
                end)

                while nametable == nil do Citizen.Wait(0) end

                local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 10.0)
                table.insert(players, PlayerId())
                if #players > 0 then
                    local asd = {}
                    for _,v in pairs(players) do
                        local sid = GetPlayerServerId(v)

                        table.insert(asd,{label = "["..sid.."] "..nametable[sid],id = sid})
                    end 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_select_owner', {
                        title    = Translation.Ownerselect,
                        align    = 'bottom-right',
                        elements = asd
                    }, function(data2, menu2)
                        TriggerServerEvent("p_houses:s:updateowner", houseid, data2.current.id)
                        menu2.close()
                        menu.close()
                        AdminMenu(houseid)
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                else
                    ESX.ShowNotification(Translation.NoPlyNearby)
                end
            elseif c.v == "elm" then

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_confirm', {
                    title    = Translation.SureDel,
                    align    = 'bottom-right',
                    elements = {
                        {label = Translation.yes,v = "n"},
                        {label = Translation.no,v = "s"}
                    }
                }, function(data2, menu2)
                    if data2.current.v == "s" then
                        TriggerServerEvent("p_houese:s:delhouse",houseid)
                    end        
                    menu2.close()
                    menu.close()       
                end, function(data2, menu2)
                    menu.close()
                end)
            end
        end, function(data, menu)
            menu.close()
        end)

    end,houseid)    
end

function HomeIntDoorMenu()
    --aca me quede perrras
        local elems = {}
        table.insert(elems, {label = "Salir", v= "join"})
    
        if houses[thishouse].data.lock then
            table.insert(elems, {label = "Puerta: <span style='color:red;'> Bloqueada", v= "lock"})
        else
            table.insert(elems, {label = "Puerta: <span style='color:green;'> Abierta", v= "lock"})
        end

        if houses[thishouse].owner and houses[thishouse].owner == pd.identifier then
            table.insert(elems, {label = "Administrar llaves", v= "key"})
        end

        table.insert(elems, {label = 'Amueblar Casa', v= 'furni'})
    
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_door_xd', {
            title    = 'Propiedad',
            align    = 'bottom-right',
            elements = elems
        }, function(data, menu)
            local c = data.current 
            if c.v == "join" then
                if houses[thishouse].data.lock then 
                    ESX.ShowNotification('La puerta esta cerrada')
                else
                    inhouse = false
                    --print("salmnu")
                    menu.close()
                end
            elseif c.v == "lock" then

                if (houses[thishouse].owner == nil and hasjob) or (houses[thishouse].owner and houses[thishouse].owner == pd.identifier) or (mykeys[thishouse] ~= nil) then
                    houses[thishouse].data.lock = not houses[thishouse].data.lock

                    if houses[thishouse].data.lock then
                        c.label = "Puerta: <span style='color:red;'> Bloqueada"
                    else
                        c.label = "Puerta: <span style='color:green;'> Abierta"
                    end
                    TriggerServerEvent("p_houses:s:updatelock", thishouse, houses[thishouse].data.lock)
                    menu.update({v = c.v}, c)
                    menu.refresh()
                else
                    ESX.ShowNotification("No tenes las llaves de la casa!")
                end
            elseif c.v == "key" then
                Keys()
                menu.close()
            elseif c.v == 'furni' then 
                ESX.ShowNotification("Presiona ~r~M~w~ para amueblar las casas")
            end        
        end, function(data, menu)
            menu.close()
        end)
end

function Keys()
    ESX.TriggerServerCallback("p_houses:getkeylist", function(elems) 
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_gest_keys', {
            title    = 'Llaves',
            align    = 'bottom-right',
            elements = elems
        }, function(data, menu)
            local c = data.current
            
            if c.val ~= nil then
                TriggerServerEvent("p_houses:s:removekey", c.k, thishouse)
                menu.close()
                Keys()
            else
                local nametable = nil

                ESX.TriggerServerCallback("p_houses:getplayersnames", function(data) 
                    nametable = data
                end)

                while nametable == nil do Citizen.Wait(0) end

                local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 10.0)
                table.insert(players, PlayerId())
                if #players > 0 then
                    local asd = {}
                    for _,v in pairs(players) do
                        local sid = GetPlayerServerId(v)

                        table.insert(asd,{label = "["..sid.."] "..nametable[sid],id = sid})
                    end 
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_select_owner', {
                        title    = 'Seleccionar persona',
                        align    = 'bottom-right',
                        elements = asd
                    }, function(data2, menu2)
                        TriggerServerEvent("p_houses:s:givekey", c.k, thishouse, data2.current.id)
                        menu2.close()
                        menu.close()
                        Keys()
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                else
                    ESX.ShowNotification("No hay jugadores cerca")
                end
            end        
        end, function(data, menu)
            menu.close()
        end)
    end,thishouse)
end

RegisterNetEvent('p_houses:c:updatehouse')
AddEventHandler('p_houses:c:updatehouse', function(house,data)
    houses[house] = data
end)

RegisterNetEvent('p_houses:c:join')
AddEventHandler('p_houses:c:join', function(data)
    houses[data.id] = data
    thishouse = data.id
    props = data.furnish
    inhouse = true
    DoScreenFadeOut(200)
    TriggerServerEvent("p_instance:s:join", "house_"..data.id)
    local int = Ints[data.interior]
    local p = PlayerPedId()

    for k,v in pairs(props) do
        local model = GetHashKey(v.data.m)
        if IsModelValid(model) then
            while not HasModelLoaded(model) do
                Citizen.Wait(1)
                RequestModel(model)
            end

            local obj = CreateObject(model,v.crd.x,v.crd.y,v.crd.z,false,true)
            SetEntityAsMissionEntity(obj, true, true)
            SetEntityCoords(obj, v.crd.x,v.crd.y,v.crd.z)
            SetEntityRotation(obj, v.rot.x,v.rot.y,v.rot.z, 2)
            FreezeEntityPosition(obj, true)
            propsid[obj] = k
        else
            houses[thishouse].furnish[k] = nil
        end
    end

    SetEntityCoords(p, int.pos-vector3(0.0,0.0,1.0))
    SetEntityHeading(p, int.hdg)
    SetGameplayCamRelativeHeading(0)
    
    local largetick = GetGameTimer()
    DoScreenFadeIn(200)
    Citizen.Wait(500)

    -- Variables para controlar el texto UI
    local alreadyEnteredZone = false
    local lastType, lastText, lastButton, lastTitle = nil, nil, nil, nil

    while inhouse do
        p = PlayerPedId()
        local pc = GetEntityCoords(p)
        local _,_,z = table.unpack(pc)

        if z < 1950.0 and playerloaded then
            break
        end

        if IsControlJustPressed(0, 244) then
            if (houses[thishouse].owner and houses[thishouse].owner == pd.identifier) or (mykeys[thishouse] ~= nil) then
                bol = true
                SetNuiFocus(bol, bol)
                SendNUIMessage({
                    target = "open",
                    pck = houses[thishouse].data.pack
                })            
                mini = false
            end
        end

        local near = {ds = 99999.0}
        
        for k,v in pairs(props) do
            if v.data.w ~= nil then
                local pos = vector3(v.crd.x,v.crd.y,v.crd.z)
                local ds = #(pc - pos)
                if ds < near.ds then
                    near = {
                        ds = ds,
                        v = v,
                        k = k,
                        pos = pos
                    }
                end
            end
        end

        -- Mostrar texto UI con am_drawtextui y control de entrada/salida de zona
        if near.v ~= nil and near.ds < 1.5 then
            if not alreadyEnteredZone or lastText ~= "Abrir tu Cajon" then
                alreadyEnteredZone = true
                lastType, lastText, lastButton, lastTitle = "show", "Abrir tu Cajon", "E", "INTERACCIÓN"
                TriggerEvent("am_drawtextui:ShowUI", lastType, lastText, lastButton, lastTitle)
            end

            if IsControlJustPressed(0, 38) then
                local inv = thishouse.."_"..near.k
                ESX.TriggerServerCallback('p_houses:getInventory', function(inventory)
                    if not inventory then
                        ESX.ShowNotification("Inventario vacío o no disponible.")
                        return
                    end

                    if UseCustomInv then
                        invHouse(inv, wbymod[near.v.data.m])
                    else
                        local parsedInv = inventory
                        if type(inventory) == "string" then
                            parsedInv = json.decode(inventory)
                            if not parsedInv then
                                ESX.ShowNotification("Error al cargar inventario.")
                                return
                            end
                        end

                        ESX.UI.Menu.CloseAll()

                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Casa_menu', {
                            title = 'Casa',
                            align = 'bottom-right',
                            elements = {
                                {label = 'Coger items', value = 'getI'},
                                {label = 'Dejar items', value = 'putI'},
                                {label = 'Coger armas', value = 'getW'},
                                {label = 'Dejar armas', value = 'putW'},
                                {label = 'Coger dinero', value = 'getM'},
                                {label = 'Dejar dinero', value = 'putM'}
                            }
                        }, function(data2, menu2)
                            ESX.ShowNotification("Has seleccionado: "..data2.current.label)
                            -- Aquí va la lógica para cada opción si quieres desarrollarla
                        end, function(data2, menu2)
                            menu2.close()
                        end)
                    end
                end, thishouse)
            end
        elseif alreadyEnteredZone and lastText == "Abrir tu Cajon" then
            alreadyEnteredZone = false
            TriggerEvent("am_drawtextui:HideUI")
            lastType, lastText, lastButton, lastTitle = nil, nil, nil, nil
        end

        local thistimer = GetGameTimer()

        if thistimer - largetick > 15000 then
            RemoveDecalsInRange(int.pos,50.0)
            largetick = thistimer
        end

        if #(pc - int.pos) < 2.0 then
            if not alreadyEnteredZone or lastText ~= "Opciones de Salida" then
                alreadyEnteredZone = true
                lastType, lastText, lastButton, lastTitle = "show", "Opciones de Salida", "E", "INTERACCIÓN"
                TriggerEvent("am_drawtextui:ShowUI", lastType, lastText, lastButton, lastTitle)
            end

            if IsControlJustPressed(0, 38) then
                HomeIntDoorMenu()
            end
        elseif alreadyEnteredZone and lastText == "Opciones de Salida" then
            alreadyEnteredZone = false
            TriggerEvent("am_drawtextui:HideUI")
            lastType, lastText, lastButton, lastTitle = nil, nil, nil, nil
        else
            DrawMarker(2, int.pos, 0.0,0.0,0.0, 0.0,0.0,0.0, 0.2, 0.2, -0.12, 255, 255, 255, 100, false, true)
        end

        Citizen.Wait(0)
    end

    DoScreenFadeOut(200)
    Citizen.Wait(200)
    bol = false
    SetNuiFocus(bol, bol)

    if preprop and preprop.ent then
        DeleteEntity(preprop.ent)
        preprop = nil
    end

    TriggerServerEvent("p_instance:s:leave")
    SendNUIMessage({target = "close"})
    TriggerServerEvent("p_houses:s:leave", thishouse)
    SetEntityCoords(p, data.positions.enter)
    SetGameplayCamRelativeHeading(0)

    for v in pairs(propsid) do
        DeleteObject(v)
    end

    RefreshNear()
    DoScreenFadeIn(200)

    thishouse = nil
    props = nil
    inhouse = false
end)

RegisterNetEvent("p_casa:actions")
AddEventHandler("elite_casas:action", function(v, thishouse, near)
    if v == "armario" then
        local inv = ""..thishouse.."_"..near.k
        print(inv)
        print( wbymod[near.v.data.m])
        exports['linden_inventory']:OpenStash({owner = false, id = inv, label = "Casa - "..inv, slots = wbymod[near.v.data.m]})

        Citizen.Wait(200)
    end
end)

AddEventHandler('p_housing:clothes', function()
    if thishouse ~= nil and ((houses[thishouse].owner and houses[thishouse].owner == pd.identifier) or (mykeys[thishouse] ~= nil)) then
        ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
            local elems = {}
        
            for i=1, #dressing, 1 do
                table.insert(elems, {
                    label = dressing[i],
                    value = i
                })
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'conuuntos', {
                title = "Conjuntos",
                align = 'bottom-right',
                elements = elems,
            }, function(data2, menu2)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'opciones', {
                    title = "Administrar",
                    align = 'bottom-right',
                    elements = {
                        {label = "Vestir",value="vest"},
                        {label = "Borrar",value="borr"}
                    },
                }, function(data3, menu3)
                    if data3.current.value == "vest" then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)
    
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerServerEvent('esx_skin:save', skin)
                                end)
                            end, data2.current.value)
                        end)
                        menu3.close()
                    elseif data3.current.value == "borr" then
                        TriggerServerEvent("esx_clotheshop:deleteOutfit",data2.current.label)
                        menu3.close()
                        menu2.close()
                    end                        
                end, function(_,menu3)
                    menu3.close()
                end)
                
            end, function(_,menu2)
                menu2.close()
            end)
        end)
    end
end)

RegisterCommand("props",function()
    if thishouse ~= nil and ((houses[thishouse].owner and houses[thishouse].owner == pd.identifier) or (mykeys[thishouse] ~= nil)) then
        local items = {}
        local mc = GetEntityCoords(PlayerPedId())
        for prop, id in pairs(propsid) do
            local ds = #(mc - GetEntityCoords(prop))
            table.insert( items, {label = "prop."..id, ent = prop, ds = ds})
        end

        table.sort( items, function(a,b)
            return a.ds < b.ds
        end )

        local inmenu = true
        local current = -1

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_propselect', {
            title    = 'Muebles',
            align    = 'bottom-right',
            elements = items
        }, function(data, menu)
            inmenu = false
            selctmoveobj = data.current.ent
            local hsh = GetEntityModel(selctmoveobj)
            local o , _ = GetModelDimensions(hsh)
            thisoffset = vector3(0.0,0.0,-o.z)
            SendNUIMessage({
                target = "toggleselected",
                value = true
            })

            SendNUIMessage({
                target = "refresh",
                coords = GetEntityCoords(selctmoveobj),
                rotation = GetEntityRotation(selctmoveobj, 2)
            })

            selecting = 1

            SendNUIMessage({
                target = "toggle",
                bol = selecting,
            })

        end, function(data, menu)
            menu.close()
            inmenu = false
            ResetEntityAlpha(current)
        end,function(data, menu)
            ResetEntityAlpha(current)
            current = data.current.ent
            SetEntityAlpha(current,150)
        end)

        while inmenu do
            if DoesEntityExist(current) then
                DrawLine(GetEntityCoords(PlayerPedId()),GetEntityCoords(current),255,255,255,255)
            end
            Citizen.Wait(0)
        end

    end
end)

RegisterNetEvent('p_houses:c:forceleave')
AddEventHandler('p_houses:c:forceleave', function()
    inhouse = false
--    print(8)
end)

RegisterNetEvent('p_houses:c:crearpropiedad')
AddEventHandler('p_houses:c:crearpropiedad', function()
    local inmenu = true
    local references = {}
    local datas = {}
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_dyhs', {
        title    = 'Dynasty8',
        align    = 'bottom-right',
        elements = {
            {label = "Seleccionar entrada*",v = "Entrada"},
            {label = "Seleccionar garage",v = "Garage"},
            {label = "Interior*",v = "Interior"},
            {label = "Precio: fuera de venta",v = "prc"},
            {label = "Crear!", v = "crea"}
        }
    }, function(data, menu)
        local c = data.current
        if c.v == "Entrada"  then
            local ps = GetEntityCoords(PlayerPedId())
            references[c.v] = {
                pos = ps,
                text = c.v
            }
            datas[c.v] = ps
            c.label = c.v
            menu.update({v = c.v}, c)
            menu.refresh()
        elseif c.v == "Garage" then
            local elemsmdg = {
                {label = "Entrada",v = "Entrada_Garage"},
                {label = "Salida de autos",v = "Salida_Garage"},
                {label = "Rotacion",v = "rot"},
                {label = "Confirmar",v = "conf"},
            }

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_select_garage', {
                title    = 'Garage',
                align    = 'bottom-right',
                elements = elemsmdg
            }, function(data2, menu2)
                local c2 = data2.current
                if c2.v == "Entrada_Garage" or c2.v == "Salida_Garage" then
                    local ps = GetEntityCoords(PlayerPedId())
                    references[c2.v] = {
                        pos = ps,
                        text = c2.v
                    }
                    datas[c2.v] = ps
                elseif c2.v == "rot" then
                    local r = ESX.Math.Round((GetEntityHeading(PlayerPedId())),2)
                    c2.label = "Rotacion: "..r

                    menu2.update({v = c2.v}, c2)
                    menu2.refresh()
                    datas[c2.v] = r
                elseif c2.v == "conf" then
                    if datas["Entrada_Garage"] and datas["Salida_Garage"] and datas["rot"] then
                        menu2.close()
                    else 
                        ESX.ShowNotification("Te falto seleccionar algo")
                    end
                end
            end, function(data2, menu2)
                for _,v in pairs(elemsmdg) do
                    datas[v.v] = nil
                    references[v.v] = nil
                end
                menu2.close()
            end)
        
        elseif c.v == "Interior" then
            local this = {}
            for k,v in pairs(Ints) do
                table.insert(this,{label = k,val = k})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_slectint', {
                title    = 'Seleccionar interior',
                align    = 'bottom-right',
                elements = this
            }, function(data2, menu2)
                local c2 = data2.current
                datas[c.v] = c2.val
                c.label = c.v..": "..c2.label
                menu2.close()
                menu.update({v = c.v}, c)
                menu.refresh()
            end, function(data2, menu2)
                menu2.close()
            end)

        elseif c.v == "prc" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'priceeeee', {
                title = ("Precio (dejar vacio para eliminar de venta)")
            }, function(data2, menu2)
                local n = tonumber(data2.value)
                if n and n > 0 then
                    c.label = "Precio: $"..n
                    datas[c.v] = n
                else
                    c.label = "Precio: fuera de venta"
                    datas[c.v] = nil
                end
                menu2.close()
                menu.update({v = c.v}, c)
                menu.refresh()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif c.v == "crea" then
            if references["Entrada"] ~= nil and datas["Interior"] ~= nil then
                menu.close()
                TriggerServerEvent("p_houses:s:createhouse", datas)

                inmenu = false
            else
                ESX.ShowNotification('Necesitas seleccionar la entrada y el interior')
            end
        end
    end, function(data, menu)
        menu.close()
        inmenu = false
    end)

    while inmenu do
        for k,v in pairs(references) do
            DrawText3D(v.pos, v.text)
        end
        Citizen.Wait(0)
    end

    references = {}
end)

RegisterNetEvent('p_houses:c:reckeys')
AddEventHandler('p_houses:c:reckeys', function(data)
    mykeys = data
    UpdateBlips()
end)

RegisterNetEvent('p_houses:c:addkey')
AddEventHandler('p_houses:c:addkey', function(house)
    mykeys[house] = true
    UpdateBlips()
end)

RegisterNetEvent('p_houses:c:removekey')
AddEventHandler('p_houses:c:removekey', function(house)
    mykeys[house] = false
    UpdateBlips()
end)

function UpdateBlips()
    for _,v in pairs(blips) do
        if DoesBlipExist(v) then
            RemoveBlip(v)
        end
    end

    for id,d in pairs(houses) do
        if (d.owner and d.owner == pd.identifier) or mykeys[id] then
            local p = d.positions.enter
            blips[id] = AddBlipForCoord(p.x, p.y, p.z)
            SetBlipSprite(blips[id], 357)
            SetBlipAsShortRange(blips[id], true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("Propiedad")
            EndTextCommandSetBlipName(blips[id])
        end
    end
end