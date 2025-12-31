
local pi = math.pi
local abs = math.abs
local cos = math.cos
local sin = math.sin
local raycastLength = 500.0

function ScreenToWorld()
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local posX = GetControlNormal(0, 239)
    local posY = GetControlNormal(0, 240)
    local cursor = vector2(posX, posY)
    local cam3DPos, forwardDir = ScreenRelToWorld(camPos, camRot, cursor)
    local direction = camPos + forwardDir * raycastLength
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(cam3DPos, direction, 1, 0, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    return hit, endCoords
end

function ScreenToEnt()
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local posX = GetControlNormal(0, 239)
    local posY = GetControlNormal(0, 240)
    local cursor = vector2(posX, posY)
    local cam3DPos, forwardDir = ScreenRelToWorld(camPos, camRot, cursor)
    local direction = camPos + forwardDir * raycastLength
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(cam3DPos, direction, 1, 0, 0)
    local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)

    local rayHandle2 = StartExpensiveSynchronousShapeTestLosProbe(cam3DPos, direction, 16, 0, 0)
    local _, hit2, _, _, entityHit2 = GetShapeTestResult(rayHandle2)

    if hit2 == 1 then
        return true, entityHit2 
    elseif hit == 1 then
        return true, entityHit 
    else
        return false, -1 
    end
end

function ScreenRelToWorld(camPos, camRot, cursor)
    local camForward = RotationToDirection(camRot)
    local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight = RotationToDirection(rotRight) - RotationToDirection(rotLeft)
    local camUp = RotationToDirection(rotUp) - RotationToDirection(rotDown)
    local rollRad = -(camRot.y * pi / 180.0)
    local camRightRoll = camRight * cos(rollRad) - camUp * sin(rollRad)
    local camUpRoll = camRight * sin(rollRad) + camUp * cos(rollRad)
    local point3DZero = camPos + camForward * 1.0
    local point3D = point3DZero + camRightRoll + camUpRoll
    local point2D = World3DToScreen2D(point3D)
    local point2DZero = World3DToScreen2D(point3DZero)
    local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
end

function RotationToDirection(rotation)
    local x = rotation.x * pi / 180.0
    --local y = rotation.y * pi / 180.0
    local z = rotation.z * pi / 180.0
    local num = abs(cos(x))
    return vector3((-sin(z) * num), (cos(z) * num), sin(x))
end
 
function World3DToScreen2D(pos)
    local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
    return vector2(sX, sY)
end

function help3d(msg,pos)
    local x,y,z = table.unpack(pos)
    local onScreen  = World3dToScreen2d(x, y, z)
    if onScreen then
        SetFloatingHelpTextWorldPosition(1, pos)   
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)  
        BeginTextCommandDisplayHelp('STRING')   
        AddTextComponentSubstringPlayerName(msg)    
        EndTextCommandDisplayHelp(2, false, false, -1)   
    end 
end 

function DrawText3D(pos, text)
	SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(1, 0, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(pos, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Round = function(number)
    local this = number * 100

    this = (math.floor(this))

    return this / 100
end

gid = function(cant)
	
	local str = ""
	for i = 1,cant do
		local actu = math.random(1,35)
		if actu > 26 then
			str = str..actu-26
		else
			str = str..string.char(64+actu)
		end
	end

	return str
end

function pop()
    SendNUIMessage({
        target = "pop"
    })
end

local tmid = 0
local quee = 0
function TOut(msec,cb)
    Citizen.CreateThread(function()
        tmid = tmid + 1
        local thisid = tmid 
        Citizen.Wait(msec)
        if tmid == thisid then
            quee = 0
            cb()
        else
            quee = quee + 1
            if quee > 10 then
                quee = 0
                cb()
            end
        end
    end)
end


function tp(tbl, indent)
	indent = indent or 0
	for k, v in pairs(tbl) do
		local tblType = type(v)
		formatting = string.rep("  ", indent) .. k .. ": "
		if tblType == "table" then
			print(formatting)
			tp(v, indent + 1)
		elseif tblType == 'boolean' then
			print(formatting .. tostring(v))
		elseif tblType == "function" then
			print(formatting .. tostring(v))
		else
			print(formatting .. v)
		end
	end
end

nearhouses = {}
houses = {}

function RefreshNear()
    nearhouses = {}
    local p = PlayerPedId()
    local ps = GetEntityCoords(p)
    for k,v in pairs(houses) do
        local ds = #(v.positions.enter - ps)
        if ds < 50.0 then
            nearhouses[k] = v
        end
    end
end