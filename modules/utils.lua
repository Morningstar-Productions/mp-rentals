local Utils = {}

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

---Get the coords including the heading from an entity
---@param entity number
---@return vector4
function Utils.GetCoordsFromEntity(entity) -- luacheck: ignore
    local coords = GetEntityCoords(entity)
    return vec4(coords.x, coords.y, coords.z, GetEntityHeading(entity))
end

return Utils