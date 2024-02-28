#include "Events.hpp"
#include "API/CNWSCreature.hpp"
#include "API/CNWSCreatureStats.hpp"
#include "API/CNWSEffectListHandler.hpp"
#include "API/CNWRules.hpp"
#include "API/CNWSpellArray.hpp"
#include "API/CNWCCMessageData.hpp"
#include "API/CNWSCombatRound.hpp"

namespace Events {

using namespace NWNXLib;
using namespace NWNXLib::API;


struct SpellCastAction
{
    OBJECT_ID oidCaster;
    uint32_t nSpellId;
    uint8_t nMultiClass;
    uint32_t nDomainLevel;
    uint32_t nMetaMagic;
    BOOL bSpontaneous;
    BOOL bDefensiveCast;
    OBJECT_ID oidTarget;
    float fTargetX;
    float fTargetY;
    float fTargetZ;
    BOOL bInstant;
    uint32_t nProjectilePathType;
    uint32_t nFeat;
    uint8_t nCasterLevel;
    BOOL bFake;
};

static SpellCastAction s_LastSpellAction;

static Hooks::Hook s_AIActionCastSpellHook;
static Hooks::Hook s_StartCombatRoundCastHook;

static uint32_t AIActionCastSpellHook(CNWSCreature*, CNWSObjectActionNode*);
static void StartCombatRoundCastHook(CNWSCombatRound*, uint32_t);

void CormyrDalelandsEvents() __attribute__((constructor));
void CormyrDalelandsEvents()
{
    InitOnFirstSubscribe("CDX_ON_SPELL_BEGIN_CAST_.*", []() {
        s_AIActionCastSpellHook = Hooks::HookFunction(&CNWSCreature::AIActionCastSpell, &AIActionCastSpellHook, Hooks::Order::Earliest);
        s_StartCombatRoundCastHook = Hooks::HookFunction(&CNWSCombatRound::StartCombatRoundCast, &StartCombatRoundCastHook, Hooks::Order::Early);
    });
}

uint32_t AIActionCastSpellHook(CNWSCreature* thisPtr, CNWSObjectActionNode* pNode)
{
    s_LastSpellAction.oidCaster = thisPtr->m_idSelf;
    s_LastSpellAction.nSpellId = pNode->m_pParameter[0];
    s_LastSpellAction.nMultiClass = pNode->m_pParameter[1] & 0xFF;
    s_LastSpellAction.nDomainLevel = pNode->m_pParameter[2];
    s_LastSpellAction.nMetaMagic = pNode->m_pParameter[3];
    s_LastSpellAction.bSpontaneous = pNode->m_pParameter[4] != 0;
    s_LastSpellAction.bDefensiveCast = (pNode->m_pParameter[1] & 0x0000FF00) >> 8;
    s_LastSpellAction.oidTarget = pNode->m_pParameter[5];
    s_LastSpellAction.fTargetX = *((float*)&pNode->m_pParameter[6]);
    s_LastSpellAction.fTargetY = *((float*)&pNode->m_pParameter[7]);
    s_LastSpellAction.fTargetZ = *((float*)&pNode->m_pParameter[8]);
    s_LastSpellAction.bInstant = (pNode->m_pParameter[9] & 0x40000000) != 0;
    s_LastSpellAction.nProjectilePathType = pNode->m_pParameter[9] & 0x3FFFFFFF;
    s_LastSpellAction.nFeat = pNode->m_pParameter[10];
    s_LastSpellAction.nCasterLevel = pNode->m_pParameter[11] & 0x000000FF;
    s_LastSpellAction.bFake = (pNode->m_pParameter[9] & 0x80000000) != 0;

    return s_AIActionCastSpellHook->CallOriginal<uint32_t>(thisPtr, pNode);
}

void StartCombatRoundCastHook(CNWSCombatRound *pThis, uint32_t nRoundLength = 6000)
{
    if (pThis->m_pBaseCreature->m_idSelf != s_LastSpellAction.oidCaster)
        return s_StartCombatRoundCastHook->CallOriginal<void>(pThis, nRoundLength);

    auto PushAndSignal = [&](const std::string& ev) -> bool {
        PushEventData("SPELL_ID", std::to_string(s_LastSpellAction.nSpellId));

        PushEventData("TARGET_POSITION_X", std::to_string(s_LastSpellAction.fTargetX));
        PushEventData("TARGET_POSITION_Y", std::to_string(s_LastSpellAction.fTargetY));
        PushEventData("TARGET_POSITION_Z", std::to_string(s_LastSpellAction.fTargetZ));

        PushEventData("TARGET_OBJECT_ID", Utils::ObjectIDToString(s_LastSpellAction.oidTarget));
        PushEventData("MULTI_CLASS", std::to_string(s_LastSpellAction.nMultiClass));
        PushEventData("PROJECTILE_PATH_TYPE", std::to_string(s_LastSpellAction.nProjectilePathType));
        PushEventData("IS_INSTANT_SPELL", std::to_string(s_LastSpellAction.bInstant));

        PushEventData("FEAT", std::to_string(s_LastSpellAction.nFeat));
        PushEventData("CASTER_LEVEL", std::to_string(s_LastSpellAction.nCasterLevel));
        PushEventData("IS_FAKE", std::to_string(s_LastSpellAction.bFake));
        PushEventData("METAMAGIC", std::to_string(s_LastSpellAction.nMetaMagic));
        PushEventData("DOMAIN", std::to_string(s_LastSpellAction.nDomainLevel));
        PushEventData("IS_SPONTANEOUS", std::to_string(s_LastSpellAction.bSpontaneous));
        PushEventData("IS_DEFENSIVE_CAST", std::to_string(s_LastSpellAction.bDefensiveCast));

        return SignalEvent(ev, pThis->m_pBaseCreature->m_idSelf);
    };

    PushAndSignal("CDX_ON_SPELL_BEGIN_CAST_BEFORE");

    return s_StartCombatRoundCastHook->CallOriginal<void>(pThis, nRoundLength);

    PushAndSignal("CDX_ON_SPELL_BEGIN_CAST_AFTER");
}

}
