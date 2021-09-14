--[[
Skrypt został wykonany przez:
    •NotPaladyn (not.paladyn@gmail.com) (NotPaladyn#0477)

Zasób napisany dla użytkowników forum GTAONLINE.PL
]]--

local jumpBind = "lshift"
local parachuteBind = "x"

function bindToJump()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		triggerServerEvent("changeVehicleVelocity", resourceRoot, vehicle)
	end
end

function bindToCreateParachute()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		triggerServerEvent("createParachuteOnVehicle", resourceRoot, vehicle)
	end
end

function changeVehicleGravity(vehicle, amount)
	if vehicle then
		setVehicleGravity(vehicle, 0, 0, amount)
	end
end
addEvent("changeVehicleGravity", true)
addEventHandler("changeVehicleGravity", resourceRoot, changeVehicleGravity)

addEventHandler("onClientVehicleEnter", root, function(plr, seat)
	if plr == getLocalPlayer() and seat == 0 then
		if getElementModel(source) == 560 then
			bindKey(jumpBind, "down", bindToJump)
			bindKey(parachuteBind, "down", bindToCreateParachute)
		end
	end
end)
addEventHandler("onClientVehicleExit", root, function(plr, seat)
	if plr == getLocalPlayer() and seat == 0 then
		if getElementModel(source) == 560 then
			unbindKey(jumpBind, "down", bindToJump)
			unbindKey(parachuteBind, "down", bindToCreateParachute)
		end
	end
end)