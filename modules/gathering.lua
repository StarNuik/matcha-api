local skills = {
	herbalism = "HERBALISM",
	mining = "MINING",
}

local skill_colors = {
	RED = "ffEE783C",
	YELLOW = "ffEEEE00",
	GREEN = "ff3CB33C",
	GRAY = "ff787878",
}

local function skill_item(id, name, red, yellow, green, gray)
	return {
		id = id,
		red = red,
		yellow = yellow,
		green = green,
		gray = gray
	}
end

local db = {
	herbalism = {
		skill_item(2447, "Peacebloom", 1, 25, 50, 100),
		skill_item(765 , "Silverleaf", 1, 25, 50, 100),
		skill_item(2449, "Earthroot", 15, 40, 65, 115),
		skill_item(1620, "Mageroyal", 50, 75, 100, 150),
		skill_item(1621, "Briarthorn", 70, 95, 120, 170),
		skill_item(2045, "Stranglekelp", 85, 110, 135, 185),
		skill_item(1622, "Bruiseweed", 100, 125, 150, 200),
		skill_item(1623, "Wild Steelbloom", 115, 140, 165, 215),
		skill_item(1628, "Grave Moss", 120, 145, 170, 220),
		skill_item(1624, "Kingsblood", 125, 150, 175, 225),
		skill_item(2041, "Liferoot", 150, 175, 200, 250),
		skill_item(2042, "Fadeleaf", 160, 185, 210, 260),
		skill_item(2046, "Goldthorn", 170, 195, 220, 270),
		skill_item(2043, "Khadgar's Whisker", 185, 210, 235, 285),
		skill_item(2044, "Wintersbite", 195, 220, 245, 295),
		skill_item(2866, "Firebloom", 205, 230, 255, 305),
		skill_item(142140, "Purple Lotus", 210, 235, 260, 310),
		skill_item(142141, "Arthas' Tears", 220, 245, 270, 320),
		skill_item(142142, "Sungrass", 230, 255, 280, 330),
		skill_item(142143, "Blindweed", 235, 260, 285, 335),
		skill_item(142144, "Ghost Mushroom", 245, 270, 295, 345),
		skill_item(142145, "Gromsblood", 250, 275, 300, 350),
		skill_item(176583, "Golden Sansam", 260, 285, 310, 360),
		skill_item(176584, "Dreamfoil", 270, 290, 315, 370),
		skill_item(176586, "Mountain Silversage", 280, 305, 330, 380),
		skill_item(176587, "Plaguebloom", 285, 310, 335, 385),
		skill_item(176588, "Icecap", 290, 315, 340, 390),
		skill_item(176589, "Black Lotus", 300, 325, 350, 400),
	},
	item_name = {
		[2447] = "Peacebloom",
		[ 765] = "Silverleaf",
		[2449] = "Earthroot",
		[1620] = "Mageroyal",
		[1621] = "Briarthorn",
		[2045] = "Stranglekelp",
		[1622] = "Bruiseweed",
		[1623] = "Wild Steelbloom",
		[1628] = "Grave Moss",
		[1624] = "Kingsblood",
		[2041] = "Liferoot",
		[2042] = "Fadeleaf",
		[2046] = "Goldthorn",
		[2043] = "Khadgar's Whisker",
		[2044] = "Wintersbite",
		[2866] = "Firebloom",
		[142140] = "Purple Lotus",
		[142141] = "Arthas' Tears",
		[142142] = "Sungrass",
		[142143] = "Blindweed",
		[142144] = "Ghost Mushroom",
		[142145] = "Gromsblood",
		[176583] = "Golden Sansam",
		[176584] = "Dreamfoil",
		[176586] = "Mountain Silversage",
		[176587] = "Plaguebloom",
		[176588] = "Icecap",
		[176589] = "Black Lotus",
	}
}

local skill_msg_full = "Your skill in %s has increased to %d."
local skill_msg_starts = "Your skill in "

local function is_skill_up(msg)
	local msg_start = string.sub(msg, 1, len(skill_msg_starts))
	return msg_start == skill_msg_starts
end

local function skill_level(msg)
	local from, to = string.find(msg, "%d+")
	local num_str = string.sub(msg, from, to)
	return tonumber(num_str)
end

local function skill_name(msg)
	local msg = string.upper(msg)
	for key, val in pairs(skills) do
		local result = string.find(msg, val)
		if result then
			return key
		end
	end
	return nil
end

local function format_skill(id, color)
	local name = db.item_name[id]
	return string.format("|c%s|Hitem:%d:0:0:0|h[%s]|h|r", color, id, name)
end

local function append_skills(dest, ids, color)
	for _, id in ids do
		append(dest, format_skill(id, color))
	end
end

local function update_lists(level, skill_table)
	local red = {}
	local yellow = {}
	local green = {}
	local gray = {}

	for _, row in pairs(skill_table) do
		if level == row.red then
			append(red, row.id)
		end
		if level == row.yellow then
			append(yellow, row.id)
		end
		if level == row.green then
			append(green, row.id)
		end
		if level == row.gray then
			append(gray, row.id)
		end
	end

	return red, yellow, green, gray
end

local function handle(msg)
	if not is_skill_up(msg) then
		return
	end

	local skill = skill_name(msg)
	if not skill then
		return
	end

	local level = skill_level(msg)
	local skill_table = db[skill]

	local red, yellow, green, gray = update_lists(level, skill_table)

	if len(red) == 0 and len(yellow) == 0 and len(green) == 0 and len(gray) == 0 then
		return
	end

	local skill_strs = {}
	append_skills(skill_strs, red, skill_colors.RED)
	append_skills(skill_strs, yellow, skill_colors.YELLOW)
	append_skills(skill_strs, green, skill_colors.GREEN)
	append_skills(skill_strs, gray, skill_colors.GRAY)
	local skills = string.join(skill_strs, ", ")

	print(string.format("%s upgrade: %s.", skill, skills))
end

function debug_pub(level)
	mapi.Pub(wow_events.WOW_CHAT_MSG_SKILL,
		string.format("Your skill in %s has increased to %d.", "Herbalism", level)
	)
end

print("Hello, gathering!")
print(mapi.Sub)
mapi.Sub(wow_events.WOW_CHAT_MSG_SKILL, handle)
