local frame = CreateFrame("Frame")
frame:Hide()

frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_DEAD")

frame:SetScript("OnEvent", function (self, event)
	-- wait a bit so the yellow animation appears 800ms seems good
	RequestTimePlayed()
	C_Timer.After(0.8, function()
		Screenshot()
		end
	)
end
)
