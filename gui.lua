local AceGUI = LibStub("AceGUI-3.0")

function SetupBaseGUI()
    local root_frame = AceGUI:Create("Frame") -- or Window?
    root_frame:SetTitle("Community Macro Book")
    root_frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    root_frame:SetLayout("List")
    root_frame:EnableResize(true)
    --root_frame:SetStatusText("Idea for a new macro? Found a bug? Contribute here: https://github.com/fouronnes/CommunityMacroBook")
    root_frame:SetWidth(450)
    root_frame:SetHeight(500)

    local search_group = AceGUI:Create("SimpleGroup")
    search_group:SetLayout("Flow")
    search_group:SetFullWidth(true)
    root_frame:AddChild(search_group)

    local checkbox = AceGUI:Create("CheckBox")
    checkbox:SetLabel("Import to character specific macros")
    checkbox:SetWidth(244) -- padding to align the search box right
    search_group:AddChild(checkbox)

    local search_box = AceGUI:Create("SearchBox")
    --search_box:SetLabel("Search")
    search_box:SetWidth(170)
    search_group:AddChild(search_box)

    local tree_frame = AceGUI:Create("TreeGroup")
    tree_frame:SetTree(cmb_classes_tree)
    tree_frame:SetTreeWidth(100, false)
    tree_frame:SetFullWidth(true)
    tree_frame:SetHeight(220)
    tree_frame:SetLayout("Fill")
    root_frame:AddChild(tree_frame)

    local scroll_frame = AceGUI:Create("ScrollFrame")
    scroll_frame:SetLayout("List")
    tree_frame:AddChild(scroll_frame)

    local view_frame = AceGUI:Create("SimpleGroup")
    --view_frame:SetLayout("Flow")
    --view_frame:SetTitle("Feral Charge (anyform) ")
    view_frame:SetHeight(200)
    view_frame:SetFullWidth(true)
    root_frame:AddChild(view_frame)
    --view_frame:SetText("view frame")

    local macro_group = AceGUI:Create("SimpleGroup")
    macro_group:SetLayout("Flow")
    view_frame:AddChild(macro_group)

    local macro_button = AceGUI:Create("MacroButton")
    macro_button:SetImage(GetFileIDFromPath("Interface/Icons/ability_cheapshot"))
    macro_button:SetWidth(36)
	macro_button:SetHeight(36)
    macro_button:SetImageSize(36, 36)
    macro_group:AddChild(macro_button)

    local macro_title = AceGUI:Create("Label")
    macro_title:SetText("Faerie Fire (anyform)")
    macro_title:SetHeight(30)
    --fontName, fontHeight, fontFlags = MyFontObject:GetFont()
    macro_title:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE, MONOCHROME")

    macro_group:AddChild(macro_title)

    local macro_comment = AceGUI:Create("Label")
    macro_comment:SetText("Cast Faerie Fire or Faerie Fire (Feral) if shapeshifted.")
    macro_comment:SetFullWidth(true)
    view_frame:AddChild(macro_comment)

    return tree_frame, scroll_frame, macro_title, macro_comment
end
