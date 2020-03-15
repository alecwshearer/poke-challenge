#include "global.h"
#include "gflib.h"
#include "data.h"
#include "item.h"
#include "pokemon_storage_system_internal.h"
#include "pokemon_summary_screen.h"
#include "strings.h"
#include "constants/species.h"
#include "constants/moves.h"

EWRAM_DATA struct Pokemon gUnknown_20397BC = {};
EWRAM_DATA s8 sBoxCursorArea = 0;
EWRAM_DATA s8 sBoxCursorPosition = 0;
EWRAM_DATA bool8 sIsMonBeingMoved = FALSE;
EWRAM_DATA u8 sMovingMonOrigBoxId = 0;
EWRAM_DATA u8 sMovingMonOrigBoxPos = 0;
EWRAM_DATA bool8 sCanOnlyMove = FALSE;
EWRAM_DATA u8 gUnknown_2039826 = 0;

void sub_80929B0(void);
bool8 MonPlaceChange_Move(void);
bool8 MonPlaceChange_Place(void);
bool8 MonPlaceChange_Shift(void);
bool8 sub_8092E00(void);
bool8 sub_8092E10(void);
bool8 sub_8092E20(void);
bool8 sub_8092E54(void);
void MoveMon(void);
void PlaceMon(void);
void SetMovedMonData(u8 boxId, u8 cursorPos);
void SetPlacedMonData(u8 boxId, u8 cursorPos);
void PurgeMonOrBoxMon(u8 boxId, u8 cursorPos);
void SetShiftedMonData(u8 boxId, u8 cursorPos);
void sub_8093A10(void);
void SetCursorMonData(void * cursorMon, u8 mode);
void sub_8093AAC(void);
u8 InBoxInput_Normal(void);
u8 InBoxInput_GrabbingMultiple(void);
u8 InBoxInput_MovingMultiple(void);
void sub_8094AD8(void);
void sub_8095D44(u8 cursorArea, u8 cursorPos);
bool8 sub_8094924(void);
s8 sub_8094E50(u8 a0);
void sub_8094C84(void);

const u16 gUnknown_83D2BCC[] = INCBIN_U16("graphics/interface/pss_unk_83D2BCC.gbapal");
const u16 gUnknown_83D2BEC[] = INCBIN_U16("graphics/interface/pss_unk_83D2BEC.4bpp");
const u16 gUnknown_83D33EC[] = INCBIN_U16("graphics/interface/pss_unk_83D33EC.4bpp");

void sub_80922C0(void)
{
    if (sPSSData->boxOption != BOX_OPTION_DEPOSIT)
        sBoxCursorArea = CURSOR_AREA_IN_BOX;
    else
        sBoxCursorArea = CURSOR_AREA_IN_PARTY;

    sBoxCursorPosition = 0;
    sIsMonBeingMoved = FALSE;
    sMovingMonOrigBoxId = 0;
    sMovingMonOrigBoxPos = 0;
    sCanOnlyMove = FALSE;
    sub_8092B50();
    sub_8094AD8();
    sPSSData->field_CD6 = 1;
    sPSSData->inBoxMovingMode = 0;
    sub_8093A10();
}

void sub_8092340(void)
{
    sub_8094AD8();
    sub_8093AAC();
    sPSSData->field_CD6 = 1;
    sPSSData->inBoxMovingMode = 0;
    if (sIsMonBeingMoved)
    {
        sPSSData->movingMon = gUnknown_20397BC;
        CreateMovingMonIcon();
    }
}

void sub_8092398(u8 cursorArea, u8 cursorPosition, u16 *x, u16 *y)
{
    switch (cursorArea)
    {
    case CURSOR_AREA_IN_BOX:
        *x = (cursorPosition % IN_BOX_ROWS) * 24 + 100;
        *y = (cursorPosition / IN_BOX_ROWS) * 24 +  32;
        break;
    case CURSOR_AREA_IN_PARTY:
        if (cursorPosition == 0)
        {
            *x = 0x68;
            *y = 0x34;
        }
        else if (cursorPosition == PARTY_SIZE)
        {
            *x = 0x98;
            *y = 0x84;
        }
        else
        {
            *x = 0x98;
            *y = (cursorPosition - 1) * 24 + 4;
        }
        break;
    case CURSOR_AREA_BOX:
        *x = 0xa2;
        *y = 0x0c;
        break;
    case CURSOR_AREA_BUTTONS:
        *y = sIsMonBeingMoved ? 8 : 14;
        *x = cursorPosition * 0x58 + 0x78;
        break;
    case 4:
        *x = 0xa0;
        *y = 0x60;
        break;
    }
}

u16 sub_8092458(void)
{
    switch (sBoxCursorArea)
    {
    case CURSOR_AREA_IN_PARTY:
        return GetMonData(&gPlayerParty[sBoxCursorPosition], MON_DATA_SPECIES);
    case CURSOR_AREA_IN_BOX:
        return GetCurrentBoxMonData(sBoxCursorPosition, MON_DATA_SPECIES);
    default:
        return SPECIES_NONE;
    }
}

bool8 sub_80924A8(void)
{
    s16 tmp;

    if (sPSSData->field_CD0 == 0)
    {
        if (sPSSData->boxOption != BOX_OPTION_MOVE_ITEMS)
            return FALSE;
        else
            return sub_809610C();
    }
    else if (--sPSSData->field_CD0 != 0)
    {
        sPSSData->field_CBC += sPSSData->field_CC4;
        sPSSData->field_CC0 += sPSSData->field_CC8;
        sPSSData->field_CB4->pos1.x = sPSSData->field_CBC >> 8;
        sPSSData->field_CB4->pos1.y = sPSSData->field_CC0 >> 8;
        if (sPSSData->field_CB4->pos1.x > 0x100)
        {
            tmp = sPSSData->field_CB4->pos1.x - 0x100;
            sPSSData->field_CB4->pos1.x = tmp + 0x40;
        }
        if (sPSSData->field_CB4->pos1.x < 0x40)
        {
            tmp = 0x40 - sPSSData->field_CB4->pos1.x;
            sPSSData->field_CB4->pos1.x = 0x100 - tmp;
        }
        if (sPSSData->field_CB4->pos1.y > 0xb0)
        {
            tmp = sPSSData->field_CB4->pos1.y - 0xb0;
            sPSSData->field_CB4->pos1.y = tmp - 0x10;
        }
        if (sPSSData->field_CB4->pos1.y < -0x10)
        {
            tmp = -0x10 - sPSSData->field_CB4->pos1.y;
            sPSSData->field_CB4->pos1.y = 0xb0 - tmp;
        }
        if (sPSSData->field_CD7 && --sPSSData->field_CD7 == 0)
            sPSSData->field_CB4->vFlip = (sPSSData->field_CB4->vFlip == FALSE);
    }
    else
    {
        sPSSData->field_CB4->pos1.x = sPSSData->field_CCC;
        sPSSData->field_CB4->pos1.y = sPSSData->field_CCE;
        sub_80929B0();
    }

    return TRUE;
}

void sub_8092604(u8 newCurosrArea, u8 newCursorPosition)
{
    u16 x, y;

    sub_8092398(newCurosrArea, newCursorPosition, &x, &y);
    sPSSData->field_CD4 = newCurosrArea;
    sPSSData->field_CD5 = newCursorPosition;
    sPSSData->field_CCC = x;
    sPSSData->field_CCE = y;
}

void sub_8092660(void)
{
    int r7, r0;

    if (sPSSData->field_CD2 != 0 || sPSSData->field_CD3 != 0)
        sPSSData->field_CD0 = 12;
    else
        sPSSData->field_CD0 = 6;

    if (sPSSData->field_CD7)
        sPSSData->field_CD7 = sPSSData->field_CD0 >> 1;

    switch (sPSSData->field_CD2)
    {
    default:
        r7 = sPSSData->field_CCE - sPSSData->field_CB4->pos1.y;
        break;
    case -1:
        r7 = sPSSData->field_CCE - 0xc0 - sPSSData->field_CB4->pos1.y;
        break;
    case 1:
        r7 = sPSSData->field_CCE + 0xc0 - sPSSData->field_CB4->pos1.y;
        break;
    }

    switch (sPSSData->field_CD3)
    {
    default:
        r0 = sPSSData->field_CCC - sPSSData->field_CB4->pos1.x;
        break;
    case -1:
        r0 = sPSSData->field_CCC - 0xc0 - sPSSData->field_CB4->pos1.x;
        break;
    case 1:
        r0 = sPSSData->field_CCC + 0xc0 - sPSSData->field_CB4->pos1.x;
        break;
    }

    r7 <<= 8;
    r0 <<= 8;
    sPSSData->field_CC4 = r0 / sPSSData->field_CD0;
    sPSSData->field_CC8 = r7 / sPSSData->field_CD0;
    sPSSData->field_CBC = sPSSData->field_CB4->pos1.x << 8;
    sPSSData->field_CC0 = sPSSData->field_CB4->pos1.y << 8;
}

void sub_80927E8(u8 newCurosrArea, u8 newCursorPosition)
{
    sub_8092604(newCurosrArea, newCursorPosition);
    sub_8092660();
    if (sPSSData->boxOption != BOX_OPTION_MOVE_ITEMS)
    {
        if (sPSSData->inBoxMovingMode == 0 && !sIsMonBeingMoved)
            StartSpriteAnim(sPSSData->field_CB4, 1);
    }
    else
    {
        if (!IsActiveItemMoving())
            StartSpriteAnim(sPSSData->field_CB4, 1);
    }

    if (sPSSData->boxOption == BOX_OPTION_MOVE_ITEMS)
    {
        if (sBoxCursorArea == CURSOR_AREA_IN_BOX)
            sub_8095D44(CURSOR_AREA_IN_BOX, sBoxCursorPosition);
        else if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
            sub_8095D44(CURSOR_AREA_IN_PARTY, sBoxCursorPosition);

        if (newCurosrArea == CURSOR_AREA_IN_BOX)
            sub_8095C84(newCurosrArea, newCursorPosition);
        else if (newCurosrArea == CURSOR_AREA_IN_PARTY)
            sub_8095C84(newCurosrArea, newCursorPosition);
    }

    if (newCurosrArea == CURSOR_AREA_IN_PARTY && sBoxCursorArea != CURSOR_AREA_IN_PARTY)
    {
        sPSSData->field_CD6 = newCurosrArea;
        sPSSData->field_CB8->invisible = TRUE;
    }

    switch (newCurosrArea)
    {
    case CURSOR_AREA_IN_PARTY:
    case CURSOR_AREA_BOX:
    case CURSOR_AREA_BUTTONS:
        sPSSData->field_CB4->oam.priority = 1;
        sPSSData->field_CB8->invisible = TRUE;
        sPSSData->field_CB8->oam.priority = 1;
        break;
    case CURSOR_AREA_IN_BOX:
        if (sPSSData->inBoxMovingMode != 0)
        {
            sPSSData->field_CB4->oam.priority = 0;
            sPSSData->field_CB8->invisible = TRUE;
        }
        else
        {
            sPSSData->field_CB4->oam.priority = 2;
            if (sBoxCursorArea == CURSOR_AREA_IN_BOX && sIsMonBeingMoved)
                SetMovingMonPriority(2);
        }
        break;
    }
}

void sub_80929B0(void)
{
    sBoxCursorArea = sPSSData->field_CD4;
    sBoxCursorPosition = sPSSData->field_CD5;
    if (sPSSData->boxOption != BOX_OPTION_MOVE_ITEMS)
    {
        if (sPSSData->inBoxMovingMode == 0 && !sIsMonBeingMoved)
            StartSpriteAnim(sPSSData->field_CB4, 1);
    }
    else
    {
        if (!IsActiveItemMoving())
            StartSpriteAnim(sPSSData->field_CB4, 1);
    }

    sub_8093A10();
    switch (sBoxCursorArea)
    {
    case CURSOR_AREA_BUTTONS:
        SetMovingMonPriority(1);
        break;
    case CURSOR_AREA_BOX:
        sub_80920FC(TRUE);
        break;
    case CURSOR_AREA_IN_PARTY:
        sPSSData->field_CB8->subpriority = 13;
        SetMovingMonPriority(1);
        break;
    case CURSOR_AREA_IN_BOX:
        if (sPSSData->inBoxMovingMode == 0)
        {
            sPSSData->field_CB4->oam.priority = 1;
            sPSSData->field_CB8->oam.priority = 2;
            sPSSData->field_CB8->subpriority = 21;
            sPSSData->field_CB8->invisible = FALSE;
            SetMovingMonPriority(2);
        }
        break;
    }
}

void sub_8092AE4(void)
{
    u8 partyCount;

    if (!sIsMonBeingMoved)
    {
        partyCount = 0;
    }
    else
    {
        partyCount = CalculatePlayerPartyCount();
        if (partyCount >= PARTY_SIZE)
            partyCount = PARTY_SIZE - 1;
    }
    if (sPSSData->field_CB4->vFlip)
        sPSSData->field_CD7 = 1;
    sub_80927E8(CURSOR_AREA_IN_PARTY, partyCount);
}

void sub_8092B3C(u8 cursorBoxPosition)
{
    sub_80927E8(CURSOR_AREA_IN_BOX, cursorBoxPosition);
}

void sub_8092B50(void)
{
    gUnknown_2039826 = 0;
}

void sub_8092B5C(void)
{
    gUnknown_2039826 = sBoxCursorPosition;
}

u8 sub_8092B70(void)
{
    return gUnknown_2039826;
}

void InitMonPlaceChange(u8 a0)
{
    static bool8 (*const placeChangeFuncs[])(void) = {
        MonPlaceChange_Move,
        MonPlaceChange_Place,
        MonPlaceChange_Shift,
    };

    sPSSData->monPlaceChangeFunc = placeChangeFuncs[a0];
    sPSSData->monPlaceChangeState = 0;
}

void sub_8092BAC(bool8 arg0)
{
    if (!arg0)
        sPSSData->monPlaceChangeFunc = sub_8092E00;
    else
        sPSSData->monPlaceChangeFunc = sub_8092E10;

    sPSSData->monPlaceChangeState = 0;
}

bool8 DoMonPlaceChange(void)
{
    return sPSSData->monPlaceChangeFunc();
}

bool8 MonPlaceChange_Move(void)
{
    switch (sPSSData->monPlaceChangeState)
    {
    case 0:
        if (sIsMonBeingMoved)
            return FALSE;
        StartSpriteAnim(sPSSData->field_CB4, 2);
        sPSSData->monPlaceChangeState++;
        break;
    case 1:
        if (!sub_8092E20())
        {
            StartSpriteAnim(sPSSData->field_CB4, 3);
            MoveMon();
            sPSSData->monPlaceChangeState++;
        }
        break;
    case 2:
        if (!sub_8092E54())
            sPSSData->monPlaceChangeState++;
        break;
    case 3:
        return FALSE;
    }

    return TRUE;
}

bool8 MonPlaceChange_Place(void)
{
    switch (sPSSData->monPlaceChangeState)
    {
    case 0:
        if (!sub_8092E20())
        {
            StartSpriteAnim(sPSSData->field_CB4, 2);
            PlaceMon();
            sPSSData->monPlaceChangeState++;
        }
        break;
    case 1:
        if (!sub_8092E54())
        {
            StartSpriteAnim(sPSSData->field_CB4, 0);
            sPSSData->monPlaceChangeState++;
        }
        break;
    case 2:
        return FALSE;
    }

    return TRUE;
}

bool8 MonPlaceChange_Shift(void)
{
    switch (sPSSData->monPlaceChangeState)
    {
    case 0:
        switch (sBoxCursorArea)
        {
        case CURSOR_AREA_IN_PARTY:
            sPSSData->field_D91 = TOTAL_BOXES_COUNT;
            break;
        case CURSOR_AREA_IN_BOX:
            sPSSData->field_D91 = StorageGetCurrentBox();
            break;
        default:
            return FALSE;
        }
        StartSpriteAnim(sPSSData->field_CB4, 2);
        sub_8090E08(sPSSData->field_D91, sBoxCursorPosition);
        sPSSData->monPlaceChangeState++;
        break;
    case 1:
        if (!sub_8090E74())
        {
            StartSpriteAnim(sPSSData->field_CB4, 3);
            SetShiftedMonData(sPSSData->field_D91, sBoxCursorPosition);
            sPSSData->monPlaceChangeState++;
        }
        break;
    case 2:
        return FALSE;
    }

    return TRUE;
}

bool8 sub_8092E00(void)
{
    return sub_8092E20();
}

bool8 sub_8092E10(void)
{
    return sub_8092E54();
}

bool8 sub_8092E20(void)
{
    switch (sPSSData->field_CB4->pos2.y)
    {
    default:
        sPSSData->field_CB4->pos2.y++;
        break;
    case 0:
        sPSSData->field_CB4->pos2.y++;
        break;
    case 8:
        return FALSE;
    }

    return TRUE;
}

bool8 sub_8092E54(void)
{
    switch (sPSSData->field_CB4->pos2.y)
    {
    case 0:
        return FALSE;
    default:
        sPSSData->field_CB4->pos2.y--;
        break;
    }

    return TRUE;
}

void MoveMon(void)
{
    switch (sBoxCursorArea)
    {
    case CURSOR_AREA_IN_PARTY:
        SetMovedMonData(TOTAL_BOXES_COUNT, sBoxCursorPosition);
        sub_8090CC0(MODE_PARTY, sBoxCursorPosition);
        break;
    case CURSOR_AREA_IN_BOX:
        if (sPSSData->inBoxMovingMode == 0)
        {
            SetMovedMonData(StorageGetCurrentBox(), sBoxCursorPosition);
            sub_8090CC0(MODE_BOX, sBoxCursorPosition);
        }
        break;
    default:
        return;
    }

    sIsMonBeingMoved = TRUE;
}

void PlaceMon(void)
{
    u8 boxId;

    switch (sBoxCursorArea)
    {
    case CURSOR_AREA_IN_PARTY:
        SetPlacedMonData(TOTAL_BOXES_COUNT, sBoxCursorPosition);
        sub_8090D58(TOTAL_BOXES_COUNT, sBoxCursorPosition);
        break;
    case CURSOR_AREA_IN_BOX:
        boxId = StorageGetCurrentBox();
        SetPlacedMonData(boxId, sBoxCursorPosition);
        sub_8090D58(boxId, sBoxCursorPosition);
        break;
    default:
        return;
    }

    sIsMonBeingMoved = FALSE;
}

void sub_8092F54(void)
{
    sub_8093A10();
}

void SetMovedMonData(u8 boxId, u8 position)
{
    if (boxId == TOTAL_BOXES_COUNT)
        sPSSData->movingMon = gPlayerParty[sBoxCursorPosition];
    else
        BoxMonAtToMon(boxId, position, &sPSSData->movingMon);

    PurgeMonOrBoxMon(boxId, position);
    sMovingMonOrigBoxId = boxId;
    sMovingMonOrigBoxPos = position;
}

void SetPlacedMonData(u8 boxId, u8 position)
{
    if (boxId == TOTAL_BOXES_COUNT)
    {
        gPlayerParty[position] = sPSSData->movingMon;
    }
    else
    {
        BoxMonRestorePP(&sPSSData->movingMon.box);
        SetBoxMonAt(boxId, position, &sPSSData->movingMon.box);
    }
}

void PurgeMonOrBoxMon(u8 boxId, u8 position)
{
    if (boxId == TOTAL_BOXES_COUNT)
        ZeroMonData(&gPlayerParty[position]);
    else
        ZeroBoxMonAt(boxId, position);
}

void SetShiftedMonData(u8 boxId, u8 position)
{
    if (boxId == TOTAL_BOXES_COUNT)
        sPSSData->field_2108 = gPlayerParty[position];
    else
        BoxMonAtToMon(boxId, position, &sPSSData->field_2108);

    SetPlacedMonData(boxId, position);
    sPSSData->movingMon = sPSSData->field_2108;
    SetCursorMonData(&sPSSData->movingMon, MODE_PARTY);
    sMovingMonOrigBoxId = boxId;
    sMovingMonOrigBoxPos = position;
}

bool8 TryStorePartyMonInBox(u8 boxId)
{
    s16 boxPosition = GetFirstFreeBoxSpot(boxId);
    if (boxPosition == -1)
        return FALSE;

    if (sIsMonBeingMoved)
    {
        SetPlacedMonData(boxId, boxPosition);
        DestroyMovingMonIcon();
        sIsMonBeingMoved = FALSE;
    }
    else
    {
        SetMovedMonData(TOTAL_BOXES_COUNT, sBoxCursorPosition);
        SetPlacedMonData(boxId, boxPosition);
        DestroyPartyMonIcon(sBoxCursorPosition);
    }

    if (boxId == StorageGetCurrentBox())
        sub_80901EC(boxPosition);

    StartSpriteAnim(sPSSData->field_CB4, 1);
    return TRUE;
}

void sub_8093174(void)
{
    StartSpriteAnim(sPSSData->field_CB4, 0);
    sub_8093A10();
}

void sub_8093194(void)
{
    u8 mode;

    if (sIsMonBeingMoved)
        mode = MODE_2;
    else if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
        mode = MODE_PARTY;
    else
        mode = MODE_BOX;

    sub_8090FC4(mode, sBoxCursorPosition);
    StringCopy(sPSSData->field_21E0, sPSSData->cursorMonNick);
}

bool8 sub_80931EC(void)
{
    if (!sub_8091084())
    {
        StartSpriteAnim(sPSSData->field_CB4, 0);
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

void ReleaseMon(void)
{
    u8 boxId;

    sub_80910CC();
    if (sIsMonBeingMoved)
    {
        sIsMonBeingMoved = FALSE;
    }
    else
    {
        if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
            boxId = TOTAL_BOXES_COUNT;
        else
            boxId = StorageGetCurrentBox();

        PurgeMonOrBoxMon(boxId, sBoxCursorPosition);
    }
    sub_8093A10();
}

void sub_8093264(void)
{
    if (sIsMonBeingMoved)
        StartSpriteAnim(sPSSData->field_CB4, 3);
}

void InitCanReleaseMonVars(void)
{
    u16 knownIdx;
    if (sIsMonBeingMoved)
    {
        sPSSData->field_2108 = sPSSData->movingMon;
        sPSSData->field_2170 = -1;
        sPSSData->field_2171 = -1;
    }
    else
    {
        if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
        {
            sPSSData->field_2108 = gPlayerParty[sBoxCursorPosition];
            sPSSData->field_2170 = TOTAL_BOXES_COUNT;
        }
        else
        {
            BoxMonAtToMon(StorageGetCurrentBox(), sBoxCursorPosition, &sPSSData->field_2108);
            sPSSData->field_2170 = StorageGetCurrentBox();
        }
        sPSSData->field_2171 = sBoxCursorPosition;
    }

    sPSSData->isSurfMon = FALSE;
    sPSSData->isDiveMon = FALSE;
    sPSSData->field_2176[0] = MOVE_SURF;
    sPSSData->field_2176[1] = MOVE_DIVE;
    sPSSData->field_2176[2] = MOVES_COUNT;
    knownIdx = GetMonData(&sPSSData->field_2108, MON_DATA_KNOWN_MOVES, (u8*)sPSSData->field_2176);
    sPSSData->isSurfMon = knownIdx & 1;
    sPSSData->isDiveMon = (knownIdx >> 1) & 1;
    if (sPSSData->isSurfMon || sPSSData->isDiveMon)
    {
        sPSSData->field_216D = 0;
    }
    else
    {
        sPSSData->field_216D = 1;
        sPSSData->field_216C = 1;
    }

    sPSSData->field_2172 = 0;
}

s8 RunCanReleaseMon(void)
{
    u16 i;
    u16 knownMoves;

    if (sPSSData->field_216D)
        return sPSSData->field_216C;

    switch (sPSSData->field_2172)
    {
    case 0:
        for (i = 0; i < PARTY_SIZE; i++)
        {
            if (sPSSData->field_2170 != TOTAL_BOXES_COUNT || sPSSData->field_2171 != i)
            {
                knownMoves = GetMonData(gPlayerParty + i, MON_DATA_KNOWN_MOVES, (u8*)sPSSData->field_2176);
                if (knownMoves & 1)
                    sPSSData->isSurfMon = FALSE;
                if (knownMoves & 2)
                    sPSSData->isDiveMon = FALSE;
            }
        }
        if (!(sPSSData->isSurfMon || sPSSData->isDiveMon))
        {
            sPSSData->field_216D = 1;
            sPSSData->field_216C = 1;
        }
        else
        {
            sPSSData->field_216E = 0;
            sPSSData->field_216F = 0;
            sPSSData->field_2172++;
        }
        break;
    case 1:
        for (i = 0; i < 5; i++)
        {
            knownMoves = GetAndCopyBoxMonDataAt(sPSSData->field_216E, sPSSData->field_216F, MON_DATA_KNOWN_MOVES, (u8*)sPSSData->field_2176);
            if (knownMoves != 0
                && !(sPSSData->field_2170 == sPSSData->field_216E && sPSSData->field_2171 == sPSSData->field_216F))
            {
                if (knownMoves & 1)
                    sPSSData->isSurfMon = FALSE;
                if (knownMoves & 2)
                    sPSSData->isDiveMon = FALSE;
            }
            if (++sPSSData->field_216F >= IN_BOX_COUNT)
            {
                sPSSData->field_216F = 0;
                if (++sPSSData->field_216E >= TOTAL_BOXES_COUNT)
                {
                    sPSSData->field_216D = 1;
                    sPSSData->field_216C = 0;
                    break;
                }
            }
        }
        if (!(sPSSData->isSurfMon || sPSSData->isDiveMon))
        {
            sPSSData->field_216D = 1;
            sPSSData->field_216C = 1;
        }
        break;
    }

    return -1;
}

void sub_8093630(void)
{
    if (sIsMonBeingMoved)
        gUnknown_20397BC = sPSSData->movingMon;
}

void sub_8093660(void)
{
    if (sIsMonBeingMoved)
    {
        if (sMovingMonOrigBoxId == TOTAL_BOXES_COUNT)
            sPSSData->movingMon = gUnknown_20397BC;
        else
            sPSSData->movingMon.box = gUnknown_20397BC.box;
    }
}

void sub_80936B8(void)
{
    if (sIsMonBeingMoved)
    {
        sub_8093630();
        sPSSData->field_218C.mon = &gUnknown_20397BC;
        sPSSData->field_2187 = 0;
        sPSSData->field_2186 = 0;
        sPSSData->field_2188 = 0;
    }
    else if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
    {
        sPSSData->field_218C.mon = gPlayerParty;
        sPSSData->field_2187 = sBoxCursorPosition;
        sPSSData->field_2186 = CountPartyMons() - 1;
        sPSSData->field_2188 = 0;
    }
    else
    {
        sPSSData->field_218C.box = GetBoxedMonPtr(StorageGetCurrentBox(), 0);
        sPSSData->field_2187 = sBoxCursorPosition;
        sPSSData->field_2186 = IN_BOX_COUNT - 1;
        sPSSData->field_2188 = 5;
    }
}

void sub_80937B4(void)
{
    if (sIsMonBeingMoved)
        sub_8093660();
    else
        sBoxCursorPosition = GetLastViewedMonIndex();
}

// file boundary maybe?

s16 CompactPartySlots(void)
{
    s16 retVal = -1;
    u16 i, last;

    for (i = 0, last = 0; i < PARTY_SIZE; i++)
    {
        u16 species = GetMonData(gPlayerParty + i, MON_DATA_SPECIES);
        if (species != SPECIES_NONE)
        {
            if (i != last)
                gPlayerParty[last] = gPlayerParty[i];
            last++;
        }
        else if (retVal == -1)
        {
            retVal = i;
        }
    }
    for (; last < PARTY_SIZE; last++)
        ZeroMonData(gPlayerParty + last);

    return retVal;
}

void SetMonMarkings(u8 markings)
{
    sPSSData->cursorMonMarkings = markings;
    if (sIsMonBeingMoved)
    {
        SetMonData(&sPSSData->movingMon, MON_DATA_MARKINGS, &markings);
    }
    else
    {
        if (sBoxCursorArea == CURSOR_AREA_IN_PARTY)
            SetMonData(gPlayerParty + sBoxCursorPosition, MON_DATA_MARKINGS, &markings);
        if (sBoxCursorArea == CURSOR_AREA_IN_BOX)
            SetCurrentBoxMonData(sBoxCursorPosition, MON_DATA_MARKINGS, &markings);
    }
}

bool8 CanMovePartyMon(void)
{
    if (sBoxCursorArea == CURSOR_AREA_IN_PARTY && !sIsMonBeingMoved && CountPartyAliveNonEggMonsExcept(sBoxCursorPosition) == 0)
        return TRUE;
    else
        return FALSE;
}

bool8 CanShiftMon(void)
{
    if (sIsMonBeingMoved)
    {
        if (sBoxCursorArea == CURSOR_AREA_IN_PARTY && CountPartyAliveNonEggMonsExcept(sBoxCursorPosition) == 0)
        {
            if (sPSSData->cursorMonIsEgg || GetMonData(&sPSSData->movingMon, MON_DATA_HP) == 0)
                return FALSE;
        }
        return TRUE;
    }
    return FALSE;
}

bool8 IsMonBeingMoved(void)
{
    return sIsMonBeingMoved;
}

bool8 IsCursorOnBox(void)
{
    return (sBoxCursorArea == CURSOR_AREA_BOX);
}

bool8 IsCursorOnCloseBox(void)
{
    return (sBoxCursorArea == CURSOR_AREA_BUTTONS && sBoxCursorPosition == 1);
}

bool8 IsCursorInBox(void)
{
    return (sBoxCursorArea == CURSOR_AREA_IN_BOX);
}

void sub_8093A10(void)
{
    sPSSData->setMosaic = (sIsMonBeingMoved == FALSE);
    if (!sIsMonBeingMoved)
    {
        switch (sBoxCursorArea)
        {
        case CURSOR_AREA_IN_PARTY:
            if (sBoxCursorPosition < PARTY_SIZE)
            {
                SetCursorMonData(&gPlayerParty[sBoxCursorPosition], MODE_PARTY);
                break;
            }
            // fallthrough
        case CURSOR_AREA_BUTTONS:
        case CURSOR_AREA_BOX:
            SetCursorMonData(NULL, MODE_2);
            break;
        case CURSOR_AREA_IN_BOX:
            SetCursorMonData(GetBoxedMonPtr(StorageGetCurrentBox(), sBoxCursorPosition), MODE_BOX);
            break;
        }
    }
}

void sub_8093AAC(void)
{
    if (sIsMonBeingMoved)
        SetCursorMonData(&gUnknown_20397BC, MODE_PARTY);
    else
        sub_8093A10();
}

void SetCursorMonData(void *pokemon, u8 mode)
{
    u8 *txtPtr;
    u16 gender;
    bool8 sanityIsBagEgg;

    sPSSData->cursorMonItem = 0;
    gender = MON_MALE;
    sanityIsBagEgg = FALSE;
    if (mode == MODE_PARTY)
    {
        struct Pokemon *mon = (struct Pokemon *)pokemon;

        sPSSData->cursorMonSpecies = GetMonData(mon, MON_DATA_SPECIES2);
        if (sPSSData->cursorMonSpecies != SPECIES_NONE)
        {
            sanityIsBagEgg = GetMonData(mon, MON_DATA_SANITY_IS_BAD_EGG);
            if (sanityIsBagEgg)
                sPSSData->cursorMonIsEgg = TRUE;
            else
                sPSSData->cursorMonIsEgg = GetMonData(mon, MON_DATA_IS_EGG);

            GetMonData(mon, MON_DATA_NICKNAME, sPSSData->cursorMonNick);
            StringGetEnd10(sPSSData->cursorMonNick);
            sPSSData->cursorMonLevel = GetMonData(mon, MON_DATA_LEVEL);
            sPSSData->cursorMonMarkings = GetMonData(mon, MON_DATA_MARKINGS);
            sPSSData->cursorMonPersonality = GetMonData(mon, MON_DATA_PERSONALITY);
            sPSSData->cursorMonPalette = GetMonFrontSpritePal(mon);
            gender = GetMonGender(mon);
            sPSSData->cursorMonItem = GetMonData(mon, MON_DATA_HELD_ITEM);
        }
    }
    else if (mode == MODE_BOX)
    {
        struct BoxPokemon *boxMon = (struct BoxPokemon *)pokemon;

        sPSSData->cursorMonSpecies = GetBoxMonData(pokemon, MON_DATA_SPECIES2);
        if (sPSSData->cursorMonSpecies != SPECIES_NONE)
        {
            u32 otId = GetBoxMonData(boxMon, MON_DATA_OT_ID);
            sanityIsBagEgg = GetBoxMonData(boxMon, MON_DATA_SANITY_IS_BAD_EGG);
            if (sanityIsBagEgg)
                sPSSData->cursorMonIsEgg = TRUE;
            else
                sPSSData->cursorMonIsEgg = GetBoxMonData(boxMon, MON_DATA_IS_EGG);


            GetBoxMonData(boxMon, MON_DATA_NICKNAME, sPSSData->cursorMonNick);
            StringGetEnd10(sPSSData->cursorMonNick);
            sPSSData->cursorMonLevel = GetLevelFromBoxMonExp(boxMon);
            sPSSData->cursorMonMarkings = GetBoxMonData(boxMon, MON_DATA_MARKINGS);
            sPSSData->cursorMonPersonality = GetBoxMonData(boxMon, MON_DATA_PERSONALITY);
            sPSSData->cursorMonPalette = GetMonSpritePalFromSpeciesAndPersonality(sPSSData->cursorMonSpecies, otId, sPSSData->cursorMonPersonality);
            gender = GetGenderFromSpeciesAndPersonality(sPSSData->cursorMonSpecies, sPSSData->cursorMonPersonality);
            sPSSData->cursorMonItem = GetBoxMonData(boxMon, MON_DATA_HELD_ITEM);
        }
    }
    else
    {
        sPSSData->cursorMonSpecies = SPECIES_NONE;
        sPSSData->cursorMonItem = 0;
    }

    if (sPSSData->cursorMonSpecies == SPECIES_NONE)
    {
        StringFill(sPSSData->cursorMonNick, CHAR_SPACE, 5);
        StringFill(sPSSData->cursorMonTexts[0], CHAR_SPACE, 8);
        StringFill(sPSSData->cursorMonTexts[1], CHAR_SPACE, 8);
        StringFill(sPSSData->cursorMonTexts[2], CHAR_SPACE, 8);
        StringFill(sPSSData->cursorMonTexts[3], CHAR_SPACE, 8);
    }
    else if (sPSSData->cursorMonIsEgg)
    {
        if (sanityIsBagEgg)
            StringCopyPadded(sPSSData->cursorMonTexts[0], sPSSData->cursorMonNick, CHAR_SPACE, 5);
        else
            StringCopyPadded(sPSSData->cursorMonTexts[0], gText_EggNickname, CHAR_SPACE, 8);

        StringFill(sPSSData->cursorMonTexts[1], CHAR_SPACE, 8);
        StringFill(sPSSData->cursorMonTexts[2], CHAR_SPACE, 8);
        StringFill(sPSSData->cursorMonTexts[3], CHAR_SPACE, 8);
    }
    else
    {
        if (sPSSData->cursorMonSpecies == SPECIES_NIDORAN_F || sPSSData->cursorMonSpecies == SPECIES_NIDORAN_M)
            gender = MON_GENDERLESS;

        StringCopyPadded(sPSSData->cursorMonTexts[0], sPSSData->cursorMonNick, CHAR_SPACE, 5);

        txtPtr = sPSSData->cursorMonTexts[1];
        *(txtPtr)++ = CHAR_SLASH;
        StringCopyPadded(txtPtr, gSpeciesNames[sPSSData->cursorMonSpecies], CHAR_SPACE, 5);

        txtPtr = sPSSData->cursorMonTexts[2];
        *(txtPtr)++ = EXT_CTRL_CODE_BEGIN;
        *(txtPtr)++ = EXT_CTRL_CODE_COLOR_HIGHLIGHT_SHADOW;
        switch (gender)
        {
        case MON_MALE:
            *(txtPtr)++ = TEXT_COLOR_RED;
            *(txtPtr)++ = TEXT_COLOR_WHITE;
            *(txtPtr)++ = TEXT_COLOR_LIGHT_RED;
            *(txtPtr)++ = CHAR_MALE;
            break;
        case MON_FEMALE:
            *(txtPtr)++ = TEXT_COLOR_GREEN;
            *(txtPtr)++ = TEXT_COLOR_WHITE;
            *(txtPtr)++ = TEXT_COLOR_LIGHT_GREEN;
            *(txtPtr)++ = CHAR_FEMALE;
            break;
        default:
            *(txtPtr)++ = TEXT_COLOR_DARK_GREY;
            *(txtPtr)++ = TEXT_COLOR_WHITE;
            *(txtPtr)++ = TEXT_COLOR_LIGHT_GREY;
            *(txtPtr)++ = CHAR_SPACE;
            break;
        }

        *(txtPtr++) = EXT_CTRL_CODE_BEGIN;
        *(txtPtr++) = EXT_CTRL_CODE_COLOR_HIGHLIGHT_SHADOW;
        *(txtPtr++) = TEXT_COLOR_DARK_GREY;
        *(txtPtr++) = TEXT_COLOR_WHITE;
        *(txtPtr++) = TEXT_COLOR_LIGHT_GREY;
        *(txtPtr++) = CHAR_SPACE;
        *(txtPtr++) = CHAR_EXTRA_EMOJI;
        *(txtPtr++) = 5; // LV_2

        txtPtr = ConvertIntToDecimalStringN(txtPtr, sPSSData->cursorMonLevel, STR_CONV_MODE_LEFT_ALIGN, 3);
        txtPtr[0] = CHAR_SPACE;
        txtPtr[1] = EOS;

        if (sPSSData->cursorMonItem != 0)
            StringCopyPadded(sPSSData->cursorMonTexts[3], ItemId_GetName(sPSSData->cursorMonItem), CHAR_SPACE, 8);
        else
            StringFill(sPSSData->cursorMonTexts[3], CHAR_SPACE, 8);
    }
}

u8 HandleInput_InBox(void)
{
    switch (sPSSData->inBoxMovingMode)
    {
    case 0:
    default:
        return InBoxInput_Normal();
    case 1:
        return InBoxInput_GrabbingMultiple();
    case 2:
        return InBoxInput_MovingMultiple();
    }
}

#ifdef NONMATCHING
u8 InBoxInput_Normal(void)
{
    u8 retVal;
    s8 cursorArea = sBoxCursorArea;
    s8 cursorPosition = sBoxCursorPosition;

    sPSSData->field_CD2 = 0;
    sPSSData->field_CD3 = 0;
    sPSSData->field_CD7 = 0;

    do
    {
        if (JOY_REPT(DPAD_UP))
        {
            retVal = TRUE;
            if (sBoxCursorPosition >= IN_BOX_ROWS)
            {
                cursorPosition -= IN_BOX_ROWS;
            }
            else
            {
                cursorArea = CURSOR_AREA_BOX;
                cursorPosition = 0;
            }
            break;
        }
        else if (JOY_REPT(DPAD_DOWN))
        {
            retVal = TRUE;
            cursorPosition += IN_BOX_ROWS;
            if (cursorPosition >= IN_BOX_COUNT)
            {
                cursorArea = CURSOR_AREA_BUTTONS;
                cursorPosition -= IN_BOX_COUNT;
                cursorPosition /= 3;
                sPSSData->field_CD2 = 1;
                sPSSData->field_CD7 = 1;
            }
            break;
        }
        else if (JOY_REPT(DPAD_LEFT))
        {
            retVal = TRUE;
            if (sBoxCursorPosition % IN_BOX_ROWS != 0)
            {
                cursorPosition--;
            }
            else
            {
                sPSSData->field_CD3 = -1;
                cursorPosition += (IN_BOX_ROWS - 1);
            }
            break;
        }
        else if (JOY_REPT(DPAD_RIGHT))
        {
            retVal = TRUE;
            if ((sBoxCursorPosition + 1) % IN_BOX_ROWS != 0)
            {
                cursorPosition++;
            }
            else
            {
                sPSSData->field_CD3 = 1;
                cursorPosition -= (IN_BOX_ROWS - 1);
            }
            break;
        }
        else if (JOY_NEW(START_BUTTON))
        {
            retVal = TRUE;
            cursorArea = CURSOR_AREA_BOX;
            cursorPosition = 0;
            break;
        }

        if ((JOY_NEW(A_BUTTON)) && sub_8094924())
        {
            if (!sCanOnlyMove)
                return 8;

            if (sPSSData->boxOption != BOX_OPTION_MOVE_MONS || sIsMonBeingMoved == TRUE)
            {
                switch (sub_8094E50(0))
                {
                case 1:
                    return 11;
                case 2:
                    return 12;
                case 3:
                    return 13;
                case 4:
                    return 14;
                case 5:
                    return 15;
                case 12:
                    return 16;
                case 13:
                    return 17;
                case 15:
                    return 18;
                }
            }
            else
            {
                sPSSData->inBoxMovingMode = 1;
                return 20;
            }
        }

        if (JOY_NEW(B_BUTTON))
            return 19;

        if (gSaveBlock2Ptr->optionsButtonMode == OPTIONS_BUTTON_MODE_LR)
        {
            if (JOY_HELD(L_BUTTON))
                return 10;
            if (JOY_HELD(R_BUTTON))
                return 9;
        }

        if (JOY_NEW(SELECT_BUTTON))
        {
            sub_8094C84();
            return 0;
        }

        retVal = 0;

    } while (0);

    if (retVal)
        sub_80927E8(cursorArea, cursorPosition);

    return retVal;
}
#else
NAKED
u8 InBoxInput_Normal(void)
{
    asm_unified("\tpush {r4-r7,lr}\n"
                "\tmov r7, r10\n"
                "\tmov r6, r9\n"
                "\tmov r5, r8\n"
                "\tpush {r5-r7}\n"
                "\tldr r0, _08094058 @ =sBoxCursorArea\n"
                "\tldrb r0, [r0]\n"
                "\tmov r8, r0\n"
                "\tldr r2, _0809405C @ =sBoxCursorPosition\n"
                "\tldrb r4, [r2]\n"
                "\tldr r5, _08094060 @ =sPSSData\n"
                "\tldr r0, [r5]\n"
                "\tldr r1, _08094064 @ =0x00000cce\n"
                "\tmov r10, r1\n"
                "\tadd r0, r10\n"
                "\tmovs r1, 0\n"
                "\tstrb r1, [r0]\n"
                "\tldr r0, [r5]\n"
                "\tldr r7, _08094068 @ =0x00000ccf\n"
                "\tadds r0, r7\n"
                "\tstrb r1, [r0]\n"
                "\tldr r0, [r5]\n"
                "\tldr r3, _0809406C @ =0x00000cd3\n"
                "\tmov r9, r3\n"
                "\tadd r0, r9\n"
                "\tstrb r1, [r0]\n"
                "\tldr r6, _08094070 @ =gMain\n"
                "\tldrh r1, [r6, 0x30]\n"
                "\tmovs r0, 0x40\n"
                "\tands r0, r1\n"
                "\tadds r3, r2, 0\n"
                "\tcmp r0, 0\n"
                "\tbeq _08094018\n"
                "\tb _08094208\n"
                "_08094018:\n"
                "\tmovs r0, 0x80\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _08094074\n"
                "\tmovs r6, 0x1\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r1, 0xC0\n"
                "\tlsls r1, 19\n"
                "\tadds r0, r1\n"
                "\tlsrs r4, r0, 24\n"
                "\tasrs r0, 24\n"
                "\tcmp r0, 0x1D\n"
                "\tbgt _08094034\n"
                "\tb _08094224\n"
                "_08094034:\n"
                "\tmovs r2, 0x3\n"
                "\tmov r8, r2\n"
                "\tsubs r0, 0x1E\n"
                "\tlsls r0, 24\n"
                "\tasrs r0, 24\n"
                "\tmovs r1, 0x3\n"
                "\tbl __divsi3\n"
                "\tlsls r0, 24\n"
                "\tlsrs r4, r0, 24\n"
                "\tldr r0, [r5]\n"
                "\tadd r0, r10\n"
                "\tstrb r6, [r0]\n"
                "\tldr r0, [r5]\n"
                "\tadd r0, r9\n"
                "\tstrb r6, [r0]\n"
                "\tb _08094224\n"
                "\t.align 2, 0\n"
                "_08094058: .4byte sBoxCursorArea\n"
                "_0809405C: .4byte sBoxCursorPosition\n"
                "_08094060: .4byte sPSSData\n"
                "_08094064: .4byte 0x00000cce\n"
                "_08094068: .4byte 0x00000ccf\n"
                "_0809406C: .4byte 0x00000cd3\n"
                "_08094070: .4byte gMain\n"
                "_08094074:\n"
                "\tmovs r0, 0x20\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080940AA\n"
                "\tmovs r6, 0x1\n"
                "\tmovs r0, 0\n"
                "\tldrsb r0, [r3, r0]\n"
                "\tmovs r1, 0x6\n"
                "\tbl __modsi3\n"
                "\tlsls r0, 24\n"
                "\tcmp r0, 0\n"
                "\tbeq _08094096\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r3, 0xFF\n"
                "\tlsls r3, 24\n"
                "\tb _08094218\n"
                "_08094096:\n"
                "\tldr r0, [r5]\n"
                "\tadds r0, r7\n"
                "\tmovs r1, 0xFF\n"
                "\tstrb r1, [r0]\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r1, 0xA0\n"
                "\tlsls r1, 19\n"
                "\tadds r0, r1\n"
                "\tlsrs r4, r0, 24\n"
                "\tb _08094224\n"
                "_080940AA:\n"
                "\tmovs r0, 0x10\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080940DE\n"
                "\tmovs r6, 0x1\n"
                "\tmovs r0, 0\n"
                "\tldrsb r0, [r3, r0]\n"
                "\tadds r0, 0x1\n"
                "\tmovs r1, 0x6\n"
                "\tbl __modsi3\n"
                "\tcmp r0, 0\n"
                "\tbeq _080940D0\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r2, 0x80\n"
                "\tlsls r2, 17\n"
                "\tadds r0, r2\n"
                "\tlsrs r4, r0, 24\n"
                "\tb _08094224\n"
                "_080940D0:\n"
                "\tldr r0, [r5]\n"
                "\tadds r0, r7\n"
                "\tstrb r6, [r0]\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r3, 0xFB\n"
                "\tlsls r3, 24\n"
                "\tb _08094218\n"
                "_080940DE:\n"
                "\tldrh r1, [r6, 0x2E]\n"
                "\tmovs r0, 0x8\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080940EC\n"
                "\tmovs r6, 0x1\n"
                "\tb _0809421E\n"
                "_080940EC:\n"
                "\tmovs r4, 0x1\n"
                "\tmovs r0, 0x1\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080941B0\n"
                "\tbl sub_8094924\n"
                "\tlsls r0, 24\n"
                "\tcmp r0, 0\n"
                "\tbeq _080941B0\n"
                "\tldr r0, _0809410C @ =sCanOnlyMove\n"
                "\tldrb r0, [r0]\n"
                "\tcmp r0, 0\n"
                "\tbne _08094110\n"
                "\tmovs r0, 0x8\n"
                "\tb _08094232\n"
                "\t.align 2, 0\n"
                "_0809410C: .4byte sCanOnlyMove\n"
                "_08094110:\n"
                "\tldr r1, [r5]\n"
                "\tldrb r0, [r1, 0x1]\n"
                "\tcmp r0, 0x2\n"
                "\tbne _08094120\n"
                "\tldr r0, _0809413C @ =sIsMonBeingMoved\n"
                "\tldrb r0, [r0]\n"
                "\tcmp r0, 0x1\n"
                "\tbne _080941A0\n"
                "_08094120:\n"
                "\tmovs r0, 0\n"
                "\tbl sub_8094E50\n"
                "\tsubs r0, 0x1\n"
                "\tlsls r0, 24\n"
                "\tasrs r0, 24\n"
                "\tcmp r0, 0xE\n"
                "\tbhi _080941B0\n"
                "\tlsls r0, 2\n"
                "\tldr r1, _08094140 @ =_08094144\n"
                "\tadds r0, r1\n"
                "\tldr r0, [r0]\n"
                "\tmov pc, r0\n"
                "\t.align 2, 0\n"
                "_0809413C: .4byte sIsMonBeingMoved\n"
                "_08094140: .4byte _08094144\n"
                "\t.align 2, 0\n"
                "_08094144:\n"
                "\t.4byte _08094180\n"
                "\t.4byte _08094184\n"
                "\t.4byte _08094188\n"
                "\t.4byte _0809418C\n"
                "\t.4byte _08094190\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _08094194\n"
                "\t.4byte _08094198\n"
                "\t.4byte _080941B0\n"
                "\t.4byte _0809419C\n"
                "_08094180:\n"
                "\tmovs r0, 0xB\n"
                "\tb _08094232\n"
                "_08094184:\n"
                "\tmovs r0, 0xC\n"
                "\tb _08094232\n"
                "_08094188:\n"
                "\tmovs r0, 0xD\n"
                "\tb _08094232\n"
                "_0809418C:\n"
                "\tmovs r0, 0xE\n"
                "\tb _08094232\n"
                "_08094190:\n"
                "\tmovs r0, 0xF\n"
                "\tb _08094232\n"
                "_08094194:\n"
                "\tmovs r0, 0x10\n"
                "\tb _08094232\n"
                "_08094198:\n"
                "\tmovs r0, 0x11\n"
                "\tb _08094232\n"
                "_0809419C:\n"
                "\tmovs r0, 0x12\n"
                "\tb _08094232\n"
                "_080941A0:\n"
                "\tldr r2, _080941AC @ =0x000021ef\n"
                "\tadds r0, r1, r2\n"
                "\tstrb r4, [r0]\n"
                "\tmovs r0, 0x14\n"
                "\tb _08094232\n"
                "\t.align 2, 0\n"
                "_080941AC: .4byte 0x000021ef\n"
                "_080941B0:\n"
                "\tldr r2, _080941C0 @ =gMain\n"
                "\tldrh r1, [r2, 0x2E]\n"
                "\tmovs r0, 0x2\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080941C4\n"
                "\tmovs r0, 0x13\n"
                "\tb _08094232\n"
                "\t.align 2, 0\n"
                "_080941C0: .4byte gMain\n"
                "_080941C4:\n"
                "\tldr r0, _080941E0 @ =gSaveBlock2Ptr\n"
                "\tldr r0, [r0]\n"
                "\tldrb r0, [r0, 0x13]\n"
                "\tcmp r0, 0x1\n"
                "\tbne _080941F2\n"
                "\tldrh r1, [r2, 0x2C]\n"
                "\tmovs r0, 0x80\n"
                "\tlsls r0, 2\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080941E4\n"
                "\tmovs r0, 0xA\n"
                "\tb _08094232\n"
                "\t.align 2, 0\n"
                "_080941E0: .4byte gSaveBlock2Ptr\n"
                "_080941E4:\n"
                "\tmovs r0, 0x80\n"
                "\tlsls r0, 1\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _080941F2\n"
                "\tmovs r0, 0x9\n"
                "\tb _08094232\n"
                "_080941F2:\n"
                "\tldrh r1, [r2, 0x2E]\n"
                "\tmovs r0, 0x4\n"
                "\tands r0, r1\n"
                "\tcmp r0, 0\n"
                "\tbeq _08094204\n"
                "\tbl sub_8094C84\n"
                "\tmovs r0, 0\n"
                "\tb _08094232\n"
                "_08094204:\n"
                "\tmovs r6, 0\n"
                "\tb _08094230\n"
                "_08094208:\n"
                "\tmovs r6, 0x1\n"
                "\tmovs r0, 0\n"
                "\tldrsb r0, [r2, r0]\n"
                "\tcmp r0, 0x5\n"
                "\tble _0809421E\n"
                "\tlsls r0, r4, 24\n"
                "\tmovs r3, 0xFA\n"
                "\tlsls r3, 24\n"
                "_08094218:\n"
                "\tadds r0, r3\n"
                "\tlsrs r4, r0, 24\n"
                "\tb _08094224\n"
                "_0809421E:\n"
                "\tmovs r0, 0x2\n"
                "\tmov r8, r0\n"
                "\tmovs r4, 0\n"
                "_08094224:\n"
                "\tcmp r6, 0\n"
                "\tbeq _08094230\n"
                "\tmov r0, r8\n"
                "\tadds r1, r4, 0\n"
                "\tbl sub_80927E8\n"
                "_08094230:\n"
                "\tadds r0, r6, 0\n"
                "_08094232:\n"
                "\tpop {r3-r5}\n"
                "\tmov r8, r3\n"
                "\tmov r9, r4\n"
                "\tmov r10, r5\n"
                "\tpop {r4-r7}\n"
                "\tpop {r1}\n"
                "\tbx r1");
}
#endif
