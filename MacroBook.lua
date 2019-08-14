-- MacroBook

-- /console scriptErrors 1
--[[
TODO

checkbox: import to character specific macros
closable with escape
search box template from BlizzardInterfaceCode\Interface\SharedXML\SharedUIPanelTemplates.xml
label: Want to submit a new macro? Found a bug? Contribute to Community Macro Book here: https://github.com/fouronnes/CommunityMacroBook
call refresh on macro frame when importing
]]

MacroBook_VERSION = "0.1"

local AceGUI = LibStub("AceGUI-3.0")

root_frame, tree_frame, scroll_frame = SetupBaseGUI()

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




tree_frame:SetCallback("OnGroupSelected", function(self, event, group)
	if group == "Imported" then
		scroll_frame:ReleaseChildren()
	elseif group == "Druid" then
		fill_skills(macro_database.druid)
	end
end)

local selected_skill = nil

function fill_skills(macro_list)
	for i, macro in ipairs(macro_list) do
		--addMacro(root_frame, macro)
	
		local ilabel = AceGUI:Create("SkillButton")
		ilabel:SetText(macro.name)

		ilabel:SetColor(.2, .9, .2)
		ilabel:SetWidth(300)
		ilabel:SetHeight(20)
		ilabel:SetCallback("OnClick", function(frame)
			print(macro.name)
			frame:SetSelected(true)
			if selected_skill then
				selected_skill:SetSelected(false)
			end
			selected_skill = ilabel

		end)
		scroll_frame:AddChild(ilabel)
	end
end

--[[
local button = CreateFrame("EditBox", "name", UIParent, "SearchBoxTemplate")
button:SetText("hlhqmlf")
button:SetSize(80, 22)
button:SetPoint("CENTER")
]]

print("MacroBook " .. MacroBook_VERSION .. " loaded")


--[[
the list of skill interface is made of:
- buttons with the template ClassTrainerSkillButtonTemplate from BlizzardInterfaceCode\Interface\FrameXML\ClassTrainerFrameTemplates.xml
- a highlight frame ClassTrainerSkillHighlightFrame from BlizzardInterfaceCode\Interface\AddOns\Blizzard_TrainerUI\Blizzard_TrainerUI.xml
- logic in the lua to move the anchor of the hightlight frame when the skill is clicked

cannot test those templates with the retail client. Maybe they just work in the classic client
i can also just reproduce the template with the right textures & stuff
]]


local view_frame = AceGUI:Create("InlineGroup")
--view_frame:SetTitle("View Frame")
--view_frame:SetLayout("Flow")
view_frame:SetTitle("Title of the view frame")
view_frame:SetHeight(200)
view_frame:SetFullWidth(true)
root_frame:AddChild(view_frame)
--view_frame:SetText("view frame")

for i = 1,10 do
	local label = AceGUI:Create("Label")
	label:SetText(tostring(i) .. " label")
	view_frame:AddChild(label)
end

