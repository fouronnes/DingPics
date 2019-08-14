require "druid"
require "hunter"
require "mage"
require "paladin"
require "priest"
require "rogue"
require "shaman"
require "warlock"
require "warrior"

function check_macro(macro)
    assert(macro.name)
    assert(macro.comment)
    assert(macro.text)
    assert(macro.comment:sub(-1) == ".", "Macro comment does not end with a '.'")
    --assert(#macro.name <= 16, "Macro name must be 16 characters or less")
    assert(#macro.text <= 255, "Macro text must be 255 characters or less")
end

local all_classes = {"druid", "hunter", "mage", "paladin", "priest", "rogue", "shaman", "warlock", "warrior"}

local count = 0
for _, class in ipairs(all_classes) do
    print(class)
    for _, macro in ipairs(macro_database[class]) do
        io.write(macro.name .. "... ")
        io.flush()
        check_macro(macro)
        print("OK")
        count = count + 1
    end
    print()
end

print(count .. " macros OK.")