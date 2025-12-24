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

local pub = mapi.Pub
local sub = mapi.Sub
local wow_event = mapi.wow_event

local function handle_event()
	pub(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
end

local function init_frame()
	local f = CreateFrame("Frame")
	
	f:SetScript("OnUpdate", function() pub(wow_event.WOW_UPDATE) end)
	f:SetScript("OnEvent", function() handle_event() end)

	for _, v in pairs(wow_event) do
		if v == "UPDATE" then
			-- continue
		else
			f:RegisterEvent(v)
		end
	end
end
init_frame()