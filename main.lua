local model = mapi.model

local function as_bool(value)
	if value then
		return true
	else
		return false
	end
end

function mapi.GetUnitGuid(unit_id)
	local _, guid = UnitExists(unit_id)
	return guid
end

function mapi.CanReadUnit(unit_id)
	return as_bool(
		UnitName(unit_id) ~= "Unknown"
	)
end

function mapi.IsTotem(unit_id)
	return as_bool(
		UnitCreatureType(unit_id) == "Totem"
	)
end

-- function mapi.Has