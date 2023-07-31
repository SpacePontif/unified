/// @addtogroup cormyrdalelands CormyrDalelands
/// @brief Cormyr and the Dalelands NWNX plugin
/// @{
/// @file nwnx_cormyrdales.nss
#include "nwnx"

const string NWNX_CormyrDalelands = "NWNX_CormyrDalelands"; ///< @private

/// @brief Gets whether a creature is incorporeal for use with ghost touch weapons.
/// @param oCreature The creature.
/// @return Whether a creature is incorporeal.
int NWNX_CormyrDalelands_GetCreatureIncorporealFlag(object oCreature);

/// @brief Sets a creature as incorporeal for use with ghost touch weapons.
/// @param oCreature The creature.
/// @param bIsIncorporeal Whether the creature is incorporeal.
void NWNX_CormyrDalelands_SetCreatureIncorporealFlag(object oCreature, int bIsIncorporeal);

/// @brief Sets a class as Uncanny Dodge II class for sneak/death attacks.
/// @param nClassID The class.
/// @param bIsUncannyDodgeClass Whether the class is considered an uncanny dodge class or not.
void NWNX_CormyrDalelands_SetClassIsSneakAttackUncannyDodgeClass(int nClassID, int bIsUncannyDodgeClass = TRUE);

/// @brief Set a feat as sneak attack feat that individually adds 1d6 sneak attack damage.
/// @param nFeat The feat.
/// @param bIsSneakAttackFeat Whether the feat is considered a sneak attack or not.
void NWNX_CormyrDalelands_SetFeatIsSneakAttackFeat(int nFeat, int bIsSneakAttackFeat = TRUE);

/// @brief Set a feat as death attack feat that individually adds 1d6 death attack damage.
/// @param nFeat The feat.
/// @param bIsDeathAttackFeat Whether the feat is considered a death attack or not.
void NWNX_CormyrDalelands_SetFeatIsDeathAttackFeat(int nFeat, int bIsDeathAttackFeat = TRUE);

/// @brief Sets a feat to modify creature's natural base AC by nModifier amount.
/// @param nFeatID The feat.
/// @param nModifier AC modifier.
void NWNX_CormyrDalelands_SetNaturalBaseACModifierFeat(int nFeatID, int nModifier);

/// @brief Sets a class to add its class levels to bard song's uses per day.
/// @param nClassID The class.
void NWNX_CormyrDalelands_SetClassProgressesBardSongUses(int nClassID, int bProgressesUses = TRUE);

/// @brief Retrieves a ruleset.2da entry.
/// @param sEntry The ruleset entry name.
/// @param fDefault Default value to return if sEntry is missing.
/// @return sEntry's value or fDefault.
float NWNX_CormyrDalelands_GetRulesetFloatEntry(string sEntry, float fDefault);

/// @brief Retrieves a ruleset.2da entry.
/// @param sEntry The ruleset entry name.
/// @param nDefault Default value to return if sEntry is missing.
/// @return sEntry's value or nDefault.
int NWNX_CormyrDalelands_GetRulesetIntEntry(string sEntry, int nDefault);

/// @brief Retrieves a ruleset.2da entry.
/// @param sEntry The ruleset entry name.
/// @param sDefault Default value to return if sEntry is missing.
/// @return sEntry's value or sDefault.
string NWNX_CormyrDalelands_GetRulesetStringEntry(string sEntry, string sDefault);

/// @brief Updates oCreature's combat information.
/// @param oCreature The creature whose's combat information to update.
void NWNX_CormyrDalelands_UpdateCombatInformation(object oCreature);

/// @brief Updates oCreature's age.
/// @param oCreature The creature whose age to edit.
/// @param nAge The new age to set.
void NWNX_CormyrDalelands_SetCreatureAge(object oCreature, int nAge);

/// @}

int NWNX_CormyrDalelands_GetCreatureIncorporealFlag(object oCreature)
{
    string sFunc = "GetCreatureIncorporealFlag";

    NWNX_PushArgumentObject(oCreature);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);

    return NWNX_GetReturnValueInt();
}

void NWNX_CormyrDalelands_SetCreatureIncorporealFlag(object oCreature, int bIsIncorporeal)
{
    string sFunc = "SetCreatureIncorporealFlag";

    NWNX_PushArgumentInt(bIsIncorporeal);
    NWNX_PushArgumentObject(oCreature);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetClassIsSneakAttackUncannyDodgeClass(int nClassID, int bIsUncannyDodgeClass = TRUE)
{
    string sFunc = "SetClassIsSneakAttackUncannyDodgeClass";
    
    NWNX_PushArgumentInt(bIsUncannyDodgeClass);
    NWNX_PushArgumentInt(nClassID);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetFeatIsSneakAttackFeat(int nFeat, int bIsSneakAttackFeat = TRUE)
{
    string sFunc = "SetFeatIsSneakAttackFeat";
    
    NWNX_PushArgumentInt(bIsSneakAttackFeat);
    NWNX_PushArgumentInt(nFeat);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetFeatIsDeathAttackFeat(int nFeat, int bIsDeathAttackFeat = TRUE)
{
    string sFunc = "SetFeatIsDeathAttackFeat";
    
    NWNX_PushArgumentInt(bIsDeathAttackFeat);
    NWNX_PushArgumentInt(nFeat);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetNaturalBaseACModifierFeat(int nFeatID, int nModifier)
{
    string sFunc = "SetNaturalBaseACModifierFeat";
    
    NWNX_PushArgumentInt(nModifier);
    NWNX_PushArgumentInt(nFeatID);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetClassProgressesBardSongUses(int nClassID, int bProgressesUses = TRUE)
{
    string sFunc = "SetClassProgressesBardSongUses";
    
    NWNX_PushArgumentInt(bProgressesUses);
    NWNX_PushArgumentInt(nClassID);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

float NWNX_CormyrDalelands_GetRulesetFloatEntry(string sEntry, float fDefault)
{
    string sFunc = "GetRulesetFloatEntry";

    NWNX_PushArgumentFloat(fDefault);
    NWNX_PushArgumentString(sEntry);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);

    return NWNX_GetReturnValueFloat();
}

int NWNX_CormyrDalelands_GetRulesetIntEntry(string sEntry, int nDefault)
{
    string sFunc = "GetRulesetIntEntry";

    NWNX_PushArgumentInt(nDefault);
    NWNX_PushArgumentString(sEntry);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);

    return NWNX_GetReturnValueInt();
}

string NWNX_CormyrDalelands_GetRulesetStringEntry(string sEntry, string sDefault)
{
    string sFunc = "GetRulesetStringEntry";

    NWNX_PushArgumentString(sDefault);
    NWNX_PushArgumentString(sEntry);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);

    return NWNX_GetReturnValueString();
}

void NWNX_CormyrDalelands_UpdateCombatInformation(object oCreature)
{
    string sFunc = "UpdateCombatInformation";
    
    NWNX_PushArgumentObject(oCreature);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}

void NWNX_CormyrDalelands_SetCreatureAge(object oCreature, int nAge)
{
    string sFunc = "SetCreatureAge";
    
    NWNX_PushArgumentInt(nAge);
    NWNX_PushArgumentObject(oCreature);
    NWNX_CallFunction(NWNX_CormyrDalelands, sFunc);
}
