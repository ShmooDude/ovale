local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "icyveins_monk_brewmaster"
	local desc = "[7.0] Icy-Veins: Monk Brewmaster"
	local code = [[

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_monk_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=brewmaster)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=brewmaster)
AddCheckBox(opt_legendary_ring_tank ItemName(legendary_ring_bonus_armor) default specialization=brewmaster)
AddCheckBox(opt_monk_bm_aoe L(AOE) default specialization=brewmaster)

AddFunction BrewmasterDefaultShortCDActions
{
	if StaggerRemaining() / MaxHealth() >0.4 Spell(purifying_brew)
	if CheckBoxOn(opt_melee_range) and not target.InRange(tiger_palm) Texture(misc_arrowlup help=L(not_in_melee_range))
	if not BuffPresent(ironskin_brew_buff) Spell(ironskin_brew)
}

AddFunction BrewmasterDefaultMainActions
{
	Spell(keg_smash)
	if Energy() >= 65 Spell(tiger_palm)
	Spell(blackout_strike)
	Spell(rushing_jade_wind)
	if target.DebuffPresent(keg_smash_debuff) Spell(breath_of_fire)
	Spell(exploding_keg)
}

AddFunction BrewmasterDefaultAoEActions
{
	Spell(exploding_keg)
	Spell(keg_smash)
	Spell(chi_burst)
	if target.DebuffPresent(keg_smash_debuff) Spell(breath_of_fire)
	Spell(rushing_jade_wind)
	if Energy() >= 65 Spell(tiger_palm)
	Spell(blackout_strike)
}

AddFunction BrewmasterDefaultCdActions 
{
	BrewmasterInterruptActions()
	if CheckBoxOn(opt_legendary_ring_tank) Item(legendary_ring_bonus_armor usable=1)
	Spell(fortifying_brew)
	Spell(zen_meditation)
	Spell(dampen_harm)
	Spell(diffuse_magic)
}

AddFunction BrewmasterInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(spear_hand_strike) Spell(spear_hand_strike)
		if not target.Classification(worldboss)
		{
			Spell(arcane_torrent_chi)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			Spell(war_stomp)
			Spell(leg_sweep)
			Spell(diffuse_magic)
		}
	}
}

AddIcon help=shortcd specialization=brewmaster
{
	BrewmasterDefaultShortCDActions()
}

AddIcon enemies=1 help=main specialization=brewmaster
{
	BrewmasterDefaultMainActions()
}

AddIcon checkbox=opt_monk_bm_aoe help=aoe specialization=brewmaster
{
	BrewmasterDefaultAoEActions()
}

AddIcon help=cd specialization=brewmaster
{
	BrewmasterDefaultCdActions()
}
	
]]
	OvaleScripts:RegisterScript("MONK", "brewmaster", name, desc, code, "script")
end
-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- ANY CHANGES MADE BELOW THIS POINT WILL BE LOST.

do
	local name = "simulationcraft_monk_windwalker_t19p"
	local desc = "[7.0] SimulationCraft: Monk_Windwalker_T19P"
	local code = [[
# Based on SimulationCraft profile "Monk_Windwalker_T19P".
#	class=monk
#	spec=windwalker
#	talents=3010033

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_monk_spells)

AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=windwalker)
AddCheckBox(opt_chi_burst SpellName(chi_burst) default specialization=windwalker)
AddCheckBox(opt_storm_earth_and_fire SpellName(storm_earth_and_fire) specialization=windwalker)

AddFunction WindwalkerGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(tiger_palm) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction WindwalkerDefaultMainActions
{
	#call_action_list,name=opener,if=time<15
	if TimeInCombat() < 15 WindwalkerOpenerMainActions()

	unless TimeInCombat() < 15 and WindwalkerOpenerMainPostConditions()
	{
		#storm_earth_and_fire,if=artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<13&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
		if BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 13 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } Spell(storm_earth_and_fire)
		#storm_earth_and_fire,if=!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
		if not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } Spell(storm_earth_and_fire)
		#call_action_list,name=serenity,if=buff.serenity.up
		if BuffPresent(serenity_buff) WindwalkerSerenityMainActions()

		unless BuffPresent(serenity_buff) and WindwalkerSerenityMainPostConditions()
		{
			#fists_of_fury
			Spell(fists_of_fury)
			#rising_sun_kick,cycle_targets=1
			Spell(rising_sun_kick)
			#whirling_dragon_punch
			if SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 Spell(whirling_dragon_punch)
			#call_action_list,name=st,if=active_enemies<3
			if Enemies() < 3 WindwalkerStMainActions()

			unless Enemies() < 3 and WindwalkerStMainPostConditions()
			{
				#call_action_list,name=aoe,if=active_enemies>=3
				if Enemies() >= 3 WindwalkerAoeMainActions()
			}
		}
	}
}

AddFunction WindwalkerDefaultMainPostConditions
{
	TimeInCombat() < 15 and WindwalkerOpenerMainPostConditions() or BuffPresent(serenity_buff) and WindwalkerSerenityMainPostConditions() or Enemies() < 3 and WindwalkerStMainPostConditions() or Enemies() >= 3 and WindwalkerAoeMainPostConditions()
}

AddFunction WindwalkerDefaultShortCdActions
{
	#auto_attack
	WindwalkerGetInMeleeRange()
	#call_action_list,name=opener,if=time<15
	if TimeInCombat() < 15 WindwalkerOpenerShortCdActions()

	unless TimeInCombat() < 15 and WindwalkerOpenerShortCdPostConditions()
	{
		#potion,name=deadly_grace,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
		#serenity,if=artifact.gale_burst.enabled&cooldown.touch_of_death.ready&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
		if BuffPresent(gale_burst_buff) and SpellCooldownDuration(touch_of_death) and SpellCooldown(strike_of_the_windlord) < 14 and SpellCooldown(fists_of_fury) <= 15 and SpellCooldown(rising_sun_kick) < 7 Spell(serenity)

		unless BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 13 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire)
		{
			#serenity,if=artifact.strike_of_the_windlord.enabled&!artifact.gale_burst.enabled&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
			if BuffPresent(strike_of_the_windlord_buff) and not BuffPresent(gale_burst_buff) and SpellCooldown(strike_of_the_windlord) < 14 and SpellCooldown(fists_of_fury) <= 15 and SpellCooldown(rising_sun_kick) < 7 Spell(serenity)
			#serenity,if=!artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.remains<14&cooldown.fists_of_fury.remains<=15&cooldown.rising_sun_kick.remains<7
			if not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 14 and SpellCooldown(fists_of_fury) <= 15 and SpellCooldown(rising_sun_kick) < 7 Spell(serenity)
			#call_action_list,name=serenity,if=buff.serenity.up
			if BuffPresent(serenity_buff) WindwalkerSerenityShortCdActions()

			unless BuffPresent(serenity_buff) and WindwalkerSerenityShortCdPostConditions()
			{
				#energizing_elixir,if=energy<energy.max&chi<=1&buff.serenity.down
				if Energy() < MaxEnergy() and Chi() <= 1 and BuffExpires(serenity_buff) Spell(energizing_elixir)
				#strike_of_the_windlord
				Spell(strike_of_the_windlord)

				unless Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch)
				{
					#call_action_list,name=st,if=active_enemies<3
					if Enemies() < 3 WindwalkerStShortCdActions()

					unless Enemies() < 3 and WindwalkerStShortCdPostConditions()
					{
						#call_action_list,name=aoe,if=active_enemies>=3
						if Enemies() >= 3 WindwalkerAoeShortCdActions()
					}
				}
			}
		}
	}
}

AddFunction WindwalkerDefaultShortCdPostConditions
{
	TimeInCombat() < 15 and WindwalkerOpenerShortCdPostConditions() or BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 13 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and WindwalkerSerenityShortCdPostConditions() or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or Enemies() < 3 and WindwalkerStShortCdPostConditions() or Enemies() >= 3 and WindwalkerAoeShortCdPostConditions()
}

AddFunction WindwalkerDefaultCdActions
{
	#invoke_xuen
	Spell(invoke_xuen)
	#call_action_list,name=opener,if=time<15
	if TimeInCombat() < 15 WindwalkerOpenerCdActions()

	unless TimeInCombat() < 15 and WindwalkerOpenerCdPostConditions()
	{
		#touch_of_death,if=!artifact.gale_burst.enabled
		if not BuffPresent(gale_burst_buff) Spell(touch_of_death)
		#touch_of_death,if=artifact.gale_burst.enabled&cooldown.strike_of_the_windlord.remains<8&cooldown.fists_of_fury.remains<=4&cooldown.rising_sun_kick.remains<7
		if BuffPresent(gale_burst_buff) and SpellCooldown(strike_of_the_windlord) < 8 and SpellCooldown(fists_of_fury) <= 4 and SpellCooldown(rising_sun_kick) < 7 Spell(touch_of_death)
		#blood_fury
		Spell(blood_fury_apsp)
		#berserking
		Spell(berserking)
		#arcane_torrent,if=chi.max-chi>=1
		if MaxChi() - Chi() >= 1 Spell(arcane_torrent_chi)

		unless BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 13 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire)
		{
			#call_action_list,name=serenity,if=buff.serenity.up
			if BuffPresent(serenity_buff) WindwalkerSerenityCdActions()

			unless BuffPresent(serenity_buff) and WindwalkerSerenityCdPostConditions() or Spell(strike_of_the_windlord) or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch)
			{
				#call_action_list,name=st,if=active_enemies<3
				if Enemies() < 3 WindwalkerStCdActions()

				unless Enemies() < 3 and WindwalkerStCdPostConditions()
				{
					#call_action_list,name=aoe,if=active_enemies>=3
					if Enemies() >= 3 WindwalkerAoeCdActions()
				}
			}
		}
	}
}

AddFunction WindwalkerDefaultCdPostConditions
{
	TimeInCombat() < 15 and WindwalkerOpenerCdPostConditions() or BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(strike_of_the_windlord) < 13 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and WindwalkerSerenityCdPostConditions() or Spell(strike_of_the_windlord) or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or Enemies() < 3 and WindwalkerStCdPostConditions() or Enemies() >= 3 and WindwalkerAoeCdPostConditions()
}

### actions.aoe

AddFunction WindwalkerAoeMainActions
{
	#spinning_crane_kick,if=!prev_gcd.spinning_crane_kick
	if not PreviousGCDSpell(spinning_crane_kick) Spell(spinning_crane_kick)
	#rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
	if Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#blackout_kick,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick,cycle_targets=1
	if { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) Spell(blackout_kick)
	#chi_wave,if=energy.time_to_max>2
	if TimeToMaxEnergy() > 2 Spell(chi_wave)
	#tiger_palm,if=chi.max-chi>1&!prev_gcd.tiger_palm,cycle_targets=1
	if MaxChi() - Chi() > 1 and not PreviousGCDSpell(tiger_palm) Spell(tiger_palm)
}

AddFunction WindwalkerAoeMainPostConditions
{
}

AddFunction WindwalkerAoeShortCdActions
{
	unless not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave)
	{
		#chi_burst,if=energy.time_to_max>2
		if TimeToMaxEnergy() > 2 and CheckBoxOn(opt_chi_burst) Spell(chi_burst)
	}
}

AddFunction WindwalkerAoeShortCdPostConditions
{
	not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave) or MaxChi() - Chi() > 1 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

AddFunction WindwalkerAoeCdActions
{
}

AddFunction WindwalkerAoeCdPostConditions
{
	not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave) or TimeToMaxEnergy() > 2 and CheckBoxOn(opt_chi_burst) and Spell(chi_burst) or MaxChi() - Chi() > 1 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

### actions.opener

AddFunction WindwalkerOpenerMainActions
{
	#storm_earth_and_fire
	if CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } Spell(storm_earth_and_fire)
	#rising_sun_kick,cycle_targets=1,if=buff.serenity.up
	if BuffPresent(serenity_buff) Spell(rising_sun_kick)
	#fists_of_fury
	Spell(fists_of_fury)
	#rising_sun_kick,cycle_targets=1
	Spell(rising_sun_kick)
	#whirling_dragon_punch
	if SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 Spell(whirling_dragon_punch)
	#spinning_crane_kick,if=buff.serenity.up&!prev_gcd.spinning_crane_kick
	if BuffPresent(serenity_buff) and not PreviousGCDSpell(spinning_crane_kick) Spell(spinning_crane_kick)
	#rushing_jade_wind,if=(buff.serenity.up|chi>1)&cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
	if { BuffPresent(serenity_buff) or Chi() > 1 } and SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#blackout_kick,cycle_targets=1,if=chi>1&!prev_gcd.blackout_kick
	if Chi() > 1 and not PreviousGCDSpell(blackout_kick) Spell(blackout_kick)
	#chi_wave
	Spell(chi_wave)
	#tiger_palm,cycle_targets=1,if=chi.max-chi>=2&!prev_gcd.tiger_palm
	if MaxChi() - Chi() >= 2 and not PreviousGCDSpell(tiger_palm) Spell(tiger_palm)
}

AddFunction WindwalkerOpenerMainPostConditions
{
}

AddFunction WindwalkerOpenerShortCdActions
{
	#energizing_elixir
	Spell(energizing_elixir)
	#serenity
	Spell(serenity)

	unless CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and Spell(rising_sun_kick)
	{
		#strike_of_the_windlord
		Spell(strike_of_the_windlord)

		unless Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or BuffPresent(serenity_buff) and not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or { BuffPresent(serenity_buff) or Chi() > 1 } and SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or Chi() > 1 and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or Spell(chi_wave)
		{
			#chi_burst
			if CheckBoxOn(opt_chi_burst) Spell(chi_burst)
		}
	}
}

AddFunction WindwalkerOpenerShortCdPostConditions
{
	CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and Spell(rising_sun_kick) or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or BuffPresent(serenity_buff) and not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or { BuffPresent(serenity_buff) or Chi() > 1 } and SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or Chi() > 1 and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or Spell(chi_wave) or MaxChi() - Chi() >= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

AddFunction WindwalkerOpenerCdActions
{
	#blood_fury
	Spell(blood_fury_apsp)
	#berserking
	Spell(berserking)
	#touch_of_death
	Spell(touch_of_death)

	unless CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and Spell(rising_sun_kick) or Spell(strike_of_the_windlord) or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or BuffPresent(serenity_buff) and not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or { BuffPresent(serenity_buff) or Chi() > 1 } and SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or Chi() > 1 and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or Spell(chi_wave) or CheckBoxOn(opt_chi_burst) and Spell(chi_burst) or MaxChi() - Chi() >= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
	{
		#arcane_torrent,if=chi.max-chi>=1
		if MaxChi() - Chi() >= 1 Spell(arcane_torrent_chi)
	}
}

AddFunction WindwalkerOpenerCdPostConditions
{
	CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or BuffPresent(serenity_buff) and Spell(rising_sun_kick) or Spell(strike_of_the_windlord) or Spell(fists_of_fury) or Spell(rising_sun_kick) or SpellCooldown(fists_of_fury) > 0 and SpellCooldown(rising_sun_kick) > 0 and Spell(whirling_dragon_punch) or BuffPresent(serenity_buff) and not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or { BuffPresent(serenity_buff) or Chi() > 1 } and SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or Chi() > 1 and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or Spell(chi_wave) or CheckBoxOn(opt_chi_burst) and Spell(chi_burst) or MaxChi() - Chi() >= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

### actions.precombat

AddFunction WindwalkerPrecombatMainActions
{
	#flask,type=flask_of_the_seventh_demon
	#food,type=nightborne_delicacy_platter
	#augmentation,type=defiled
	Spell(augmentation)
}

AddFunction WindwalkerPrecombatMainPostConditions
{
}

AddFunction WindwalkerPrecombatShortCdActions
{
}

AddFunction WindwalkerPrecombatShortCdPostConditions
{
	Spell(augmentation)
}

AddFunction WindwalkerPrecombatCdActions
{
}

AddFunction WindwalkerPrecombatCdPostConditions
{
	Spell(augmentation)
}

### actions.serenity

AddFunction WindwalkerSerenityMainActions
{
	#rising_sun_kick,cycle_targets=1
	Spell(rising_sun_kick)
	#fists_of_fury
	Spell(fists_of_fury)
	#spinning_crane_kick,if=!prev_gcd.spinning_crane_kick
	if not PreviousGCDSpell(spinning_crane_kick) Spell(spinning_crane_kick)
	#rushing_jade_wind,if=cooldown.rising_sun_kick.remains>1&!prev_gcd.rushing_jade_wind
	if SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
}

AddFunction WindwalkerSerenityMainPostConditions
{
}

AddFunction WindwalkerSerenityShortCdActions
{
	#strike_of_the_windlord
	Spell(strike_of_the_windlord)
}

AddFunction WindwalkerSerenityShortCdPostConditions
{
	Spell(rising_sun_kick) or Spell(fists_of_fury) or not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind)
}

AddFunction WindwalkerSerenityCdActions
{
}

AddFunction WindwalkerSerenityCdPostConditions
{
	Spell(strike_of_the_windlord) or Spell(rising_sun_kick) or Spell(fists_of_fury) or not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick) or SpellCooldown(rising_sun_kick) > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind)
}

### actions.st

AddFunction WindwalkerStMainActions
{
	#rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
	if Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#blackout_kick,if=(chi>1|buff.bok_proc.up)&!prev_gcd.blackout_kick
	if { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) Spell(blackout_kick)
	#chi_wave,if=energy.time_to_max>2
	if TimeToMaxEnergy() > 2 Spell(chi_wave)
	#tiger_palm,if=chi<=2&!prev_gcd.tiger_palm
	if Chi() <= 2 and not PreviousGCDSpell(tiger_palm) Spell(tiger_palm)
}

AddFunction WindwalkerStMainPostConditions
{
}

AddFunction WindwalkerStShortCdActions
{
	unless Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave)
	{
		#chi_burst,if=energy.time_to_max>2
		if TimeToMaxEnergy() > 2 and CheckBoxOn(opt_chi_burst) Spell(chi_burst)
	}
}

AddFunction WindwalkerStShortCdPostConditions
{
	Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave) or Chi() <= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

AddFunction WindwalkerStCdActions
{
}

AddFunction WindwalkerStCdPostConditions
{
	Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or TimeToMaxEnergy() > 2 and Spell(chi_wave) or TimeToMaxEnergy() > 2 and CheckBoxOn(opt_chi_burst) and Spell(chi_burst) or Chi() <= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

### Windwalker icons.

AddCheckBox(opt_monk_windwalker_aoe L(AOE) default specialization=windwalker)

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=shortcd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatShortCdActions()
	unless not InCombat() and WindwalkerPrecombatShortCdPostConditions()
	{
		WindwalkerDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_monk_windwalker_aoe help=shortcd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatShortCdActions()
	unless not InCombat() and WindwalkerPrecombatShortCdPostConditions()
	{
		WindwalkerDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatMainActions()
	unless not InCombat() and WindwalkerPrecombatMainPostConditions()
	{
		WindwalkerDefaultMainActions()
	}
}

AddIcon checkbox=opt_monk_windwalker_aoe help=aoe specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatMainActions()
	unless not InCombat() and WindwalkerPrecombatMainPostConditions()
	{
		WindwalkerDefaultMainActions()
	}
}

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=cd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatCdActions()
	unless not InCombat() and WindwalkerPrecombatCdPostConditions()
	{
		WindwalkerDefaultCdActions()
	}
}

AddIcon checkbox=opt_monk_windwalker_aoe help=cd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatCdActions()
	unless not InCombat() and WindwalkerPrecombatCdPostConditions()
	{
		WindwalkerDefaultCdActions()
	}
}

### Required symbols
# arcane_torrent_chi
# augmentation
# berserking
# blackout_kick
# blood_fury_apsp
# bok_proc_buff
# chi_burst
# chi_wave
# energizing_elixir
# fists_of_fury
# gale_burst
# invoke_xuen
# rising_sun_kick
# rushing_jade_wind
# serenity
# serenity_buff
# spinning_crane_kick
# storm_earth_and_fire
# strike_of_the_windlord
# tiger_palm
# touch_of_death
# whirling_dragon_punch
]]
	OvaleScripts:RegisterScript("MONK", "windwalker", name, desc, code, "script")
end
