local frame = CreateFrame("Frame")
frame:Hide()
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:SetScript("OnEvent", function (self, event)
	-- wait a bit so the yellow animation appears
	RequestTimePlayed()
	C_Timer.After(1, Screenshot)
end
)
