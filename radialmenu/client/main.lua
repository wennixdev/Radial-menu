isDead = false

AddEventHandler('esx:onPlayerSpawn', function()

	isDead = false

end)

AddEventHandler('esx:onPlayerDeath', function(data)

	isDead = true

end)

local inRadialMenu = false

local ox = exports.ox_inventory

local PlayerData, CurrentActionData, handcuffTimer, dragStatus = {}, {}, {}, {}

local IsHandcuffed = false

local isBusy = false 

dragStatus.isDragged = false

RegisterCommand('radial', function()
    openRadial(true)
    SetCursorLocation(0.5, 0.5)
end)

RegisterCommand('fixradial', function()
    closeRadial(false)
end)

RegisterKeyMapping('radial', '<font face = "Fire Sans">Otevřít interakční menu', 'keyboard', 'F5')
function setupSubItems()

    PlayerData = ESX.GetPlayerData()
        
    if Config.JobInteractions[PlayerData.job.name] ~= nil and next(Config.JobInteractions[PlayerData.job.name]) ~= nil then
        Config.MenuItems[4].items = Config.JobInteractions[PlayerData.job.name]
    else 
        Config.MenuItems[4].items = {}
    end
        
    local Vehicle = GetVehiclePedIsIn(PlayerPedId())

    if Vehicle ~= nil or Vehicle ~= 0 then
        local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(Vehicle))

        if AmountOfSeats == 2 then
            Config.MenuItems[3].items[3].items = {
                [1] = {
                    id    = -1,
                    title = 'Řidič',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 0,
                    title = 'Spolujezdec',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 3 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Řidič',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Spolujezdec',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Ostatní',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 4 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Řidič',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Spolujezdec',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Zadní levé',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 2,
                    title = 'Zadní pravé',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        end
    end
end

RegisterNetEvent('radialmenu:motor')
AddEventHandler('radialmenu:motor', function()
    local car = nil
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped, true)

	if IsPedInAnyVehicle(ped,  false) then
		car = GetVehiclePedIsIn(ped, false)
	end

    if GetPedInVehicleSeat(car, -1) == ped then
        if DoesEntityExist(car) then
            if GetIsVehicleEngineRunning(car) then
                SetVehicleEngineOn(car, false, true, true)
                lib.notify({
                    description = 'Motor byl vypnut!'
                })
            else
                SetVehicleEngineOn(car, true, true, true)
                lib.notify({
                    description = 'Motor byl zapnut!',
                    type = 'success'
                })
            end
        else
            lib.notify({
                description = 'Žádné auto poblíž!',
                type = 'error'
            })
        end
    else
        lib.notify({
            description = 'Nejsi řidič vozidla!',
            type = 'error'
        })
    end 
end)


RegisterNetEvent('radialmenu:search')
AddEventHandler('radialmenu:search', function()

    exports.ox_inventory:openNearbyInventory()

end)

local function CanOpenTarget(ped)

	return IsPedFatallyInjured(ped)

	or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)

	or IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3)

	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3)

	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)

	or IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3)

end


RegisterNetEvent('radialmenu:unhandcuff')
AddEventHandler('radialmenu:unhandcuff', function()
   -- if not isDead then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(PlayerPedId())
        local target_id = GetPlayerServerId(target)
        if distance <= 2.0 then
            
            TriggerServerEvent('esx_dobrcthief:requestrelease', target_id, playerheading, playerCoords, playerlocation)
        else
            exports.ox_inventory:notify({type = 'error', text = 'Jsi moc daleko od hráče!', duration = 5000})
        end
    else
        exports.ox_inventory:notify({type = 'error', text = 'Nikdo není blízko tvé pozice!', duration = 5000})
   -- end
end
end)


RegisterNetEvent('radialmenu:handcuff')
AddEventHandler('radialmenu:handcuff', function()
  --  if not isDead then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(PlayerPedId())
        local target_id = GetPlayerServerId(target)
        
        if distance <= 2.0 and CanOpenTarget(closestPlayer) then
            TriggerServerEvent('esx_dobrcthief:requestarrest', target_id, playerheading, playerCoords, playerlocation)
        else
            exports.ox_inventory:notify({type = 'error', text = 'Jsi moc daleko od hráče!', duration = 5000})
        end
    else
        exports.ox_inventory:notify({type = 'error', text = 'Nikdo není blízko tvé pozice!', duration = 5000})
   -- end
end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local dogModels = {
	"a_c_shepherd", "a_c_rottweiler", "a_c_husky",
}

local Player = PlayerPedId(), DecorGetInt(PlayerPedId())
local ped = PlayerPedId()

local AimAnim = GetResourceKvpString("AimAnim")
local HolsterAnim = GetResourceKvpString("HolsterAnim")
function InteractionMenu()
  local elements = {}
  
  if isDog() then
		table.insert(elements, {label = 'Ped Animace', value = 'dog_animation'})
	end
end

RegisterNetEvent('esx_dobrcthief:handcuff')
AddEventHandler('esx_dobrcthief:handcuff', function()
  --  isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
       
	end
end)

RegisterNetEvent('esx_dobrcthief:unrestrain')
AddEventHandler('esx_dobrcthief:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
    else
        exports.ox_inventory:notify({type = 'error', text = 'Osoba není spoutána!', duration = 5000})
	end
end)

RegisterNetEvent('esx_dobrcthief:drag')
AddEventHandler('esx_dobrcthief:drag', function(copId)

	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)



RegisterNetEvent('radialmenu:putout')
AddEventHandler('radialmenu:putout', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('esx_dobrcthief:OutVehicle', GetPlayerServerId(closestPlayer))
        TriggerEvent('r_grab:ExitCar')
    end
end)

RegisterNetEvent('esx_dobrcthief:putInVehicle')
AddEventHandler('esx_dobrcthief:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if isHandcuffed then

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end
end)
RegisterNetEvent('esx_dobrcthief:hel')
AddEventHandler('esx_dobrcthief:hel', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 1.0 then
        ESX.TriggerServerCallback("rx-ems:getItemAmount", function(quantity)
                if quantity > 0 then
                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local health = GetEntityHealth(closestPlayerPed)
                    if health > 0 then
                        local playerPed = PlayerPedId()
                        IsBusy = true
                        TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
                        Citizen.Wait(5000)
                        ClearPedTasks(playerPed)
                        TriggerServerEvent("rx-ems:removeItem", "bandage")
                        TriggerServerEvent("rx-ems:heal", GetPlayerServerId(closestPlayer), "small")
                        IsBusy = false
                    end
                else
                    exports.ox_inventory:notify({type = "error", text = "Nemáš bandage!", duration = 5000})
                end
            end, "bandage")
    end
    
end)

RegisterNetEvent('esx_dobrcthief:rev')
AddEventHandler('esx_dobrcthief:rev', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 1.0 then
        ESX.TriggerServerCallback("rx-ems:getItemAmount", function(quantity)
                local target, distance = ESX.Game.GetClosestPlayer()
    
                if quantity > 0 then
                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(GetPlayerPed(-1))
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local target_id = GetPlayerServerId(target)
                    local searchPlayerPed = GetPlayerPed(target)
                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local health = GetEntityHealth(closestPlayerPed)
    
                    if health > 0 or IsEntityDead(searchPlayerPed) then
                        TriggerServerEvent("rx-ems:animace_revive", target_id, playerheading, playerCoords, playerlocation)
                        Citizen.Wait(60000)
                        TriggerServerEvent("rx-ems:removeItem", "medikit")
                        TriggerServerEvent("rx-ems:revive", GetPlayerServerId(closestPlayer))
                    else
                    end
                else
                    exports.ox_inventory:notify({type = "error", text = "Nemáš medkit!", duration = 5000})
                end
    
                IsBusy = false
            end, "medikit")
    end  
end)
RegisterNetEvent('esx_dobrcthief:OutVehicle')
AddEventHandler('esx_dobrcthief:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end


RegisterNetEvent('esx_dobrcthief:getarrested')
AddEventHandler('esx_dobrcthief:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	--cuffed = true
	isHandcuffed = true
	
	TriggerEvent("esx_dobrcthief:handcuff")
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('radialmenu:handcuffzipties')
AddEventHandler('radialmenu:handcuffzipties', function()
 --   if not isDead then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(PlayerPedId())
        local target_id = GetPlayerServerId(target)
        
        if distance <= 2.0 and CanOpenTarget(closestPlayer) then
            TriggerServerEvent('esx_dobrcthief:requestarrestzip', target_id, playerheading, playerCoords, playerlocation)
        else
            exports.ox_inventory:notify({type = 'error', text = 'Jsi moc daleko od hráče!', duration = 5000})
        end
    else
        exports.ox_inventory:notify({type = 'error', text = 'Nikdo není blízko tvé pozice!', duration = 5000})
  --  end
end
end)


RegisterNetEvent('esx_dobrcthief:doarrestedd')
AddEventHandler('esx_dobrcthief:doarrestedd', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.5, 'ziptie', 1.0)
	ExecuteCommand('me poutá')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent('esx_dobrcthief:doarrested')
AddEventHandler('esx_dobrcthief:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.5, 'pouta', 1.0)
	ExecuteCommand('me poutá')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent('esx_dobrcthief:douncuffing')
AddEventHandler('esx_dobrcthief:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.5, 'odpoutat', 1.0)
	ExecuteCommand('me odpoutává')
	Citizen.Wait(5500)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('esx_dobrcthief:getuncuffed')
AddEventHandler('esx_dobrcthief:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	
	loadanimdict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	isHandcuffed = false
	TriggerEvent("esx_dobrcthief:handcuff")
	
	ClearPedTasks(PlayerPedId())
end)


-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			--DisableControlAction(0, 1, true) -- Disable pan
		--	DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
		--	DisableControlAction(0, 32, true) -- W
		--	DisableControlAction(0, 34, true) -- A
		--	DisableControlAction(0, 31, true) -- S
		--	DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			--DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			--DisableControlAction(0, 0, true) -- Disable changing view
			--DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function openRadial(bool)    
    setupSubItems()

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        radial = bool,
        items = Config.MenuItems
    })
    inRadialMenu = bool
end

function closeRadial(bool)    
    SetNuiFocus(false, false)
    inRadialMenu = bool
end

function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

RegisterNUICallback('closeRadial', function()
    closeRadial(false)
end)

RegisterNUICallback('selectItem', function(data)
    local itemData = data.itemData

    if itemData.type == 'client' then
        TriggerEvent(itemData.event, itemData)
    elseif itemData.type == 'server' then
        TriggerServerEvent(itemData.event, itemData)
    end
end)

RegisterNetEvent('radialmenu:client:noPlayers')
AddEventHandler('radialmenu:client:noPlayers', function(data)
    --QBCore.Functions.Notify('There arrent any people close', 'error', 2500)
 	ESX.ShowNotification('There arrent any people close')
end)

RegisterNetEvent('radialmenu:client:giveidkaart')
AddEventHandler('radialmenu:client:giveidkaart', function(data)
    -- ??
end)

RegisterNetEvent('FlipVehicle')
AddEventHandler('FlipVehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
            exports.ox_inventory:Progress({
                duration = 5000,
                label = 'Převracíš vozidlo',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = false,
                    car = true,
                    combat = true,
                    mouse = false
                },
                anim = {
                    dict = "random@mugging4",
                    clip = "struggle_loop_b_thief",
                    flags = 49,
                },

            }, function(cancel)
                if not cancel then
                    local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
                else
                    ESX.ShowNotification('Přerušeno')
                end
            end)
    
    else
        ESX.ShowNotification('Nic poblíž')
    end
end)


function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)    
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end
RegisterNetEvent('radialmenu:client:openDoor')
AddEventHandler('radialmenu:client:openDoor', function(data)
    local string = data.id
    local replace = string:gsub("door", "")
    local door = tonumber(replace)
    local ped = PlayerPedId()
    local closestVehicle = nil

    if IsPedInAnyVehicle(ped, false) then
        closestVehicle = GetVehiclePedIsIn(ped)
    else
        closestVehicle = getNearestVeh()
    end

    if closestVehicle ~= 0 then
        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = GetVehicleNumberPlateText(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        --QBCore.Functions.Notify('There is no vehicle in sight...', 'error', 2500)
     	ESX.ShowNotification('There is no vehicle in sight...')
    end
end)
RegisterNetEvent('radialmenu:client:skilmenu')
AddEventHandler('radialmenu:client:skilmenu', function()
    exports["gamz-skillsystem"]:SkillMenu()
end)

RegisterNetEvent('radialmenu:client:setExtra')
AddEventHandler('radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local enginehealth = 1000.0
    local bodydamage = 1000.0

    if veh ~= nil then
        local plate = GetVehicleNumberPlateText(closestVehicle)
    
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            if DoesExtraExist(veh, extra) then 
                if IsVehicleExtraTurnedOn(veh, extra) then
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                --    SetVehicleAutoRepairDisabled(veh, true)
                    SetVehicleExtra(veh, extra, 1)
                --    SetVehicleAutoRepairDisabled(veh, true)
                    SetVehicleEngineHealth(veh, enginehealth)
                    SetVehicleBodyHealth(veh, bodydamage)
                    lib.notify({
                        description = 'Extra: '..extra..' byly deaktivovány!',
                        type = 'error'
                    })
                    --ox:notify({type = 'error', text = 'Extra: '..extra..' byly deaktivovány!', duration = 2500, position = 'bottom-center'})
                else
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                --    SetVehicleAutoRepairDisabled(veh, true)
                    SetVehicleExtra(veh, extra, 0)
                --    SetVehicleAutoRepairDisabled(veh, true)
                    SetVehicleEngineHealth(veh, enginehealth)
                    SetVehicleBodyHealth(veh, bodydamage)
                    lib.notify({
                        description = 'Extra: '..extra..' byly aktivována!',
                        type = 'success'
                    })
                    --ox:notify({type = 'success', text = 'Extra: '..extra..' byly aktivována!', duration = 2500, position = 'bottom-center'})
                end    
            else
                lib.notify({
                    description = 'Extra: '..extra..' nejsou dostupná pro toto vozidlo!',
                    type = 'error'
                })
                --ox:notify({type = 'error', text = 'Extra: '..extra..' nejsou dostupná pro toto vozidlo!', duration = 2500, position = 'bottom-center'})
            end
        else
            lib.notify({
                description = 'Nejsi řidič vozu!',
                type = 'error'
            })
            --ox:notify({type = 'error', text = 'Nejsi řidič vozu!', duration = 2500, position = 'bottom-center'})
        end
    end
end)

RegisterNetEvent('radialmenu:trunk:client:Door')
AddEventHandler('radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if veh ~= 0 then
        local pl = GetVehicleNumberPlateText(veh)

        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

local Seats = {
    ["-1"] = "Driver's Seat",
    ["0"] = "Passenger's Seat",
    ["1"] = "Rear Left Seat",
    ["2"] = "Rear Right Seat",
}

RegisterNetEvent('radialmenu:client:ChangeSeat')
AddEventHandler('radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
  --  local HasHarnass = exports['qb-smallresources']:HasHarness()
  --  if not HasHarnass then
        local kmh = (speed * 3.6);  

        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                --QBCore.Functions.Notify('Your now on the  '..data.title..'!')
             	ESX.ShowNotification('Your now on the  '..data.title..'!')
            else
                --QBCore.Functions.Notify('The vehicle goes to fast..')
             	ESX.ShowNotification('The vehicle goes to fast..')
            end
        else
            --QBCore.Functions.Notify('This seat is occupied..')
         	ESX.ShowNotification('This seat is occupied..')
        end
   -- else
        --QBCore.Functions.Notify('You have a race harnas on u cant switch..', 'error')
     --	ESX.ShowNotification('You have a race harnas on u cant switch..')
 --   end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function loadAnimDictgun(dict)
	--print("1")
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(50)
	end
end



Citizen.CreateThread(function()

    SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_01_STAGE', true)
    SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM', true)
    SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM', true)
end)




local Player = PlayerPedId(), DecorGetInt(PlayerPedId())
local ped = PlayerPedId()

local AimAnim = GetResourceKvpString("AimAnim")
local HolsterAnim = GetResourceKvpString("HolsterAnim")

CreateThread(function()
    while true do
		local Player = PlayerPedId(), DecorGetInt(PlayerPedId())
local ped = PlayerPedId()
        if AimAnim == "GangsterAS" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
					while (not HasAnimDictLoaded("combat@aim_variations@1h@gang")) do
						RequestAnimDict("combat@aim_variations@1h@gang")
						Citizen.Wait(50)
					end
                    loadAnimDictgun("combat@aim_variations@1h@gang")
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        elseif AimAnim == "HillbillyAS" then
            if CheckWeapon2(ped) then
                inVeh = IsPedInVehicle(PlayerPedId(-1), GetVehiclePedIsIn(PlayerPedId(-1), false), false)
                local _, hash = GetCurrentPedWeapon(Player, 1)
                if not inVeh then
                    loadAnimDictgun("combat@aim_variations@1h@hillbilly")
					while (not HasAnimDictLoaded("combat@aim_variations@1h@hillbilly")) do
						RequestAnimDict("combat@aim_variations@1h@hillbilly")
						Citizen.Wait(50)
					end
                    if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                        if not IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                            TaskPlayAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                            SetEnableHandcuffs(Player, true)
                        end
                    elseif IsEntityPlayingAnim(Player, "combat@aim_variations@1h@hillbilly", "aim_variation_a", 3) then
                        ClearPedTasks(Player)
                        SetEnableHandcuffs(Player, false)
                    end
                    Citizen.Wait(50)
                end
                Citizen.Wait(50)
            end
        end
        Citizen.Wait(80)
    end
end)

function CheckWeapon(ped)
	local ped = PlayerPedId()
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.DrawingWeapons do
				if GetHashKey(config.DrawingWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function CheckWeapon2(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #config.AimWeapons do
				if GetHashKey(config.AimWeapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDictgun(dict)
	--print("1")
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(50)
	end
end
-- Block thread
CreateThread(function()
    while true do
        if blocked then
            DisableControlAction(1, 25, true ) -- aim
            DisableControlAction(1, 140, true) -- mele attack
            DisableControlAction(1, 141, true) -- mele attack heavy
            DisableControlAction(1, 142, true) -- mele attack alt
            DisableControlAction(1, 23, true) -- enter vehicle
            DisablePlayerFiring(ped, true) -- Disable weapon firing
        end
        Citizen.Wait(100)
    end
end)
config = {
   

    -- Weapons for aim animations.
    AimWeapons = {
        "WEAPON_PISTOL",
        "WEAPON_COMBATPISTOL",
        "WEAPON_APPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_PISTOL_MK2",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_FLAREGUN",
        "WEAPON_STUNGUN",
        "WEAPON_REVOLVER",
    },

    -- Weapons for drawing animations.
    DrawingWeapons = {
        "WEAPON_PISTOL",
        "WEAPON_COMBATPISTOL",
        "WEAPON_APPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_PISTOL_MK2",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_FLAREGUN",
        "WEAPON_STUNGUN",
        "WEAPON_REVOLVER",
    },
}
function megafon()

	
	local elements = {
		{label = '1 - beta', value = '1'},
		{label = '2 - beta', value = '2'},
		{label = '3 - beta', value = '3'},

	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meg_animation_menu', {
		title    = 'Megafon',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value


		if action == '1' then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle", 0.6)
			end
		elseif action == '2' then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle-2", 0.6)
			end
		elseif action == '3' then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_the_f_car", 0.6)
			end
		end

	end, function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('radialmenu:mireni1')
AddEventHandler('radialmenu:mireni1', function()
    --print("1")
    SetResourceKvp("AimAnim", "nil")
    AimAnim = GetResourceKvpString("AimAnim")
end)
RegisterNetEvent('radialmenu:mireni2')
AddEventHandler('radialmenu:mireni2', function()
    --print("2")
    SetResourceKvp("AimAnim", "GangsterAS")
    AimAnim = GetResourceKvpString("AimAnim")
end)

RegisterNetEvent('radialmenu:mireni3')
AddEventHandler('radialmenu:mireni3', function()
    --print("3")
    SetResourceKvp("AimAnim", "HillbillyAS")
    AimAnim = GetResourceKvpString("AimAnim")
end)
----------------------------------------------------------------------------
-------------------------------- OPEN PED ANIMATION ------------------------
----------------------------------------------------------------------------




function cancelEmote()
	ClearPedTasks(GetPlayerPed(-1))
	emotePlaying = false
end

function playAnimation(dictionary, animation)
	if emotePlaying then
		cancelEmote()
	end
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Wait(1)
	end
	TaskPlayAnim(GetPlayerPed(-1), dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	emotePlaying = true
end


exports('AddOption', function(id, data)
    Config.MenuItems[id] = data
end)

exports('RemoveOption', function(id)
    Config.MenuItems[id] = nil
end)



function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end

RegisterNetEvent('radialmenu:impound')
AddEventHandler('radialmenu:impound', function()
    local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
            prop_name = 'prop_pencil_01'
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 58866)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, -0.02, 0.001, -120.0, 0.0, 0.0, true, true, false, true, 1, true)
            exports.ox_inventory:Progress({
                duration = 7000,
                label = 'Zapisuješ si informace',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = false,
                    car = true,
                    combat = true,
                    mouse = false
                },
                anim = {
                    dict = 'missheistdockssetup1clipboard@base',
                    clip = 'base',
                    flags = 49,
                },
                prop = {
                    model = 'prop_notepad_01',
                    pos = { x = 0.1, y = 0.02, z = 0.05},
                    rot = { x = 10.0, y = 0.0, z = 0.0},
                    bone = 18905
                },
            }, function(cancel)
                if not cancel then
                    ESX.ShowNotification('Vozidlo odtaženo')
                    ESX.Game.DeleteVehicle(vehicle)
                else
                    ESX.ShowNotification('Přestal si')
                end
            end)
          Wait(7000)
          DeleteObject(prop)
			
		else
			ESX.ShowNotification('Musíš sedět jako řidič')
		end
	else
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        local targetVehicle = getVehicleInDirection(coordA, coordB)
           
		if DoesEntityExist(targetVehicle) then
            prop_name = 'prop_pencil_01'
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 58866)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, -0.02, 0.001, -120.0, 0.0, 0.0, true, true, false, true, 1, true)
            exports.ox_inventory:Progress({
                duration = 7000,
                label = 'Zapisuješ si informace',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = false,
                    car = true,
                    combat = true,
                    mouse = false
                },
                anim = {
                    dict = 'missheistdockssetup1clipboard@base',
                    clip = 'base',
                    flags = 49,
                },
                prop = {
                    model = 'prop_notepad_01',
                    pos = { x = 0.1, y = 0.02, z = 0.05},
                    rot = { x = 10.0, y = 0.0, z = 0.0},
                    bone = 18905
                },
            }, function(cancel)
                if not cancel then
                    ESX.ShowNotification('Vozidlo odtaženo')
                    ESX.Game.DeleteVehicle(targetVehicle)
                else
                    ESX.ShowNotification('Přestal si')
                end
            end)
          Wait(7000)
          DeleteObject(prop)
		else
         	ESX.ShowNotification('Nic poblíz')
		end
	end		
end)

RegisterNetEvent('radialmenu:odemcit')
AddEventHandler('radialmenu:odemcit', function()
    local playerPed = PlayerPedId()
	local vehicle = ESX.Game.GetVehicleInDirection()
	local coords = GetEntityCoords(playerPed)
    if isBusy then return end

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification('Uvnitř vozidla nelze vypáčit dveře.. bruh')
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
		CreateThread(function()
            exports.ox_inventory:Progress({
                duration = 50000,
                label = 'Otevíráš vozidlo',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    move = true,
                    car = true,
                    combat = true,
                    mouse = false
                },
            }, function(cancel)
                if not cancel then
                --    print("You drank some water - that'll quench ya!")
                else
                --    ESX.ShowNotification('STOPED')
                end
            end)
			Wait(50000)

			SetVehicleDoorsLocked(vehicle, 1)
			SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification('Vozdilo vypáčeno')
			isBusy = false
		end)
	else
		ESX.ShowNotification('Žádné vozidlo poblíž.. .')
	end
end)

RegisterNetEvent('radialmenu:umyti')
AddEventHandler('radialmenu:umyti', function()
    local playerPed = PlayerPedId()
    local coordA = GetEntityCoords(playerPed, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 100.0, 0.0)
    local vehicle = getVehicleInDirection(coordA, coordB)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification('inside_vehicle')
		return
	end
      
	if DoesEntityExist(vehicle) then
	    isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)

		Citizen.CreateThread(function()
			Citizen.Wait(10000)
			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasks(playerPed)
			ESX.ShowNotification('vehicle_cleaned')
			isBusy = false
		end)
	else
	    ESX.ShowNotification('no_vehicle_nearby')
	end
end)

    RegisterNetEvent('radialmenu:repair')
    AddEventHandler('radialmenu:repair', function()
        local playerPed = PlayerPedId()
        local coordA = GetEntityCoords(playerPed, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 100.0, 0.0)
        local vehicle = getVehicleInDirection(coordA, coordB)
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        --	exports['mythic_notify']:DoHudText('inform', _U('not_in_veh'))
                ESX.ShowNotification('Jsi ve vozidle')
            return
        end
    if DoesEntityExist(vehicle) then
        if not isBussy then
            isBussy = true
            --Skillbar = exports['rx_skillbar']:GetSkillbarObject()

           -- Skillbar.Start({
            --    duration = math.random(2000, 2000),
            --    pos = math.random(20, 80),
               -- width = math.random(18, 18),
          --  }, function()
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                TriggerEvent('pogressBar:drawBar', 15000, 'Opravuješ vozidlo')
                Citizen.Wait(15000)
                SetVehicleFixed(vehicle)
                SetVehicleDeformationFixed(vehicle)
                SetVehicleUndriveable(vehicle, false)
                SetVehicleEngineOn(vehicle, true, true)
                ClearPedTasks(playerPed)
                ESX.ShowNotification('Vozidlo opraveno')
                isBussy = false
            ClearPedTasks(playerPed)
         --   end, function()
               -- ESX.ShowNotification('Nepodařilo, zkus to znova')
                --exports['mythic_notify']:DoHudText('inform','Nepodařilo, zkus to znova')
                isBussy = false
              --  end)

        
    end
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        --exports['mythic_notify']:DoHudText('inform', _U('not_in_veh'))
            ESX.ShowNotification('not_in_veh')
        
    end
end
end)

----------------------------------------------------------------------------
-------------------------------- OPEN PED ANIMATION ------------------------
----------------------------------------------------------------------------

RegisterNetEvent('radialmenu:dogs1')
AddEventHandler('radialmenu:dogs1', function()
    --print("3")
    playAnimation("creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel")
end)

RegisterNetEvent('radialmenu:dogs2')
AddEventHandler('radialmenu:dogs2', function()
    --print("3")
    playAnimation("creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a")
end)

RegisterNetEvent('radialmenu:dogs3')
AddEventHandler('radialmenu:dogs3', function()
    --print("3")
    playAnimation("creatures@rottweiler@amb@world_dog_sitting@exit", "zrusit")
end)

RegisterNetEvent('radialmenu:dogs4')
AddEventHandler('radialmenu:dogs4', function()
    --print("3")
    playAnimation("creatures@rottweiler@amb@world_dog_sitting@base", "base")
end)

RegisterNetEvent('radialmenu:dogs5')
AddEventHandler('radialmenu:dogs5', function()
    --print("3")
    playAnimation("creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_a")
end)

RegisterNetEvent('radialmenu:dogs6')
AddEventHandler('radialmenu:dogs6', function()
    --print("3")
    playAnimation("creatures@rottweiler@indication@", "indicate_high")
end)

RegisterNetEvent('radialmenu:dogs7')
AddEventHandler('radialmenu:dogs7', function()
    --print("3")
    playAnimation("creatures@rottweiler@melee@", "dog_takedown_from_back")
end)

RegisterNetEvent('radialmenu:dogs8')
AddEventHandler('radialmenu:dogs8', function()
    --print("3")
    playAnimation("creatures@rottweiler@swim@", "swim")
end)

function OpenPedAnimationMenu()

	
	local elements = {
		{label = 'Lehnout', value = 'ped_laydown'},
		{label = 'Štěkot', value = 'ped_bark'},
		{label = 'Sednout', value = 'ped_sit'},
		{label = 'Podrbat se', value = 'ped_itch'},
		{label = 'Skákat', value = 'ped_attention'},
		{label = 'Zaútočit', value = 'ped_attack'},
		{label = 'Plavat', value = 'ped_swim'},
		{label = 'Zrusit', value = 'ped_exit'},
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_animation_menu', {
		title    = 'Ped Animace',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value


		if action == 'ped_laydown' then
			playAnimation("creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel")  --1
		elseif action == 'ped_bark' then
			playAnimation("creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a") --2
		elseif action == 'ped_sit' then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@base", "base") --4
		elseif action == 'ped_itch' then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_a") --5
		elseif action == 'ped_attention' then
			playAnimation("creatures@rottweiler@indication@", "indicate_high") --6
		elseif action == 'ped_attack' then
			playAnimation("creatures@rottweiler@melee@", "dog_takedown_from_back") --7
		elseif action == 'ped_swim' then
			playAnimation("creatures@rottweiler@swim@", "swim") --8
		elseif action == 'ped_exit' then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@exit", "zrusit") --3
		end

	end, function(data, menu)
		menu.close()
	end)
end


function isDog()
	local playerModel = GetEntityModel(PlayerPedId())
	for i=1, #dogModels, 1 do
		if GetHashKey(dogModels[i]) == playerModel then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerModel = GetEntityModel(PlayerPedId())
		for i=1, #dogModels, 1 do
			if GetHashKey(dogModels[i]) == playerModel then
				RestorePlayerStamina(PlayerId(), GetPlayerSprintStaminaRemaining(PlayerId()))
			end
		end
	end
end)

function cancelEmote()
	ClearPedTasks(PlayerPedId())
	emotePlaying = false
end

function playAnimation(dictionary, animation)
	if emotePlaying then
		cancelEmote()
	end
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	emotePlaying = true
end



local VehiclesWithNeons = {}

local function HasNeon(vehicle)
    if VehiclesWithNeons[vehicle] ~= nil then
        return true
    end

    if IsVehicleNeonLightEnabled(vehicle) then
        VehiclesWithNeons[vehicle] = true
        return true
    end

end

local function LightLogic()
	local playerPed = PlayerPedId()
    	local vehicle = GetVehiclePedIsIn(playerPed, false)

	if not vehicle or not IsPedInAnyVehicle(playerPed, false) or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end -- ignore if not in car or driver seat
	
	local hasNeons = HasNeon(vehicle)

	if not hasNeons then return end
    
    	local neonsOn = (VehiclesWithNeons[vehicle] ~= nil and VehiclesWithNeons[vehicle] or false)

	SetVehicleNeonLightEnabled(vehicle, 0, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 1, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 2, not neonsOn)
	SetVehicleNeonLightEnabled(vehicle, 3, not neonsOn)
    	VehiclesWithNeons[vehicle] = not neonsOn
end


RegisterNetEvent('radialmenu:neony')
AddEventHandler('radialmenu:neony', function()
	if antiSpam then return end
		
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if not vehicle or not IsPedInAnyVehicle(playerPed, false) or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end

	LightLogic()
	antiSpam = true

	Wait(1250)
	antiSpam = false
end)


local function CheckVehicles()
    for k,v in pairs(VehiclesWithNeons) do
        local valid = DoesEntityExist(k)

        if (not valid) then
            VehiclesWithNeons[k] = nil
            return
        end
    end

    Wait(300000)
    CheckVehicles()
end


RegisterNetEvent('radialmenu:radio')
AddEventHandler('radialmenu:radio', function()
    ExecuteCommand('radiocar')
end)
