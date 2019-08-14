local AceGUI = LibStub("AceGUI-3.0")

function SetupBaseGUI()
    local root_frame = AceGUI:Create("Frame") -- or Window?
    root_frame:SetTitle("Community Macro Book")
    root_frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    root_frame:SetLayout("List")
    root_frame:EnableResize(true)
    --root_frame:SetWidth(545)
    --root_frame:SetHeight(435)

    local tree_frame = AceGUI:Create("TreeGroup")
    tree_frame:SetTree(cmb_classes_tree)
    tree_frame:SetFullWidth(true)
    tree_frame:SetHeight(250)
    tree_frame:SetLayout("Fill")
    root_frame:AddChild(tree_frame)

    local scroll_frame = AceGUI:Create("ScrollFrame")
    scroll_frame:SetLayout("List")
    tree_frame:AddChild(scroll_frame)

    return root_frame, tree_frame, scroll_frame
end
