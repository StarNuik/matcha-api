local svc_event = mapi.svc_event
local wow_event = mapi.wow_event
local model_table = mapi.model.units

local function add_unit(unit_id)
	local guid = mapi.GetUnitGuid(unit_id)
	if not guid then
		return
	end

	model_table[guid] = true
	mapi.Pub(svc_event.UNIT_TRACKING_ADDED, guid)
end

mapi.Sub(wow_event.WOW_PLAYER_TARGET_CHANGED,
	function() add_unit("target") end
)
mapi.Sub(wow_event.WOW_UPDATE_MOUSEOVER_UNIT,
	function() add_unit("mouseover") end
)

local arg_events = {
	wow_event.WOW_UNIT_AURA,
	wow_event.WOW_UNIT_FLAGS,
	wow_event.WOW_UNIT_HEALTH,
	wow_event.WOW_UNIT_COMBAT,
	wow_event.WOW_UNIT_FACTION,
	wow_event.WOW_UNIT_CASTEVENT,
	wow_event.WOW_UNIT_HAPPINESS,
	wow_event.WOW_UNIT_MODEL_CHANGED,
	wow_event.WOW_UNIT_PORTRAIT_UPDATE,
}
for _, e in ipairs(arg_events) do
	mapi.Sub(e, add_unit)
end