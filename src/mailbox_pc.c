#include "global.h"
#include "malloc.h"
#include "window.h"
#include "menu.h"
#include "string_util.h"
#include "new_menu_helpers.h"
#include "list_menu.h"
#include "player_pc.h"
#include "strings.h"
#include "menu_indicators.h"
#include "sound.h"
#include "constants/songs.h"

EWRAM_DATA u8 sWindowIds[3] = {};
EWRAM_DATA struct ListMenuItem * sListMenuItems = NULL;

static void MoveCursorFunc(s32 itemIndex, bool8 onInit, struct ListMenu * list);

static const struct WindowTemplate sWindowTemplates[] = {
    {
        .bg = 0,
        .tilemapLeft = 1,
        .tilemapTop = 1,
        .width = 10,
        .height = 2,
        .paletteNum = 15,
        .baseBlock = 0x008
    }, {
        .bg = 0,
        .tilemapLeft = 19,
        .tilemapTop = 1,
        .width = 10,
        .height = 18,
        .paletteNum = 15,
        .baseBlock = 0x01c
    }, {
        .bg = 0,
        .tilemapLeft = 1,
        .tilemapTop = 1,
        .width = 15,
        .height = 8,
        .paletteNum = 15,
        .baseBlock = 0x01c
    }
};

static const u8 sTextColor[3] = {1, 2, 3};
static const u8 sString_Dummy[] = _("");

bool8 MailboxPC_InitBuffers(u8 num)
{
    u8 i;

    sListMenuItems = Alloc(sizeof(struct ListMenuItem) * (num + 1));
    if (sListMenuItems == NULL)
        return FALSE;
    for (i = 0; i < NELEMS(sWindowIds); i++)
        sWindowIds[i] = 0xFF;
    return TRUE;
}

u8 MailboxPC_GetAddWindow(u8 winIdx)
{
    if (sWindowIds[winIdx] == 0xFF)
    {
        sWindowIds[winIdx] = AddWindow(&sWindowTemplates[winIdx]);
        SetStdWindowBorderStyle(sWindowIds[winIdx], 0);
    }
    return sWindowIds[winIdx];
}

void MailboxPC_RemoveWindow(u8 winIdx)
{
    ClearStdWindowAndFrameToTransparent(sWindowIds[winIdx], FALSE);
    ClearWindowTilemap(sWindowIds[winIdx]);
    RemoveWindow(sWindowIds[winIdx]);
    sWindowIds[winIdx] = 0xFF;
}

u8 MailboxPC_GetWindowId(u8 winIdx)
{
    return sWindowIds[winIdx];
}

static void ItemPrintFunc(u8 windowId, s32 itemId, u8 y)
{
    u8 strbuf[30];
    if (itemId != -2)
    {
        StringCopy(strbuf, gSaveBlock1Ptr->mail[itemId + PARTY_SIZE].playerName);
        if (StringLength(strbuf) <= 5)
            ConvertInternationalString(strbuf, LANGUAGE_JAPANESE);
        AddTextPrinterParameterized4(windowId, 2, 8, y, 0, 0, sTextColor, -1, strbuf);
    }
}

u8 MailboxPC_InitListMenu(struct PlayerPC_Unk_203AAC4 * playerPcStruct)
{
    u16 i;
    for (i = 0; i < playerPcStruct->unk_5; i++)
    {
        sListMenuItems[i].label = sString_Dummy;
        sListMenuItems[i].index = i;
    }
    sListMenuItems[i].label = gFameCheckerText_Cancel;
    sListMenuItems[i].index = -2;

    gMultiuseListMenuTemplate.items = sListMenuItems;
    gMultiuseListMenuTemplate.totalItems = playerPcStruct->unk_5 + 1;
    gMultiuseListMenuTemplate.windowId = sWindowIds[1];
    gMultiuseListMenuTemplate.header_X = 0;
    gMultiuseListMenuTemplate.item_X = GetMenuCursorDimensionByFont(2, 0);
    gMultiuseListMenuTemplate.cursor_X = 0;
    gMultiuseListMenuTemplate.lettersSpacing = 0;
    gMultiuseListMenuTemplate.itemVerticalPadding = 2;
    gMultiuseListMenuTemplate.maxShowed = 8;
    gMultiuseListMenuTemplate.fontId = 2;
    gMultiuseListMenuTemplate.upText_Y = 10;
    gMultiuseListMenuTemplate.cursorPal = 2;
    gMultiuseListMenuTemplate.fillValue = 1;
    gMultiuseListMenuTemplate.cursorShadowPal = 3;
    gMultiuseListMenuTemplate.moveCursorFunc = MoveCursorFunc;
    gMultiuseListMenuTemplate.itemPrintFunc = ItemPrintFunc;
    gMultiuseListMenuTemplate.cursorKind = 0;
    gMultiuseListMenuTemplate.scrollMultiple = 0;
    return ListMenuInit(&gMultiuseListMenuTemplate, playerPcStruct->scrollOffset, playerPcStruct->selectedRow);
}

static void MoveCursorFunc(s32 itemIndex, bool8 onInit, struct ListMenu * list)
{
    if (onInit != TRUE)
        PlaySE(SE_SELECT);
}

void MailboxPC_AddScrollIndicatorArrows(struct PlayerPC_Unk_203AAC4 * playerPcStruct)
{
    playerPcStruct->unk_A = AddScrollIndicatorArrowPairParameterized(2, 0xC2, 0xC, 0x94, playerPcStruct->unk_5 - playerPcStruct->unk_4 + 1, 110, 110, &playerPcStruct->scrollOffset);
}

void MailboxPC_DestroyListMenuBuffer(void)
{
    Free(sListMenuItems);
}
