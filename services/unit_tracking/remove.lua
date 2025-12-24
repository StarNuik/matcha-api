local svc_event = mapi.svc_event
local wow_event = mapi.wow_event
local model_table = mapi.model.units

mapi.Sub(wow_event.WOW_UPDATE, function()
	for guid in pairs(model_table) do
		if not mapi.CanReadUnit(guid) then
			model_table[guid] = nil
			mapi.Pub(svc_event.UNIT_TRACKING_REMOVED, guid)
		end
	end
end)