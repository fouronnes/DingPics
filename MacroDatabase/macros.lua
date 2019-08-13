

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table_extend(t, items)
    for i, v in ipairs(items) do
        table.insert(t, v)
    end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function tstr(elem)
    if type(elem) ~= "table" then
        return tostring(elem)
    end

    local output = {}
    for i, v in ipairs(elem) do
        table.insert(output, tstr(v))
    end
    return "{" .. table.concat(output, ", ") .. "}"
end


states = {"bear", "cat", "caster"}

all_transitions = {

bear = {
    {"/cast Feral Charge", "bear", 0},
 --   {"/cast Enrage", "bear", 0},
    --{"/cast Growl", "bear", 0},
    {"/cancelform", "caster", 0},
},

cat = {
    --{"/cast Prowl", "catprowl", 0},
    --{"/cancelform", "caster", 0},
},

catprowl = {
},

caster = {
    {"/cast Bear form", "bear", 1},
    --{"Cat form", "cat", 1},
    {"/cast Travel form", "travel", 1},
 --   {"/use Healing Potion", "caster", 0},
 --   {"/cast Nature's Swiftness", "caster", 0},
 --   {"/cast Healing Touch", "caster", 1},
},

travel = {
    {"/cancelform", "caster", 0},
}

}

start = "bear"
paths = {}

-- state: "caster"
-- action: "/cast Bear Form"
-- transition: {"/cancelform", "caster", 0}
-- path: { {"/cancelform", "caster", 0}, {"Bear form", "bear", 1}}

function contains_action(path, action)
    for i, v in ipairs(path) do
        if v[1] == action then
            return true
        end
    end
    return false
end

function cost(path)
    local acc = 0
    for i, v in ipairs(path) do
        acc = acc + v[3]
    end
    return acc
end

function possible_transitions(path)
    local state = path[#path][2]

    local output = {}
    for i, vv in ipairs(all_transitions[state]) do
        if not contains_action(path, vv[1]) and cost(path) + vv[3] <= 1 then
            table.insert(output, vv )
        end
    end
    return output
end


function paths_one_longer(path)
    local output = {}
    local state = path[#path][2]
    for i, next in ipairs(possible_transitions(path)) do
        copy = deepcopy(path)
        table.insert(copy, next)
        table.insert(output, copy)
    end
    return output
end

local closed = {}
local open = {
    {{"start", "bear", 0}},
    {{"start", "cat", 0}},
    {{"start", "caster", 0}},
    {{"start", "travel", 0}},
}

while #open > 0 do
    local onelonger = {}
    for i, openpath in ipairs(open) do
        table_extend(onelonger, paths_one_longer(openpath))
    end

    -- move open to closed
    for i, v in ipairs(open) do
        table.insert(closed, v)
    end

    -- move onelonger to open
    open = onelonger
end

function render_path(path)
    --print("cost=" .. cost(path))
    print("# Start in " .. path[1][2] .. " form")
    for i, v in ipairs({unpack(path, 2, #path)}) do
        print(v[1])
    end
end

local total = 0
for i, path in ipairs(closed) do
    if #path > 2 then
        total = total + 1
        render_path(path)
        print()
    end
end
print("total = " .. total)