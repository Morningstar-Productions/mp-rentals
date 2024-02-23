local Utils = {}
local isServer = IsDuplicityVersion()

---Trim unwanted characters off the string
---@param str string
---@return string?
---@return number? count
function string.trim(str) -- luacheck: ignore
    if not str then return nil end
    return string.gsub(str, '^%s*(.-)%s*$', '%1')
end

---@param text string
---@param coords vector3
---@param icon number
---@param scale number
---@param color number
---@return number
function Utils.createBlips(text, coords, icon, scale, color)
    local blipID = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blipID, icon)
    SetBlipScale(blipID, scale)
    SetBlipColour(blipID, color)
    SetBlipAsShortRange(blipID, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blipID)
    return blipID
end

function Utils.GiveKeys(plate)
    if GetResourceState('qb-vehiclekeys'):match('started') then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    else
        -- Add Your Own Keys Here (Will add support for server keys soon)
    end
end

---Get the coords including the heading from an entity
---@param entity number
---@return vector4
function Utils.GetCoordsFromEntity(entity) -- luacheck: ignore
    local coords = GetEntityCoords(entity)
    return vec4(coords.x, coords.y, coords.z, GetEntityHeading(entity))
end

---@param vehicle integer
---@return string?
function Utils.GetPlate(vehicle)
    if not vehicle or vehicle == 0 then return end
    return string.trim(GetVehicleNumberPlateText(vehicle))
end

if isServer then
    -- Borrowed from qbx_core
    ---@param source integer
    ---@param model string | integer
    ---@param coords? vector4 defaults to player's position
    ---@param warp? boolean
    ---@return integer? netId
    function Utils.SpawnVehicle(source, model, coords, warp)
        model = type(model) == 'string' and joaat(model) or model

        if not CreateVehicleServerSetter then
            error('^1CreateVehicleServerSetter is not available on your artifact, please use artifact 5904 or above to be able to use this^0')
            return
        end

        local tempVehicle = CreateVehicle(model, 0, 0, 0, 0, true, true)
        while not DoesEntityExist(tempVehicle) do
            Wait(0)
        end
        local vehicleType = GetVehicleType(tempVehicle)
        DeleteEntity(tempVehicle)

        local ped = GetPlayerPed(source)
        if not coords then
            coords = Utils.GetCoordsFromEntity(ped)
        end

        local veh = CreateVehicleServerSetter(model, vehicleType, coords.x, coords.y, coords.z, coords.w)

        while not DoesEntityExist(veh) do
            Wait(0)
        end

        while GetVehicleNumberPlateText(veh) == "" do
            Wait(0)
        end

        if warp then SetPedIntoVehicle(ped, veh, -1) end
        return NetworkGetNetworkIdFromEntity(veh)
    end
else
    ---Wrapper for getting an entity handle and network id from a state bag name, [source](https://github.com/overextended/ox_core/blob/main/client/utils.lua)
    ---@async
    ---@param bagName string
    ---@return integer, integer
    function Utils.GetEntityAndNetIdFromBagName(bagName) -- luacheck: ignore
        local netId = tonumber(bagName:gsub('entity:', ''), 10)

        lib.waitFor(function()
            return NetworkDoesEntityExistWithNetworkId(netId)
        end, ('statebag timed out while awaiting entity creation! (%s)'):format(bagName), 10000)

        local entity = NetworkDoesEntityExistWithNetworkId(netId) and NetworkGetEntityFromNetworkId(netId) or 0

        if entity == 0 then
            lib.print.error(('statebag received invalid entity! (%s)'):format(bagName))
            return 0, 0
        end

        return entity, netId
    end

    ---@param keyFilter string
    ---@param cb fun(entity: number, netId: number, value: any, bagName: string)
    ---@return number
    function Utils.EntityStateHandler(keyFilter, cb) -- luacheck: ignore
        return AddStateBagChangeHandler(keyFilter, '', function(bagName, _, value)
            local entity, netId = Utils.GetEntityAndNetIdFromBagName(bagName)

            if entity then
                cb(entity, netId, value, bagName)
            end
        end)
    end
end

return Utils