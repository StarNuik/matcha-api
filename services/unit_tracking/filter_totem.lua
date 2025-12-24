local svc_event = mapi.svc_event
local model_table = mapi.model.totems

mapi.Sub(svc_event.UNIT_TRACKING_ADDED, function(guid)
	if not mapi.IsTotem(guid) then
		return
	end
	model_table[guid] = true
	mapi.Pub(svc_event.UNIT_TRACKING_ADDED_TOTEM, guid)
end)

mapi.Sub(svc_event.UNIT_TRACKING_REMOVED, function(guid)
	model_table[guid] = nil
end)