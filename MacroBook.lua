-- MacroBook

-- /console scriptErrors 1
--[[
TODO

checkbox: import to character specific macros
closable with escape
search box template from BlizzardInterfaceCode\Interface\SharedXML\SharedUIPanelTemplates.xml
label: Want to submit a new macro? Found a bug? Contribute to Community Macro Book here: https://github.com/fouronnes/CommunityMacroBook

]]

MacroBook_VERSION = "0.1"

local AceGUI = LibStub("AceGUI-3.0")

local root_frame = AceGUI:Create("Window")
root_frame:SetTitle("Macro Book")
root_frame:SetStatusText("AceGUI-3.0 Example Container Frame")
root_frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
root_frame:SetLayout("Flow")
root_frame:EnableResize(true)
root_frame:SetWidth(345)
root_frame:SetHeight(435)

function addMacro(parent_frame, macro_config)
	local btn = AceGUI:Create("MacroButton")
	
	-- Set the button icon as it will appear inside the Macro Book
	-- (not necessarily the same as the macro icon)
	-- if the texture fileID is provided, use that directly
	-- else get it from the macro icon
	-- This is useful for example for macros that have INV_MISC_QUESTIONMARK icons,
	-- to show a better icon in the macro book
	
	if macro_config["texture"] then
		btn:SetImage(macro_config["texture"])
	elseif macro_config["icon"] then
		btn:SetImage(GetFileIDFromPath("Interface/Icons/" .. macro_config["icon"]))
	else
		btn:SetImage(GetFileIDFromPath("Interface/Icons/INV_MISC_QUESTIONMARK"))
	end
	
	btn:SetWidth(36)
	btn:SetHeight(36)
	btn:SetImageSize(36, 36)
	parent_frame:AddChild(btn)

	btn:SetCallback("OnClick", function(frame)
		local name = macro_config["name"]
		local icon = macro_config["icon"] or "INV_MISC_QUESTIONMARK"
		local text = macro_config["text"]

		-- Check if the macro already exists
		-- If not, create it
		-- If yes, update it
		local index = GetMacroIndexByName(name)
		if index == 0 then
			print(name)
			print(icon)
			print(text)
			index = CreateMacro(name, icon, text, true)
			print("\"".. name .. "\" macro added at index " .. index)
		else
			EditMacro(index, name, icon, text)
		end
		
		PickupMacro(index)
	end);
end

for i, macro in ipairs(macro_database.druid) do
	addMacro(root_frame, macro)
end

tree = { 
{ 
	value = "Druid",
	text = "Druid",
	icon = "Interface\\Icons\\Inv_misc_monsterclaw_04",
},
{ 
	value = "Hunter",
	text = "Hunter",
	icon = "Interface\\Icons\\inv_weapon_bow_07",
},
{ 
	value = "Mage",
	text = "Mage",
	icon = "Interface\\Icons\\inv_staff_13",
},
{ 
	value = "Paladin",
	text = "Paladin",
	icon = "Interface\\Icons\\ability_thunderbolt",
},
{ 
	value = "Priest",
	text = "Priest",
	icon = "Interface\\Icons\\inv_staff_30",
},
{ 
	value = "Rogue",
	text = "Rogue",
	icon = "Interface\\Icons\\inv_throwingknife_04",
},
{ 
	value = "Shaman",
	text = "Shaman",
	icon = "Interface\\Icons\\inv_jewelry_talisman_04",
},
{ 
	value = "Warlock",
	text = "Warlock",
	icon = "Interface\\Icons\\spell_nature_drowsy",
},
{ 
value = "Warrior",
text = "Warrior",
icon = "Interface\\Icons\\inv_sword_27",
},
}

local treeframe = AceGUI:Create("TreeGroup")
treeframe:SetTree(tree)
treeframe:SetFullWidth(true)
treeframe:SetFullHeight(true)
treeframe:SetLayout("Fill")
root_frame:AddChild(treeframe)

local scrollframe = AceGUI:Create("ScrollFrame")
scrollframe:SetLayout("Flow")
treeframe:AddChild(scrollframe)

local button = AceGUI:Create("Button")
button:SetText("click me")
scrollframe:AddChild(button)

local checkbox = AceGUI:Create("CheckBox")
checkbox:SetLabel("check me")
checkbox:SetDescription("this is a description")
checkbox:SetFullWidth(true)
scrollframe:AddChild(checkbox)

local dropdown = AceGUI:Create("Dropdown")
dropdown:SetLabel("drop me")
dropdown:SetList({"hello", "world", "again"})
scrollframe:AddChild(dropdown)

local heading = AceGUI:Create("Heading")
heading:SetText("heading!")
heading:SetFullWidth(true)
scrollframe:AddChild(heading)

--[[
local button = CreateFrame("EditBox", "name", UIParent, "SearchBoxTemplate")
button:SetText("hlhqmlf")
button:SetSize(80, 22)
button:SetPoint("CENTER")
]]

local mleb = AceGUI:Create("MultiLineEditBox")
mleb:SetText(macro_database.druid[4].text)
mleb:SetLabel("Macro text:")
mleb:SetNumLines(6)
scrollframe:AddChild(mleb)


for i = 1,100 do
	local frame2 = AceGUI:Create("Label")
	frame2:SetText("hello world")
	frame2:SetFullWidth(true)
	scrollframe:AddChild(frame2)
end

print("MacroBook " .. MacroBook_VERSION .. " loaded")


--[[
the list of skill interface is made of:
- buttons with the template ClassTrainerSkillButtonTemplate from BlizzardInterfaceCode\Interface\FrameXML\ClassTrainerFrameTemplates.xml
- a highlight frame ClassTrainerSkillHighlightFrame from BlizzardInterfaceCode\Interface\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.xml
- logic in the lua to move the anchor of the hightlight frame when the skill is clicked

cannot test those templates with the retail client. Maybe they just work in the classic client
i can also just reproduce the template with the right textures & stuff
]]