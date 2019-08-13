if macro_database == nil then
    macro_database = {}
end

macro_database.mage = {

{
name = "Smart Arcane Explosion",
comment = "Rank 1 Arcane Explosion if out of combat, maximum rank otherwise.",
text = [==[
#showtooltip Arcane Explosion
/cast [nocombat] Arcane Explosion(Rank 1); Arcane Explosion
/stopcasting
]==]
},

}