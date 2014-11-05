local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_warlock_spells"
	local desc = "[6.0.2] Ovale: Warlock spells"
	local code = [[
# Warlock spells and functions.

Define(agony 980)
	SpellAddTargetDebuff(agony agony_debuff=1)
Define(agony_debuff 980)
	SpellInfo(agony_debuff duration=24 haste=spell max_stacks=10 tick=2)
Define(archimondes_darkness_talent 16)
Define(backdraft 117896)
Define(backdraft_buff 117828)
	SpellInfo(backdraft_buff duration=15 max_stacks=3)
# cancel_metamorphosis
Define(cataclysm 152108)
	SpellInfo(cataclysm cd=60 gcd=0)
Define(cataclysm_talent 20)
Define(chaos_bolt 116858)
	SpellInfo(chaos_bolt burningembers=10)
	SpellInfo(chaos_bolt buff_burningembers=fire_and_brimstone_buff buff_burningembers_amount=10 if_spell=charred_remains if_spell=fire_and_brimstone)
	SpellAddBuff(chaos_bolt chaotic_infusion_buff=0)
	SpellAddBuff(chaos_bolt backdraft_buff=-3 if_spell=backdraft)
	SpellAddBuff(chaos_bolt fire_and_brimstone_buff=0 if_spell=charred_remains if_spell=fire_and_brimstone)
	SpellAddBuff(chaos_bolt havoc_buff=-3 if_spell=havoc)
Define(chaos_wave 124916)
	SpellInfo(chaos_wave demonicfury=80 stance=warlock_metamorphosis)
	SpellAddBuff(chaos_wave fel_molten_core_buff=1 if_spell=the_codex_of_xerrath)
	SpellAddBuff(chaos_wave molten_core_buff=1 if_spell=!the_codex_of_xerrath)
Define(chaotic_infusion_buff 170000)
	SpellInfo(chaotic_infusion_buff duration=30)
Define(charred_remains 157696)
Define(charred_remains_talent 19)
Define(conflagrate 17962)
	SpellInfo(conflagrate burningembers=-1)
	SpellInfo(conflagrate burningembers=-2 if_spell=charred_remains)
	SpellInfo(conflagrate buff_burningembers=fire_and_brimstone_buff buff_burningembers_amount=10 if_spell=fire_and_brimstone)
	SpellAddBuff(conflagrate fire_and_brimstone_buff=0 if_spell=fire_and_brimstone)
	SpellAddBuff(conflagrate havoc_buff=-1 if_spell=havoc)
Define(corruption 172)
	SpellAddTargetDebuff(corruption corruption_debuff=1)
Define(corruption_debuff 146739)
	SpellInfo(corruption_debuff duration=18 haste=spell tick=2)
Define(dark_intent 109773)
	SpellAddBuff(dark_intent dark_intent_buff=1)
Define(dark_intent_buff 109773)
	SpellInfo(dark_intent_buff duration=3600)
Define(dark_soul_instability 113858)
	SpellInfo(dark_soul_instability gcd=0)
	SpellInfo(dark_soul_instability cd=120 talent=!archimondes_darkness_talent)
	SpellInfo(dark_soul_instability cd=60 glyph=glyph_of_dark_soul talent=!archimondes_darkness_talent)
	SpellAddBuff(dark_soul_instability dark_soul_instability_buff=1)
Define(dark_soul_instability_buff 113858)
	SpellInfo(dark_soul_instability_buff duration=20)
	SpellInfo(dark_soul_instability_buff duration=10 glyph=glyph_of_dark_soul)
Define(dark_soul_knowledge 113861)
	SpellInfo(dark_soul_knowledge gcd=0)
	SpellInfo(dark_soul_knowledge cd=120 talent=!archimondes_darkness_talent)
	SpellInfo(dark_soul_knowledge cd=60 glyph=glyph_of_dark_soul talent=!archimondes_darkness_talent)
	SpellAddBuff(dark_soul_knowledge dark_soul_knowledge_buff=1)
Define(dark_soul_knowledge_buff 113858)
	SpellInfo(dark_soul_knowledge_buff duration=20)
	SpellInfo(dark_soul_knowledge_buff duration=10 glyph=glyph_of_dark_soul)
Define(dark_soul_misery 113860)
	SpellInfo(dark_soul_misery gcd=0)
	SpellInfo(dark_soul_misery cd=120 talent=!archimondes_darkness_talent)
	SpellInfo(dark_soul_misery cd=60 glyph=glyph_of_dark_soul talent=!archimondes_darkness_talent)
	SpellAddBuff(dark_soul_misery dark_soul_misery_buff=1)
Define(dark_soul_misery_buff 113858)
	SpellInfo(dark_soul_misery_buff duration=20)
	SpellInfo(dark_soul_misery_buff duration=10 glyph=glyph_of_dark_soul)
Define(demonbolt 157695)
	SpellInfo(demonbolt demonicfury=80 stance=warlock_metamorphosis)
	SpellAddBuff(demonbolt demonbolt_buff=1)
Define(demonbolt_buff 157695)
	SpellInfo(demonbolt_buff duration=40 max_stacks=10)
Define(demonbolt_talent 19)
Define(demonic_servitude_talent 21)
Define(demonic_synergy_buff 171982)
	SpellInfo(demonic_synergy_buff duration=15)
Define(doom 603)
	SpellInfo(doom demonicfury=60 stance=warlock_metamorphosis)
	SpellAddTargetDebuff(doom doom_debuff=1)
Define(doom_debuff 603)
	SpellInfo(doom_debuff duration=60 haste=spell tick=15)
Define(drain_soul 103103)
	SpellInfo(drain_soul channel=4 haste=spell)
Define(ember_master_buff 145164)	# tier16_4pc_caster
	SpellInfo(ember_master_buff duration=5)
Define(enhanced_haunt 157072)
Define(fel_molten_core_buff 140074)
	SpellInfo(fel_molten_core_buff duration=30 max_stacks=10)
Define(felguard_felstorm 89751)
	SpellInfo(felguard_felstorm cd=45 gcd=0)
Define(fire_and_brimstone 108683)
	SpellInfo(fire_and_brimstone cd=1 gcd=0)
	SpellAddBuff(fire_and_brimstone fire_and_brimstone_buff=1)
Define(fire_and_brimstone_buff 108683)
Define(glyph_of_dark_soul 159665)
Define(glyph_of_imp_swarm 56242)
Define(glyph_of_life_pact 159669)
Define(grimoire_felguard 111898)
	SpellInfo(grimoire_felguard cd=120 sharedcd=grimoire_of_service)
Define(grimoire_felhunter 111897)
	SpellInfo(grimoire_felhunter cd=120 sharedcd=grimoire_of_service)
Define(grimoire_imp 111859)
	SpellInfo(grimoire_imp cd=120 sharedcd=grimoire_of_service)
Define(grimoire_of_sacrifice 108503)
	SpellInfo(grimoire_of_sacrifice cd=30 gcd=0)
	SpellAddBuff(grimoire_of_sacrifice grimoire_of_sacrifice_buff=1)
Define(grimoire_of_sacrifice_buff 108503)
	SpellInfo(grimoire_of_sacrifice_buff duration=3600)
Define(grimoire_of_sacrifice_talent 15)
Define(grimoire_of_service_talent 14)
Define(grimoire_succubus 111896)
	SpellInfo(grimoire_succubus cd=120 sharedcd=grimoire_of_service)
Define(grimoire_voidwalker 111895)
	SpellInfo(grimoire_voidwalker cd=120 sharedcd=grimoire_of_service)
Define(hand_of_guldan 105174)
	SpellInfo(hand_of_guldan max_travel_time=1.5) # maximum observed travel time with a bit of padding
	SpellAddTargetDebuff(hand_of_guldan shadowflame_debuff=1)
Define(haunt 48181)
	SpellInfo(haunt shards=1)
	SpellInfo(haunt max_travel_time=2.3) # maximum observed travel time with a bit of padding
	SpellAddTargetDebuff(haunt haunt_debuff=1)
Define(haunt_debuff 48181)
	SpellInfo(haunt_debuff duration=8 haste=spell tick=2)
	SpellInfo(haunt_debuff addduration=2 if_spell=enhanced_haunt)
Define(haunting_spirits_buff 157698)
	SpellInfo(haunting_spirits_buff duration=30)
Define(havoc 80240)
	SpellInfo(havoc cd=25)
	SpellAddBuff(havoc havoc_buff=3)
	SpellAddTargetDebuff(havoc havoc_debuff=1)
Define(havoc_buff 80240)
	SpellInfo(havoc_buff duration=15 max_stacks=3)
Define(havoc_debuff 80240)
	SpellInfo(havoc_debuff duration=15)
Define(immolate 348)
	SpellInfo(immolate buff_burningembers=fire_and_brimstone_buff buff_burningembers_amount=11 if_spell=fire_and_brimstone)
	SpellAddBuff(immolate havoc_buff=-1 if_spell=havoc)
	SpellAddTargetDebuff(immolate immolate_debuff=1)
Define(immolate_debuff 157736)
	SpellInfo(immolate_debuff duration=15 haste=spell tick=3)
Define(immolation_aura 104025)
	SpellInfo(immolation_aura demonicfury=0 stance=warlock_metamorphosis)
	SpellAddBuff(immolation_aura immolation_aura_buff=1)
Define(immolation_aura_buff 104025)
	SpellInfo(immolation_aura_buff duration=10 haste=spell tick=1)
Define(imp_swarm 104316)
	SpellInfo(imp_swarm cd=120 cd_haste=1)
	SpellInfo(imp_swarm unusable=1 glyph=!glyph_of_imp_swarm)
Define(incinerate 29722)
	SpellInfo(incinerate burningembers=-1)
	SpellInfo(incinerate burningembers=-2 if_spell=charred_remains)
	SpellInfo(incinerate buff_burningembers=fire_and_brimstone_buff buff_burningembers_amount=10 if_spell=fire_and_brimstone)
	SpellAddBuff(incinerate backdraft_buff=-1 if_spell=backdraft)
	SpellAddBuff(incinerate havoc_buff=-1 if_spell=havoc)
Define(life_tap 1454)
	SpellInfo(life_tap unusable=1 glyph=glyph_of_life_pact)
Define(mannoroths_fury 108508)
	SpellInfo(mannoroths_fury cd=60 gcd=0)
	SpellAddBuff(mannoroths_fury mannoroths_fury_buff=1)
Define(mannoroths_fury_buff 108508)
	SpellInfo(mannoroths_fury_buff duration=10)
Define(mannoroths_fury_talent 18)
Define(metamorphosis 103958)
	SpellInfo(metamorphosis cd=10 gcd=0)
	SpellInfo(metamorphosis to_stance=warlock_metamorphosis if_stance=!warlock_metamorphosis)
	SpellAddBuff(metamorphosis metamorphosis_buff=1 if_stance=!warlock_metamorphosis)
	SpellAddBuff(metamorphosis metamorphosis_buff=0 if_stance=warlock_metamorphosis)
Define(metamorphosis_buff 103958)
Define(molten_core_buff 122355)
	SpellInfo(molten_core_buff duration=30 max_stacks=10)
Define(rain_of_fire 104232)
Define(rain_of_fire_debuff 104232)
	SpellInfo(rain_of_fire_debuff duration=8 haste=spell tick=1)
Define(shadow_bolt 686)
	SpellInfo(shadow_bolt demonicfury=-25 specialization=demonology)
	SpellInfo(shadow_bolt max_travel_time=2.2) # maximum observed travel time with a bit of padding
	SpellAddBuff(shadow_bolt fel_molten_core_buff=1,target_health_pct,25 if_spell=the_codex_of_xerrath specialization=demonology)
	SpellAddBuff(shadow_bolt molten_core_buff=1,target_health_pct,25 if_spell=!the_codex_of_xerrath specialization=demonology)
Define(Shadowburn 17877) # SimulationCraft bug workaround
Define(shadowburn 17877)
	SpellInfo(shadowburn burningembers=10 target_health_pct=20)
	SpellAddBuff(shadowburn havoc_buff=-1 if_spell=havoc)
Define(shadowflame_debuff 47960)
	SpellInfo(shadowflame_debuff duration=6 haste=spell tick=1)
Define(soul_fire 6353)
	SpellInfo(soul_fire demonicfury=-30)
	SpellInfo(soul_fire replace=soul_fire_metamorphosis ususable=1 if_stance=warlock_metamorphosis)
	SpellAddBuff(soul_fire fel_molten_core_buff=-1,target_health_pct,!25 if_spell=the_codex_of_xerrath)
	SpellAddBuff(soul_fire molten_core_buff=-1,target_health_pct,!25 if_spell=!the_codex_of_xerrath)
Define(soul_fire_metamorphosis 104027)
	SpellInfo(soul_fire_metamorphosis demonicfury=160)
	SpellInfo(soul_fire_metamorphosis buff_demonicfury_less50=soul_fire_metamorphosis_less50_buff)
	SpellInfo(soul_fire_metamorphosis ususable=1 if_stance=!warlock_metamorphosis)
	SpellAddBuff(soul_fire_metamorphosis fel_molten_core_buff=-1,target_health_pct,!25 if_spell=the_codex_of_xerrath)
	SpellAddBuff(soul_fire_metamorphosis molten_core_buff=-1,target_health_pct,!25 if_spell=!the_codex_of_xerrath)
SpellList(soul_fire_metamorphosis_less50_buff fel_molten_core_buff molten_core_buff)
Define(soulburn 74434)
	SpellInfo(soulburn cd=1 gcd=0 shards=1)
	SpellAddBuff(soulburn soulburn_buff=1)
Define(soulburn_buff 74434)
	SpellInfo(soulburn_buff duration=30)
Define(soulburn_haunt_talent 19)
Define(summon_doomguard 18540)
	SpellInfo(summon_doomguard cd=600)
Define(summon_felguard 30146)
Define(summon_felhunter 691)
Define(summon_imp 688)
Define(summon_infernal 1122)
	SpellInfo(summon_infernal cd=600)
Define(summon_succubus 712)
Define(summon_voidwalker 697)
Define(the_codex_of_xerrath 101508)
Define(touch_of_chaos 103964)
	SpellInfo(touch_of_chaos demonicfury=40 stance=warlock_metamorphosis)
Define(unstable_affliction 30108)
	SpellAddTargetDebuff(unstable_affliction unstable_affliction_debuff=1)
Define(unstable_affliction_debuff 30108)
	SpellInfo(unstable_affliction_debuff duration=14 haste=spell tick=2)
Define(wrathguard_wrathstorm 115831)
	SpellInfo(wrathguard_wrathstorm cd=45 gcd=0)
]]

	OvaleScripts:RegisterScript("WARLOCK", name, desc, code, "include")
end
