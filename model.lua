if not mapi_persistent_model then
	mapi_persistent_model = {}
end

local persistent_model = mapi_persistent_model

local function new_model()
	local self = {}

	self.units = {}
	self.totems = {}
	self.player_totems = {}

	return self
end

mapi.model = new_model()