function Garage(gid)
    -- PASO 1: Confirmar que el botón funciona
    print("^2[DEBUG] PASO 1: Función Garage activada para casa ID: " .. tostring(gid) .. "^7")

    if not houses or not houses[gid] then
        print("^1[ERROR] No se encuentran datos de la casa en la variable 'houses'.^7")
        return
    end

    if not houses[gid].garage then
        print("^1[ERROR] Esta casa no tiene garaje configurado.^7")
        ESX.ShowNotification("Esta propiedad no tiene garaje.")
        return
    end

    local thisgarage = houses[gid].garage
    -- Convertimos a vector3 por seguridad si no lo es
    local spawnCoords = vector3(thisgarage.enter.x, thisgarage.enter.y, thisgarage.enter.z)
    local heading = thisgarage.hdg or 0.0

    print("^2[DEBUG] PASO 2: Coordenadas obtenidas: " .. tostring(spawnCoords) .. "^7")

    ESX.UI.Menu.CloseAll()

    -- PASO 3: Intentamos abrir el garaje
    -- NOTA: Aquí es donde suele fallar si el nombre está mal
    print("^2[DEBUG] PASO 3: Enviando señal a es_garagev2...^7")
    
    -- Intento A: Evento común de menú
    TriggerEvent('es_garagev2:OpenMenu', gid)
    
    -- Intento B: Evento de abrir garaje específico
    TriggerEvent('es_garagev2:openGarage', gid)

    print("^2[DEBUG] PASO 4: Señales enviadas. Si no se abre, el nombre del evento está mal.^7")
end