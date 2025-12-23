-- Namespaces
mapi = {}

function mapi.wrap_text_with_color(text, color_hex)
	return string.format("|c%s%s|r", color_hex, text)
end

-- Helpers
function len(target)
	if not target then
		return 0
	end
	local t = type(target)
	if t == "table" then
		return table.getn(target)
	elseif t == "string" then
		return string.len(target)
	end
	return 0
end

function push_back(list, ...)
	for _, val in ipairs(arg) do
		table.insert(list, val)
	end
	return dest
end

function pop_front(list)
	if not list then
		return nil
	end
	return table.remove(list, 1)
end

function pop_back(list)
	if not list then
		return nil
	end
	return table.remove(list, len(list))
end

function append(dest, ...)
	return push_back(dest, unpack(arg))
end

function string.join(list, separator)
	local sep = separator or " "
	local out = ""
	for idx, str in ipairs(list) do
		if idx ~= 1 then
			out = out .. sep
		end
		out = out .. str
	end
	return out
end 