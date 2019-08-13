-- MacroBook

-- /console scriptErrors 1

MacroBook_VERSION = "0.1"

local AceGUI = LibStub("AceGUI-3.0")

macros = {

{
	name = "Bear powershift",
	icon = "INV_MISC_QUESTIONMARK",
	texture = 132091,
	comment = "In bear form, powershift. In other forms go to bear form.",
	text=[==[
#showtooltip Bear form
/cancelform
/cast [nostance:1] Bear Form
]==]
},

{
	name = "Moonfire any form",
	icon = "INV_MISC_QUESTIONMARK",
	comment = "todo",
	text =[==[
#showtooltip Moonfire
/cancelform
/cast Moonfire
]==]
},

{
	name = "Rejuv anyform",
	icon = "INV_MISC_QUESTIONMARK",
	comment = "todo",
	text =[==[
#showtooltip
/cancelform
/cast Rejuvenation
]==]
},

}


local frame = AceGUI:Create("Window")
frame:SetTitle("Macro Book")
frame:SetStatusText("AceGUI-3.0 Example Container Frame")
frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
frame:SetLayout("Flow")
frame:EnableResize(false)
frame:SetWidth(345)
frame:SetHeight(435)

function addMacro(macro_config)
	local btn = AceGUI:Create("MacroButton")
	
	-- Set the button icon as it will appear inside the Macro Book
	-- (not necessarily the same as the macro icon)
	-- if the texture fileID is provided, use that directly
	-- else get it from the macro icon
	-- This is useful for example for macros that have INV_MISC_QUESTIONMARK icons,
	-- to show a better icon in the macro book
	
	if macro_config["texture"] then
		btn:SetImage(macro_config["texture"])
	else
		btn:SetImage(GetFileIDFromPath("Interface/Icons/" .. macro_config["icon"]))
	end
	
	btn:SetWidth(36)
	btn:SetHeight(36)
	btn:SetImageSize(36, 36)
	frame:AddChild(btn)

	btn:SetCallback("OnClick", function(frame)
		local name = macro_config["name"]
		local icon = macro_config["icon"]
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

for i, macro in ipairs(macros) do
	addMacro(macro)
end

tree = { 
  { 
    value = "A",
    text = "Alpha",
    icon = "Interface\\Icons\\INV_Drink_05",
  },
  {
    value = "B",
    text = "Bravo",
    children = {
      { 
        value = "C", 
        text = "Charlie",
      },
      {
        value = "D",	
        text = "Delta",
        children = { 
          { 
            value = "E",
            text = "Echo"
          } 
        }
      }
    }
  },
  { 
    value = "F", 
    text = "Foxtrot",
    disabled = true,
  },
}

local treeframe = AceGUI:Create("TreeGroup")
treeframe:SetTree(tree)
treeframe:SetFullWidth(true)
treeframe:SetFullHeight(true)
treeframe:SetLayout("Fill")
frame:AddChild(treeframe)

print("MacroBook " .. MacroBook_VERSION .. " loaded")