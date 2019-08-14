if macro_database == nil then
    macro_database = {}
end

macro_database.druid = {

{
name = "Bear powershift",
comment = "In bear form, powershift. In other forms go to bear form.",
icon = "INV_MISC_QUESTIONMARK",
texture = 132091,
text = [==[
#showtooltip Bear form
/cancelform
/cast [nostance:1] Bear Form
]==]
},

{
name = "Feral Charge (anyform)",
comment = "Go to Bear Form if necessary and cast Feral Charge.",
text = [==[
#show Feral Charge
/dismount [mounted]
/cancelform [noform:1]
/cast [noform:1] !Bear Form
/cast [form:1] Feral Charge
]==]
},

{
name = "Prowl (anyform)",
comment = "Go to Cat form if necessary and out of combat and cast Prowl.",
text = [==[
#show Prowl
/dismount [mounted]
/cancelform [noform:3]
/cast [noform:3,nocombat] !Cat Form
/cast [form:3] !Prowl
]==]
},

{
name = "Dash (anyform)",
comment = "Go to Cat form if necessary and cast Dash.",
text = [==[
#show Sprint
/dismount [mounted]
/cancelform [noform:3]
/cast [noform:3] !Cat Form
/cast [form:3] Dash
]==]
},

{
name = "Pounce or Rake",
comment = "Pounce if stealth is active, Rake if not.",
text = [==[
#showtooltip
/cast [nostealth] Rake; [stealth] Pounce
]==]
},

{
name = "Ravage or Shred",
comment = "Ravage if stealth is active, Shred if not.",
text = [==[
#showtooltip
/cast [nostealth] Shred; [stealth] Ravage
]==]
},

{
name = "Trave or Aquatic form",
comment = "Aquatic Form if swimming, Travel Form if not.",
text = [==[
#showtooltip
/cast [swimming] Aquatic Form; [noswimming] Travel Form
]==]
},

{
name = "Cancel form or dismount",
comment = "Cancel current shapeshift form or dismount.",
text = [==[
/cancelform [noform:0]
/dismount [mounted]
]==]
},

{
name = "Cancel form or dismount or use mount",
comment = "If shapeshifted cancel form, if not shapeshifted use a mount, if currently on a mount dismount.",
text = [==[
/cancelform [noform:0,nomounted]
/dismount [mounted]
/use [form:0] Swift Green Mechanostrider
]==]
},

{
name = "Cancel form or dismount or unstealth",
comment = "If stealth is active, cancel it but stay in cat form. If otherwise shapeshifted cancel it, if simply in caster form use a mount.",
text = [==[
/cancelform [noform:0,nostealth]
/dismount [form:0]
/cancelaura [form:3,stealth] Prowl
]==]
},

{
name = "Cancel form or dismount or unstealth or use mount",
comment = "If stealth is active, cancel it but stay in cat form. If otherwise shapeshifted or mounted cancel it, if simply in caster form use a mount. Can be pressed twice to go from stealth to mount.",
text = [==[
/cancelaura [form:3,stealth] Prowl
/cancelform [noform:0,nostealth,nomount]
/dismount [form:0,nostealth,mount]
/use [form:0,nostealth] Swift Green Mechanostrider
]==]
},

{
name = "Consumable in bear form",
comment = "Virtually use a consumable in Bear Form by instantly switching back. Note that it will trigger the GCD and lose rage.",
text = [==[
/cancelform
/use [form:0] Minor Healing Potion
/cast [nostance:1] !Bear Form
]==]
},

{
name = "Consumable in cat form",
comment = "Virtually use a consumable in Cat Form by instantly switching back. Note that it will trigger the GCD and lose energy.",
text = [==[
/cancelform
/use [form:0] Minor Mana Potion
/cast [nostance:3] !Cat Form
]==]
},

{
name = "Faerie Fire (anyform)",
comment = "Cast Faerie Fire or Faerie Fire (Feral) if shapeshifted.",
text = [==[
/cast [noform, harm] Faerie Fire; [form:1/3, harm] Faerie Fire (Feral)
]==]
},

}

local spells = {
    "Regrowth", "Healing Touch", "Rejuvenation", "Tranquility",
    "Wrath", "Moonfire", "Starfire", "Entangling Roots", "Nature's Grasp", "Hurricane",
    "Mark of the Wild", "Thorns", "Innervate", "Barkskin",
    "Cure Poison", "Abolish Poison", "Remove Curse",
    "Hibernate", "Rebirth", "Omen of Clarity", "Insect Swarm", "Soothe Animal",
    "Teleport: Moonglade",
}

local macro_spell_template =
{
name = "%s (anyform)",
comment = "Cancel current shapeshift and cast maximum rank %s.",
text = [==[
#showtooltip
/cancelform
/cast %s
]==]
}

for _, spell in ipairs(spells) do
    local macro = {
        name = string.format(macro_spell_template.name, spell),
        comment = string.format(macro_spell_template.comment, spell),
        text = string.format(macro_spell_template.text, spell),
    }
    table.insert(macro_database.druid, macro)
end