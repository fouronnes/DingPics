if macros_database == nil then
    macros_database = {}
end

macros_database.hunter = {

{
name = "Auto Shot (spammable)",
comment = "Spammable version of regular Auto Shot",
text = [==[
#showtooltip Auto Shot
/cast !Auto Shot
]==]
},

{
name = "Initiate fight",
comment = "Lazy macro to start a fight. Auto-target the nearest hostile, send pet to attack, start Auto Shot and cast Hunter's Mark.",
text = [==[
#showtooltip Auto Shot
/cleartarget [dead]
/targetenemy [noharm]
/cast !Auto Shot
/petattack
/cast Hunter's Mark
]==]
},

{
name = "Scatter Shot",
comment = "Set pet to passive and cast Scatter Shot.",
text = [==[
#showtooltip Scatter Shot
/petpassive
/cast Scatter Shot
]==]
},

{
name = "Feign Death Trap",
comment = "Feign Death, set pet to passive and casts Freezing Trap.",
text = [==[
#showtooltip Freezing Trap
/cast Feign Death
/petpassive
/cast Freezing Trap
]==]
},

{
name = "Wing Clip (low mana)",
comment = "Downrank Wing Clip if not enough mana.",
text = [==[
#showtooltip Wing Clip
/cast Wing Clip
/cast Wing Clip(Rank 2)
/cast Wing Clip(Rank 1)
]==]
},


}