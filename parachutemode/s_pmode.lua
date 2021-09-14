--[[
Skrypt został wykonany przez:
    •NotPaladyn (not.paladyn@gmail.com) (NotPaladyn#0477)

Zasób napisany dla użytkowników forum GTAONLINE.PL
]]--

parachutes = {}
local vehID = 560

function changeVehicleVelocity(vehicle)
	if not vehicle then return end
	if (isVehicleOnGround(vehicle) == true) then
		local v1, v2, v3 = getElementVelocity (vehicle)
		setElementVelocity(vehicle, v1, v2, v3 + 0.25)
	end
end
addEvent("changeVehicleVelocity", true)
addEventHandler("changeVehicleVelocity", resourceRoot, changeVehicleVelocity)

function createParachuteOnVehicle(vehicle)
	if vehicle then
		if not isVehicleOnGround(vehicle) then
			if getElementData(vehicle, "veh:jump") == false then
				setElementData(vehicle, "veh:jump", true)
				triggerClientEvent(getRootElement(), "changeVehicleGravity", getRootElement(), vehicle, -0.4)
				parachutes[vehicle] = createObject(3131, 0, 0, 0)
				attachElements(parachutes[vehicle], vehicle)
			else
				triggerClientEvent(getRootElement(), "changeVehicleGravity", getRootElement(), vehicle, -1)
				setElementData(vehicle, "veh:jump", false)
				if isElement(parachutes[vehicle]) then
					destroyElement(parachutes[vehicle])
				end
			end
		end
	end
end
addEvent("createParachuteOnVehicle", true)
addEventHandler("createParachuteOnVehicle", resourceRoot, createParachuteOnVehicle)

setTimer(function()
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementModel(v) == vehID then
			if getElementData(v, "veh:jump") then
				if isVehicleOnGround(v) then
					triggerClientEvent(getRootElement(), "changeVehicleGravity", getRootElement(), v, -1)
					setElementData(v, "veh:jump", false)
					if isElement(parachutes[v]) then
						destroyElement(parachutes[v])
					end
				end
			end
		end
	end
end, 250, 0)

addEventHandler("onVehicleDamage", root, function()
	if getElementModel(source) == vehID then
		if getElementData(source, "veh:jump") == true then
			triggerClientEvent(getRootElement(), "changeVehicleGravity", getRootElement(), source, -1)
			setElementData(source, "veh:jump", false)
			if isElement(parachutes[source]) then
				destroyElement(parachutes[source])
			end
		end
	end
end)