local function new_event_bus()
	local self = {}

	function self.Fire(key, ...)
		if not self[key] then
			return
		end
		local listeners = self[key]
		for _, listener in ipairs(listeners) do
			listener(unpack(arg))
		end
	end

	function self.Subscribe(key, listener)
		if not self[key] then
			self[key] = {}
		end
		append(self[key], listener)
	end

	return self
end

local bus = new_event_bus()
mapi.Pub = bus.Fire
mapi.Sub = bus.Subscribe

local function pub(...)
	bus.Fire(unpack(arg))
end

local function sub(key, call)
	bus.Subscribe(key, call)
end

wow_events = {
	WOW_UPDATE = "UPDATE",
	WOW_CHAT_MSG_SKILL = "CHAT_MSG_SKILL",
	WOW_ADDON_LOADED = "ADDON_LOADED",
}

local function handle_event()
	pub(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
end

local function init_frame()
	local f = CreateFrame("Frame")
	
	f:SetScript("OnUpdate", function() pub(wow_events.WOW_UPDATE) end)
	f:SetScript("OnEvent", function() handle_event() end)

	for _, v in pairs(wow_events) do
		if v == "UPDATE" then
			-- continue
		else
			f:RegisterEvent(v)
		end
	end
end

init_frame()