local MPc = {}

---@param text string
---@param textType string
---@param duration number
function MPc.Notify(text, textType, duration)
    if GetResourceState('qb-core'):match('started') then
        exports['qb-core']:GetCoreObject().Functions.Notify(text, textType, duration)
    else
        lib.notify({
            description = text,
            type = textType,
            duration = duration
        })
    end
end

return MPc