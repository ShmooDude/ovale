import { L } from "./Localization";
import { OvaleDebug } from "./Debug";
import { OvaleProfiler } from "./Profiler";
import { Ovale } from "./Ovale";
import { RegisterRequirement, UnregisterRequirement } from "./Requirement";
import aceEvent from "@wowts/ace_event-3.0";
import { pairs, tonumber, type, wipe, LuaObj } from "@wowts/lua";
import { sub } from "@wowts/string";
import { concat, insert, sort } from "@wowts/table";
import { GetNumShapeshiftForms, GetShapeshiftForm, GetShapeshiftFormInfo, GetSpellInfo } from "@wowts/wow-mock";

let OvaleStanceBase = OvaleDebug.RegisterDebugging(OvaleProfiler.RegisterProfiling(Ovale.NewModule("OvaleStance", aceEvent)));
export let OvaleStance: OvaleStanceClass;

const [druidCatForm] = GetSpellInfo(768);
const [druidTravelForm] = GetSpellInfo(783);
const [druidAquaticForm] = GetSpellInfo(1066);
const [druidBearForm] = GetSpellInfo(5487);
const [druidMoonkinForm] =GetSpellInfo(24858);
const [druid_flight_form] = GetSpellInfo(33943);
const [druid_swift_flight_form] = GetSpellInfo(40120);
const [rogue_stealth] = GetSpellInfo(1784);

let SPELL_NAME_TO_STANCE = {
    [druidCatForm]: "druid_cat_form",
    [druidTravelForm]: "druid_travel_form",
    [druidAquaticForm]: "druid_aquatic_form",
    [druidBearForm]: "druid_bear_form",
    [druidMoonkinForm]: "druid_moonkin_form",
    [druid_flight_form]: "druid_flight_form",
    [druid_swift_flight_form]: "druid_swift_flight_form",
    [rogue_stealth]: "rogue_stealth"
}
let STANCE_NAME: LuaObj<boolean> = {
}
{
    for (const [, name] of pairs(SPELL_NAME_TO_STANCE)) {
        STANCE_NAME[name] = true;
    }
}
{
    let debugOptions = {
        stance: {
            name: L["Stances"],
            type: "group",
            args: {
                stance: {
                    name: L["Stances"],
                    type: "input",
                    multiline: 25,
                    width: "full",
                    get: function (info) {
                        return OvaleStance.DebugStances();
                    }
                }
            }
        }
    }
    for (const [k, v] of pairs(debugOptions)) {
        OvaleDebug.options.args[k] = v;
    }
}
let array = {
}

class OvaleStanceClass extends OvaleStanceBase {
    ready = false;
    stanceList = {
    }
    stanceId = {
    }
    stance = undefined;
    STANCE_NAME = STANCE_NAME;

    
    constructor() {
        super();
        this.RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateStances");
        this.RegisterEvent("UPDATE_SHAPESHIFT_FORM");
        this.RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
        this.RegisterMessage("Ovale_SpellsChanged", "UpdateStances");
        this.RegisterMessage("Ovale_TalentsChanged", "UpdateStances");
        RegisterRequirement("stance", "RequireStanceHandler", this);
    }
    OnDisable() {
        UnregisterRequirement("stance");
        this.UnregisterEvent("PLAYER_ALIVE");
        this.UnregisterEvent("PLAYER_ENTERING_WORLD");
        this.UnregisterEvent("UPDATE_SHAPESHIFT_FORM");
        this.UnregisterEvent("UPDATE_SHAPESHIFT_FORMS");
        this.UnregisterMessage("Ovale_SpellsChanged");
        this.UnregisterMessage("Ovale_TalentsChanged");
    }
    PLAYER_TALENT_UPDATE(event) {
        this.stance = undefined;
        this.UpdateStances();
    }
    UPDATE_SHAPESHIFT_FORM(event) {
        this.ShapeshiftEventHandler();
    }
    UPDATE_SHAPESHIFT_FORMS(event) {
        this.ShapeshiftEventHandler();
    }
    CreateStanceList() {
        this.StartProfiling("OvaleStance_CreateStanceList");
        wipe(this.stanceList);
        wipe(this.stanceId);
        let _, name, stanceName;
        for (let i = 1; i <= GetNumShapeshiftForms(); i += 1) {
            [_, name] = GetShapeshiftFormInfo(i);
            stanceName = SPELL_NAME_TO_STANCE[name];
            if (stanceName) {
                this.stanceList[i] = stanceName;
                this.stanceId[stanceName] = i;
            }
        }
        this.StopProfiling("OvaleStance_CreateStanceList");
    }
    DebugStances() {
        wipe(array);
        for (const [k, v] of pairs(this.stanceList)) {
            if (this.stance == k) {
                insert(array, `${v} (active)`);
            } else {
                insert(array, v);
            }
        }
        sort(array);
        return concat(array, "\n");
    }

    GetStance(stanceId) {
        stanceId = stanceId || this.stance;
        return this.stanceList[stanceId];
    }
    IsStance(name) {
        if (name && this.stance) {
            if (type(name) == "number") {
                return name == this.stance;
            } else {
                return name == OvaleStance.GetStance(this.stance);
            }
        }
        return false;
    }
    IsStanceSpell(spellId) {
        let [name] = GetSpellInfo(spellId);
        return !!(name && SPELL_NAME_TO_STANCE[name]);
    }
    ShapeshiftEventHandler() {
        this.StartProfiling("OvaleStance_ShapeshiftEventHandler");
        let oldStance = this.stance;
        let newStance = GetShapeshiftForm();
        if (oldStance != newStance) {
            this.stance = newStance;
            Ovale.needRefresh();
            this.SendMessage("Ovale_StanceChanged", this.GetStance(newStance), this.GetStance(oldStance));
        }
        this.StopProfiling("OvaleStance_ShapeshiftEventHandler");
    }
    UpdateStances() {
        this.CreateStanceList();
        this.ShapeshiftEventHandler();
        this.ready = true;
    }
    RequireStanceHandler(spellId, atTime, requirement, tokens, index, targetGUID) {
        let verified = false;
        let stance = tokens;
        if (index) {
            stance = tokens[index];
            index = index + 1;
        }
        if (stance) {
            let isBang = false;
            if (sub(stance, 1, 1) == "!") {
                isBang = true;
                stance = sub(stance, 2);
            }
            stance = tonumber(stance) || stance;
            let isStance = this.IsStance(stance);
            if (!isBang && isStance || isBang && !isStance) {
                verified = true;
            }
            let result = verified && "passed" || "FAILED";
            if (isBang) {
                this.Log("    Require NOT stance '%s': %s", stance, result);
            } else {
                this.Log("    Require stance '%s': %s", stance, result);
            }
        } else {
            Ovale.OneTimeMessage("Warning: requirement '%s' is missing a stance argument.", requirement);
        }
        return [verified, requirement, index];
    }
}

OvaleStance = new OvaleStanceClass();