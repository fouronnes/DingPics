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

    local padding = AceGUI:Create("Label")
    --padding:SetText("padding")
    padding:SetWidth(244)
    search_group:AddChild(padding)

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

    local view_frame = AceGUI:Create("InlineGroup")
    --view_frame:SetTitle("View Frame")
    --view_frame:SetLayout("Flow")
    --view_frame:SetTitle("Feral Charge (anyform) ")
    view_frame:SetHeight(200)
    view_frame:SetFullWidth(true)
    root_frame:AddChild(view_frame)
    --view_frame:SetText("view frame")

    for i = 1,10 do
        local label = AceGUI:Create("Label")
        --label:SetText(tostring(i) .. " label")
        --view_frame:AddChild(label)
    end

    return root_frame, tree_frame, scroll_frame, view_frame
end
