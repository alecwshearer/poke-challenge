#include "global.h"
#include "main.h"
#include "palette.h"
#include "string_util.h"
#include "window.h"
#include "text.h"

extern u8 gGlyphInfo[0x90];
extern u8 gUnknown_203ADFA;

extern void FillBitmapRect4Bit(struct Bitmap *surface, u16 x, u16 y, u16 width, u16 height, u8 fillValue);
extern void FillWindowPixelRect(u8 windowId, u8 fillValue, u16 x, u16 y, u16 width, u16 height);
extern void BlitBitmapRectToWindow(u8 windowId, const u8 *pixels, u16 srcX, u16 srcY, u16 srcWidth, int srcHeight, u16 destX, u16 destY, u16 rectWidth, u16 rectHeight);
extern u8 GetKeypadIconWidth(u8 keypadIconId);
extern void CopyWindowToVram(u8 windowId, u8 mode);
extern u16 Font6Func(struct TextPrinter *textPrinter);
extern u32 GetGlyphWidthFont6(u16 glyphId, bool32 isJapanese);
extern void PlaySE(u16 songNum);
extern u8* UnkTextUtil_GetPtrI(u8 a1);

TextFlags gTextFlags;

extern const u8 gDownArrowTiles[];
extern const u8 gDarkDownArrowTiles[];
extern const u8 gUnusedFRLGBlankedDownArrow[];
extern const u8 gUnusedFRLGDownArrow[];
extern const u8 gDownArrowYCoords[];
extern const u8 gWindowVerticalScrollSpeeds[];

extern const struct GlyphWidthFunc gGlyphWidthFuncs[];

extern const struct KeypadIcon gKeypadIcons[];

extern const u8 gKeypadIconTiles[];

extern const struct FontInfo gFontInfos[];

extern const u8 gMenuCursorDimensions[][2];

extern const u16 gFont8LatinGlyphs[];
extern const u8 gFont8LatinGlyphWidths[];
extern const u16 gFont0LatinGlyphs[];
extern const u8 gFont0LatinGlyphWidths[];
extern const u16 gFont7LatinGlyphs[];
extern const u8 gFont7LatinGlyphWidths[];
extern const u16 gFont2LatinGlyphs[];
extern const u8 gFont2LatinGlyphWidths[];
extern const u16 gFont1LatinGlyphs[];
extern const u8 gFont1LatinGlyphWidths[];
extern const u16 gFont0JapaneseGlyphs[];
extern const u16 gFont1JapaneseGlyphs[];
extern const u16 gFont2JapaneseGlyphs[];
extern const u8 gFont2JapaneseGlyphWidths[];
extern const u16 gFont4JapaneseGlyphs[];
extern const u8 gFont4JapaneseGlyphWidths[];
extern const u16 gFont4LatinGlyphs[];
extern const u8 gFont4LatinGlyphWidths[];
extern const u16 gFont5JapaneseGlyphs[];
extern const u8 gFont5JapaneseGlyphWidths[];
extern const u16 gFont5LatinGlyphs[];
extern const u8 gFont5LatinGlyphWidths[];
extern const u16 gFont9JapaneseGlyphs[];

u16 Font0Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 0;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

u16 Font1Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 1;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

u16 Font2Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 2;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

u16 Font3Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 3;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

u16 Font4Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 4;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

u16 Font5Func(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (subStruct->field_1_top == 0)
    {
        textPrinter->sub_union.sub.font_type = 5;
        subStruct->field_1_top = 1;
    }
    return RenderText(textPrinter);
}

void TextPrinterInitDownArrowCounters(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;

    if (gTextFlags.flag_2 == 1)
        subStruct->frames_visible_counter = 0;
    else
    {
        subStruct->field_1_upmid = 0;
        subStruct->field_1 = 0;
    }
}

void TextPrinterDrawDownArrow(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;
    const u8 *arrowTiles;

    if (gTextFlags.flag_2 == 0)
    {
        if (subStruct->field_1 != 0)
        {
            subStruct->field_1 = ((*(u32*)&textPrinter->sub_union.sub) << 19 >> 27) - 1;    // convoluted way of getting field_1, necessary to match
        }
        else
        {
            FillWindowPixelRect(
                textPrinter->subPrinter.windowId,
                textPrinter->subPrinter.bgColor << 4 | textPrinter->subPrinter.bgColor,
                textPrinter->subPrinter.currentX,
                textPrinter->subPrinter.currentY,
                10,
                12);

            switch (gTextFlags.flag_1)
            {
                case 0:
                default:
                    arrowTiles = gDownArrowTiles;
                    break;
                case 1:
                    arrowTiles = gDarkDownArrowTiles;
                    break;
            }

            BlitBitmapRectToWindow(
                textPrinter->subPrinter.windowId,
                arrowTiles,
                gDownArrowYCoords[*(u32*)subStruct << 17 >> 30], // subStruct->field_1_upmid but again, stupidly retrieved
                0,
                0x80,
                0x10,
                textPrinter->subPrinter.currentX,
                textPrinter->subPrinter.currentY,
                10,
                12);
            CopyWindowToVram(textPrinter->subPrinter.windowId, 0x2);

            subStruct->field_1 = 0x8;
            subStruct->field_1_upmid = (*(u32*)subStruct << 17 >> 30) + 1;
        }
    }
}

void TextPrinterClearDownArrow(struct TextPrinter *textPrinter)
{
    FillWindowPixelRect(
        textPrinter->subPrinter.windowId,
        textPrinter->subPrinter.bgColor << 4 | textPrinter->subPrinter.bgColor,
        textPrinter->subPrinter.currentX,
        textPrinter->subPrinter.currentY,
        10,
        12);
    CopyWindowToVram(textPrinter->subPrinter.windowId, 0x2);
}

bool8 TextPrinterWaitAutoMode(struct TextPrinter *textPrinter)
{
    struct TextPrinterSubStruct *subStruct = &textPrinter->sub_union.sub;
    u8 delay = (gUnknown_203ADFA == 2) ? 50 : 120;

    if (subStruct->frames_visible_counter == delay)
    {
        return TRUE;
    }
    else
    {
        subStruct->frames_visible_counter++;
        return FALSE;
    }
}

bool16 TextPrinterWaitWithDownArrow(struct TextPrinter *textPrinter)
{
    bool8 result = FALSE;
    if (gTextFlags.flag_2 != 0)
    {
        result = TextPrinterWaitAutoMode(textPrinter);
    }
    else
    {
        TextPrinterDrawDownArrow(textPrinter);
        if (gMain.newKeys & (A_BUTTON | B_BUTTON))
        {
            result = TRUE;
            PlaySE(5);
        }
    }
    return result;
}

bool16 TextPrinterWait(struct TextPrinter *textPrinter)
{
    bool16 result = FALSE;
    if (gTextFlags.flag_2 != 0)
    {
        result = TextPrinterWaitAutoMode(textPrinter);
    }
    else
    {
        if (gMain.newKeys & (A_BUTTON | B_BUTTON))
        {
            result = TRUE;
            PlaySE(5);
        }
    }
    return result;
}

void DrawDownArrow(u8 windowId, u16 x, u16 y, u8 bgColor, bool8 drawArrow, u8 *counter, u8 *yCoordIndex)
{
    const u8 *arrowTiles;

    if (*counter != 0)
    {
        --*counter;
    }
    else
    {
        FillWindowPixelRect(windowId, (bgColor << 4) | bgColor, x, y, 10, 12);
        if (drawArrow == 0)
        {
            switch (gTextFlags.flag_1)
            {
                case 0:
                default:
                    arrowTiles = gDownArrowTiles;
                    break;
                case 1:
                    arrowTiles = gDarkDownArrowTiles;
                    break;
            }

            BlitBitmapRectToWindow(
                windowId,
                arrowTiles,
                gDownArrowYCoords[*yCoordIndex & 3],
                0,
                0x80,
                0x10,
                x,
                y,
                10,
                12);
            CopyWindowToVram(windowId, 0x2);
            *counter = 8;
            ++*yCoordIndex;
        }
    }
}

__attribute__((naked))
u16 RenderText(struct TextPrinter *textPrinter)
{
    asm(".syntax unified\n\
    push {r4-r6,lr}\n\
    adds r6, r0, 0\n\
    adds r4, r6, 0\n\
    adds r4, 0x14\n\
    ldrb r0, [r6, 0x1C]\n\
    cmp r0, 0x6\n\
    bls _080057A0\n\
    b _08005D68\n\
_080057A0:\n\
    lsls r0, 2\n\
    ldr r1, _080057AC @ =_080057B0\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_080057AC: .4byte _080057B0\n\
    .align 2, 0\n\
_080057B0:\n\
    .4byte _080057CC\n\
    .4byte _08005C58\n\
    .4byte _08005C6C\n\
    .4byte _08005C98\n\
    .4byte _08005CD0\n\
    .4byte _08005D44\n\
    .4byte _08005D56\n\
_080057CC:\n\
    ldr r2, _08005820 @ =gMain\n\
    ldrh r1, [r2, 0x2C]\n\
    movs r0, 0x3\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080057E6\n\
    ldrb r1, [r4]\n\
    movs r0, 0x10\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080057E6\n\
    movs r0, 0\n\
    strb r0, [r6, 0x1E]\n\
_080057E6:\n\
    ldrb r1, [r6, 0x1E]\n\
    cmp r1, 0\n\
    beq _08005828\n\
    ldrb r0, [r6, 0x1D]\n\
    cmp r0, 0\n\
    beq _08005828\n\
    subs r0, r1, 0x1\n\
    strb r0, [r6, 0x1E]\n\
    ldr r0, _08005824 @ =gTextFlags\n\
    ldrb r1, [r0]\n\
    movs r0, 0x1\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _08005804\n\
    b _08005B30\n\
_08005804:\n\
    ldrh r1, [r2, 0x2E]\n\
    movs r0, 0x3\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _08005810\n\
    b _08005B30\n\
_08005810:\n\
    ldrb r0, [r4]\n\
    movs r1, 0x10\n\
    orrs r0, r1\n\
    strb r0, [r4]\n\
    movs r0, 0\n\
    strb r0, [r6, 0x1E]\n\
    b _08005B30\n\
    .align 2, 0\n\
_08005820: .4byte gMain\n\
_08005824: .4byte gTextFlags\n\
_08005828:\n\
    ldr r2, _08005838 @ =gTextFlags\n\
    ldrb r1, [r2]\n\
    movs r0, 0x4\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0800583C\n\
    movs r0, 0x1\n\
    b _0800583E\n\
    .align 2, 0\n\
_08005838: .4byte gTextFlags\n\
_0800583C:\n\
    ldrb r0, [r6, 0x1D]\n\
_0800583E:\n\
    strb r0, [r6, 0x1E]\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    adds r0, r3, 0\n\
    subs r0, 0xF8\n\
    cmp r0, 0x7\n\
    bls _08005852\n\
    b _08005B6C\n\
_08005852:\n\
    lsls r0, 2\n\
    ldr r1, _0800585C @ =_08005860\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_0800585C: .4byte _08005860\n\
    .align 2, 0\n\
_08005860:\n\
    .4byte _08005B46\n\
    .4byte _08005B34\n\
    .4byte _08005B26\n\
    .4byte _08005B22\n\
    .4byte _080058AC\n\
    .4byte _080058A8\n\
    .4byte _08005880\n\
    .4byte _08005D68\n\
_08005880:\n\
    ldrb r0, [r6, 0x6]\n\
    strb r0, [r6, 0x8]\n\
    ldrb r1, [r6, 0x5]\n\
    ldr r0, _080058A4 @ =gFonts\n\
    ldr r2, [r0]\n\
    lsls r0, r1, 1\n\
    adds r0, r1\n\
    lsls r0, 2\n\
    adds r0, r2\n\
    ldrb r1, [r6, 0xB]\n\
    ldrb r0, [r0, 0x5]\n\
    adds r1, r0\n\
    ldrb r0, [r6, 0x9]\n\
    adds r0, r1\n\
    strb r0, [r6, 0x9]\n\
_0800589E:\n\
    movs r0, 0x2\n\
    b _08005D6A\n\
    .align 2, 0\n\
_080058A4: .4byte gFonts\n\
_080058A8:\n\
    ldr r0, [r6]\n\
    b _08005B0A\n\
_080058AC:\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    subs r0, r3, 0x1\n\
    cmp r0, 0x17\n\
    bls _080058BC\n\
    b _08005B6C\n\
_080058BC:\n\
    lsls r0, 2\n\
    ldr r1, _080058C8 @ =_080058CC\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_080058C8: .4byte _080058CC\n\
    .align 2, 0\n\
_080058CC:\n\
    .4byte _0800592C\n\
    .4byte _0800594E\n\
    .4byte _08005972\n\
    .4byte _0800598C\n\
    .4byte _080059D8\n\
    .4byte _080059DC\n\
    .4byte _0800589E\n\
    .4byte _080059F4\n\
    .4byte _08005A04\n\
    .4byte _08005A1A\n\
    .4byte _08005A1E\n\
    .4byte _08005A66\n\
    .4byte _08005A70\n\
    .4byte _08005A78\n\
    .4byte _08005A84\n\
    .4byte _08005A4C\n\
    .4byte _08005AB0\n\
    .4byte _08005ACC\n\
    .4byte _08005ADC\n\
    .4byte _08005B00\n\
    .4byte _08005B10\n\
    .4byte _08005B18\n\
    .4byte _08005A96\n\
    .4byte _08005AA4\n\
_0800592C:\n\
    ldr r2, [r6]\n\
    ldrb r1, [r2]\n\
    lsls r1, 4\n\
    ldrb r3, [r6, 0xC]\n\
    movs r0, 0xF\n\
    ands r0, r3\n\
    orrs r0, r1\n\
    strb r0, [r6, 0xC]\n\
    adds r2, 0x1\n\
    str r2, [r6]\n\
    lsls r0, 24\n\
    lsrs r0, 28\n\
    ldrb r2, [r6, 0xD]\n\
    lsls r1, r2, 28\n\
    lsrs r1, 28\n\
    lsrs r2, 4\n\
    b _080059D2\n\
_0800594E:\n\
    ldr r1, [r6]\n\
    ldrb r2, [r1]\n\
    movs r0, 0xF\n\
    ands r0, r2\n\
    ldrb r3, [r6, 0xD]\n\
    movs r2, 0x10\n\
    negs r2, r2\n\
    ands r2, r3\n\
    orrs r2, r0\n\
    strb r2, [r6, 0xD]\n\
    adds r1, 0x1\n\
    str r1, [r6]\n\
    ldrb r0, [r6, 0xC]\n\
    lsrs r0, 4\n\
    lsls r1, r2, 28\n\
    lsrs r1, 28\n\
    lsrs r2, 4\n\
    b _080059D2\n\
_08005972:\n\
    ldr r1, [r6]\n\
    ldrb r0, [r1]\n\
    lsls r0, 4\n\
    ldrb r3, [r6, 0xD]\n\
    movs r2, 0xF\n\
    ands r2, r3\n\
    orrs r2, r0\n\
    strb r2, [r6, 0xD]\n\
    adds r1, 0x1\n\
    str r1, [r6]\n\
    ldrb r0, [r6, 0xC]\n\
    lsrs r0, 4\n\
    b _080059CA\n\
_0800598C:\n\
    ldr r3, [r6]\n\
    ldrb r1, [r3]\n\
    lsls r1, 4\n\
    ldrb r4, [r6, 0xC]\n\
    movs r2, 0xF\n\
    adds r0, r2, 0\n\
    ands r0, r4\n\
    orrs r0, r1\n\
    strb r0, [r6, 0xC]\n\
    adds r5, r3, 0x1\n\
    str r5, [r6]\n\
    ldrb r3, [r3, 0x1]\n\
    adds r1, r2, 0\n\
    ands r1, r3\n\
    ldrb r4, [r6, 0xD]\n\
    movs r3, 0x10\n\
    negs r3, r3\n\
    ands r3, r4\n\
    orrs r3, r1\n\
    strb r3, [r6, 0xD]\n\
    adds r4, r5, 0x1\n\
    str r4, [r6]\n\
    ldrb r1, [r5, 0x1]\n\
    lsls r1, 4\n\
    ands r2, r3\n\
    orrs r2, r1\n\
    strb r2, [r6, 0xD]\n\
    adds r4, 0x1\n\
    str r4, [r6]\n\
    lsls r0, 24\n\
    lsrs r0, 28\n\
_080059CA:\n\
    lsls r1, r2, 28\n\
    lsrs r1, 28\n\
    lsls r2, 24\n\
    lsrs r2, 28\n\
_080059D2:\n\
    bl GenerateFontHalfRowLookupTable\n\
    b _0800589E\n\
_080059D8:\n\
    ldr r0, [r6]\n\
    b _08005B0A\n\
_080059DC:\n\
    ldr r0, [r6]\n\
    ldrb r0, [r0]\n\
    movs r1, 0xF\n\
    ands r1, r0\n\
    ldrb r2, [r4]\n\
    movs r0, 0x10\n\
    negs r0, r0\n\
    ands r0, r2\n\
    orrs r0, r1\n\
    strb r0, [r4]\n\
    ldr r0, [r6]\n\
    b _08005B0A\n\
_080059F4:\n\
    ldr r0, [r6]\n\
    ldrb r1, [r0]\n\
    strb r1, [r6, 0x1E]\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    movs r0, 0x6\n\
    strb r0, [r6, 0x1C]\n\
    b _0800589E\n\
_08005A04:\n\
    movs r0, 0x1\n\
    strb r0, [r6, 0x1C]\n\
    ldrb r1, [r2]\n\
    movs r0, 0x4\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _08005A14\n\
    b _08005B30\n\
_08005A14:\n\
    movs r0, 0\n\
    strb r0, [r4, 0x2]\n\
    b _08005B30\n\
_08005A1A:\n\
    movs r0, 0x5\n\
    b _08005D52\n\
_08005A1E:\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    adds r1, r0, 0x1\n\
    str r1, [r6]\n\
    ldrb r0, [r0, 0x1]\n\
    lsls r0, 8\n\
    orrs r3, r0\n\
    adds r1, 0x1\n\
    str r1, [r6]\n\
    ldr r0, _08005A48 @ =gUnknown_203ADFA\n\
    ldrb r0, [r0]\n\
    subs r0, 0x2\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x1\n\
    bhi _08005A40\n\
    b _0800589E\n\
_08005A40:\n\
    adds r0, r3, 0\n\
    bl PlayBGM\n\
    b _0800589E\n\
    .align 2, 0\n\
_08005A48: .4byte gUnknown_203ADFA\n\
_08005A4C:\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    adds r1, r0, 0x1\n\
    str r1, [r6]\n\
    ldrb r0, [r0, 0x1]\n\
    lsls r0, 8\n\
    orrs r3, r0\n\
    adds r1, 0x1\n\
    str r1, [r6]\n\
    adds r0, r3, 0\n\
    bl PlaySE\n\
    b _0800589E\n\
_08005A66:\n\
    ldr r1, [r6]\n\
    adds r0, r1, 0x1\n\
    str r0, [r6]\n\
    ldrb r3, [r1, 0x1]\n\
    b _08005B6C\n\
_08005A70:\n\
    ldr r1, [r6]\n\
    ldrb r0, [r1]\n\
    ldrb r2, [r6, 0x6]\n\
    b _08005AD2\n\
_08005A78:\n\
    ldr r1, [r6]\n\
    ldrb r0, [r1]\n\
    ldrb r3, [r6, 0x7]\n\
    adds r0, r3\n\
    strb r0, [r6, 0x9]\n\
    b _08005AD6\n\
_08005A84:\n\
    ldrb r0, [r6, 0x4]\n\
    ldrb r2, [r6, 0xD]\n\
    lsls r2, 28\n\
    lsrs r1, r2, 4\n\
    orrs r1, r2\n\
    lsrs r1, 24\n\
    bl FillWindowPixelBuffer\n\
    b _0800589E\n\
_08005A96:\n\
    ldr r0, _08005AA0 @ =gMPlayInfo_BGM\n\
    bl m4aMPlayStop\n\
    b _0800589E\n\
    .align 2, 0\n\
_08005AA0: .4byte gMPlayInfo_BGM\n\
_08005AA4:\n\
    ldr r0, _08005AAC @ =gMPlayInfo_BGM\n\
    bl m4aMPlayContinue\n\
    b _0800589E\n\
    .align 2, 0\n\
_08005AAC: .4byte gMPlayInfo_BGM\n\
_08005AB0:\n\
    ldr r0, [r6]\n\
    ldrb r4, [r0]\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    cmp r4, 0\n\
    bgt _08005ABE\n\
    b _0800589E\n\
_08005ABE:\n\
    adds r0, r6, 0\n\
    adds r1, r4, 0\n\
    bl ClearTextSpan\n\
    ldrb r0, [r6, 0x8]\n\
    adds r0, r4\n\
    b _08005C4E\n\
_08005ACC:\n\
    ldr r1, [r6]\n\
    ldrb r0, [r6, 0x6]\n\
    ldrb r2, [r1]\n\
_08005AD2:\n\
    adds r0, r2\n\
    strb r0, [r6, 0x8]\n\
_08005AD6:\n\
    adds r1, 0x1\n\
    str r1, [r6]\n\
    b _0800589E\n\
_08005ADC:\n\
    ldr r0, [r6]\n\
    ldrb r2, [r0]\n\
    ldrb r1, [r6, 0x6]\n\
    adds r2, r1\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    ldrb r0, [r6, 0x8]\n\
    subs r4, r2, r0\n\
    cmp r4, 0\n\
    bgt _08005AF2\n\
    b _0800589E\n\
_08005AF2:\n\
    adds r0, r6, 0\n\
    adds r1, r4, 0\n\
    bl ClearTextSpan\n\
    ldrb r0, [r6, 0x8]\n\
    adds r0, r4\n\
    b _08005C4E\n\
_08005B00:\n\
    ldr r0, [r6]\n\
    ldrb r2, [r0]\n\
    adds r1, r6, 0\n\
    adds r1, 0x20\n\
    strb r2, [r1]\n\
_08005B0A:\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    b _0800589E\n\
_08005B10:\n\
    adds r1, r6, 0\n\
    adds r1, 0x21\n\
    movs r0, 0x1\n\
    b _08005B1E\n\
_08005B18:\n\
    adds r1, r6, 0\n\
    adds r1, 0x21\n\
    movs r0, 0\n\
_08005B1E:\n\
    strb r0, [r1]\n\
    b _0800589E\n\
_08005B22:\n\
    movs r0, 0x2\n\
    b _08005B28\n\
_08005B26:\n\
    movs r0, 0x3\n\
_08005B28:\n\
    strb r0, [r6, 0x1C]\n\
    adds r0, r6, 0\n\
    bl TextPrinterInitDownArrowCounters\n\
_08005B30:\n\
    movs r0, 0x3\n\
    b _08005D6A\n\
_08005B34:\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    movs r2, 0x80\n\
    lsls r2, 1\n\
    adds r1, r2, 0\n\
    orrs r3, r1\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    b _08005B6C\n\
_08005B46:\n\
    ldr r0, [r6]\n\
    ldrb r3, [r0]\n\
    adds r0, 0x1\n\
    str r0, [r6]\n\
    ldrb r0, [r6, 0x4]\n\
    adds r1, r3, 0\n\
    ldrb r2, [r6, 0x8]\n\
    ldrb r3, [r6, 0x9]\n\
    bl DrawKeypadIcon\n\
    ldr r1, _08005B68 @ =gGlyphInfo\n\
    adds r1, 0x80\n\
    strb r0, [r1]\n\
    ldrb r3, [r6, 0xA]\n\
    adds r0, r3\n\
    b _08005C4A\n\
    .align 2, 0\n\
_08005B68: .4byte gGlyphInfo\n\
_08005B6C:\n\
    ldr r0, [r4]\n\
    lsls r0, 28\n\
    lsrs r0, 28\n\
    cmp r0, 0x5\n\
    bhi _08005BEE\n\
    lsls r0, 2\n\
    ldr r1, _08005B80 @ =_08005B84\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_08005B80: .4byte _08005B84\n\
    .align 2, 0\n\
_08005B84:\n\
    .4byte _08005B9C\n\
    .4byte _08005BAA\n\
    .4byte _08005BB8\n\
    .4byte _08005BC6\n\
    .4byte _08005BD4\n\
    .4byte _08005BE2\n\
_08005B9C:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont0\n\
    b _08005BEE\n\
_08005BAA:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont1\n\
    b _08005BEE\n\
_08005BB8:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont2\n\
    b _08005BEE\n\
_08005BC6:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont3\n\
    b _08005BEE\n\
_08005BD4:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont4\n\
    b _08005BEE\n\
_08005BE2:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r1, [r0]\n\
    adds r0, r3, 0\n\
    bl DecompressGlyphFont5\n\
_08005BEE:\n\
    adds r0, r6, 0\n\
    bl CopyGlyphToWindow\n\
    adds r2, r6, 0\n\
    adds r2, 0x20\n\
    ldrb r0, [r2]\n\
    cmp r0, 0\n\
    beq _08005C28\n\
    ldr r1, _08005C24 @ =gGlyphInfo\n\
    adds r1, 0x80\n\
    ldrb r0, [r1]\n\
    ldrb r3, [r6, 0x8]\n\
    adds r0, r3\n\
    strb r0, [r6, 0x8]\n\
    ldrb r2, [r2]\n\
    ldrb r0, [r1]\n\
    subs r4, r2, r0\n\
    cmp r4, 0\n\
    ble _08005C50\n\
    adds r0, r6, 0\n\
    adds r1, r4, 0\n\
    bl ClearTextSpan\n\
    ldrb r0, [r6, 0x8]\n\
    adds r0, r4\n\
    b _08005C4E\n\
    .align 2, 0\n\
_08005C24: .4byte gGlyphInfo\n\
_08005C28:\n\
    adds r0, r6, 0\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    cmp r0, 0\n\
    beq _08005C44\n\
    ldr r0, _08005C40 @ =gGlyphInfo\n\
    adds r0, 0x80\n\
    ldrb r1, [r6, 0xA]\n\
    ldrb r0, [r0]\n\
    adds r1, r0\n\
    ldrb r0, [r6, 0x8]\n\
    b _08005C4C\n\
    .align 2, 0\n\
_08005C40: .4byte gGlyphInfo\n\
_08005C44:\n\
    ldr r0, _08005C54 @ =gGlyphInfo\n\
    adds r0, 0x80\n\
    ldrb r0, [r0]\n\
_08005C4A:\n\
    ldrb r1, [r6, 0x8]\n\
_08005C4C:\n\
    adds r0, r1\n\
_08005C4E:\n\
    strb r0, [r6, 0x8]\n\
_08005C50:\n\
    movs r0, 0\n\
    b _08005D6A\n\
    .align 2, 0\n\
_08005C54: .4byte gGlyphInfo\n\
_08005C58:\n\
    adds r0, r6, 0\n\
    bl TextPrinterWait\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _08005C66\n\
    b _08005B30\n\
_08005C66:\n\
    movs r0, 0\n\
    strb r0, [r6, 0x1C]\n\
    b _08005B30\n\
_08005C6C:\n\
    adds r0, r6, 0\n\
    bl TextPrinterWaitWithDownArrow\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _08005C7A\n\
    b _08005B30\n\
_08005C7A:\n\
    ldrb r0, [r6, 0x4]\n\
    ldrb r2, [r6, 0xD]\n\
    lsls r2, 28\n\
    lsrs r1, r2, 4\n\
    orrs r1, r2\n\
    lsrs r1, 24\n\
    bl FillWindowPixelBuffer\n\
    ldrb r0, [r6, 0x6]\n\
    movs r1, 0\n\
    strb r0, [r6, 0x8]\n\
    ldrb r0, [r6, 0x7]\n\
    strb r0, [r6, 0x9]\n\
    strb r1, [r6, 0x1C]\n\
    b _08005B30\n\
_08005C98:\n\
    adds r0, r6, 0\n\
    bl TextPrinterWaitWithDownArrow\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _08005CA6\n\
    b _08005B30\n\
_08005CA6:\n\
    adds r0, r6, 0\n\
    bl TextPrinterClearDownArrow\n\
    ldrb r1, [r6, 0x5]\n\
    ldr r0, _08005CCC @ =gFonts\n\
    ldr r2, [r0]\n\
    lsls r0, r1, 1\n\
    adds r0, r1\n\
    lsls r0, 2\n\
    adds r0, r2\n\
    ldrb r1, [r6, 0xB]\n\
    ldrb r0, [r0, 0x5]\n\
    adds r1, r0\n\
    strb r1, [r6, 0x1F]\n\
    ldrb r0, [r6, 0x6]\n\
    strb r0, [r6, 0x8]\n\
    movs r0, 0x4\n\
    strb r0, [r6, 0x1C]\n\
    b _08005B30\n\
    .align 2, 0\n\
_08005CCC: .4byte gFonts\n\
_08005CD0:\n\
    ldrb r2, [r6, 0x1F]\n\
    cmp r2, 0\n\
    beq _08005D40\n\
    ldr r4, _08005D04 @ =gUnknown_81EA650\n\
    ldr r5, _08005D08 @ =gSaveBlock2Ptr\n\
    ldr r0, [r5]\n\
    ldrb r0, [r0, 0x14]\n\
    lsls r1, r0, 29\n\
    lsrs r0, r1, 29\n\
    adds r0, r4\n\
    ldrb r0, [r0]\n\
    cmp r2, r0\n\
    bcs _08005D0C\n\
    ldrb r0, [r6, 0x4]\n\
    ldrb r1, [r6, 0xD]\n\
    lsls r1, 28\n\
    lsrs r3, r1, 4\n\
    orrs r3, r1\n\
    lsrs r3, 24\n\
    movs r1, 0\n\
    bl ScrollWindow\n\
    movs r0, 0\n\
    strb r0, [r6, 0x1F]\n\
    b _08005D36\n\
    .align 2, 0\n\
_08005D04: .4byte gUnknown_81EA650\n\
_08005D08: .4byte gSaveBlock2Ptr\n\
_08005D0C:\n\
    ldrb r0, [r6, 0x4]\n\
    lsrs r1, 29\n\
    adds r1, r4\n\
    ldrb r2, [r1]\n\
    ldrb r1, [r6, 0xD]\n\
    lsls r1, 28\n\
    lsrs r3, r1, 4\n\
    orrs r3, r1\n\
    lsrs r3, 24\n\
    movs r1, 0\n\
    bl ScrollWindow\n\
    ldr r0, [r5]\n\
    ldrb r0, [r0, 0x14]\n\
    lsls r0, 29\n\
    lsrs r0, 29\n\
    adds r0, r4\n\
    ldrb r1, [r6, 0x1F]\n\
    ldrb r0, [r0]\n\
    subs r1, r0\n\
    strb r1, [r6, 0x1F]\n\
_08005D36:\n\
    ldrb r0, [r6, 0x4]\n\
    movs r1, 0x2\n\
    bl CopyWindowToVram\n\
    b _08005B30\n\
_08005D40:\n\
    strb r2, [r6, 0x1C]\n\
    b _08005B30\n\
_08005D44:\n\
    bl IsSEPlaying\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0\n\
    beq _08005D52\n\
    b _08005B30\n\
_08005D52:\n\
    strb r0, [r6, 0x1C]\n\
    b _08005B30\n\
_08005D56:\n\
    ldrb r0, [r6, 0x1E]\n\
    adds r1, r0, 0\n\
    cmp r1, 0\n\
    beq _08005D64\n\
    subs r0, 0x1\n\
    strb r0, [r6, 0x1E]\n\
    b _08005B30\n\
_08005D64:\n\
    strb r1, [r6, 0x1C]\n\
    b _08005B30\n\
_08005D68:\n\
    movs r0, 0x1\n\
_08005D6A:\n\
    pop {r4-r6}\n\
    pop {r1}\n\
    bx r1\n\
    .syntax divided");
}

u32 GetStringWidthFixedWidthFont(const u8 *str, u8 fontId, u8 letterSpacing)
{
    int i;
    u8 width;
    int temp;
    int temp2;
    u8 line;
    int strPos;
    u8 lineWidths[8];
    const u8 *strLocal;

    for (i = 0; i < 8; i++)
    {
        lineWidths[i] = 0;
    }

    width = 0;
    line = 0;
    strLocal = str;
    strPos = 0;

    do
    {
        temp = strLocal[strPos++];
        switch (temp)
        {
            case 0xFE:
            case 0xFF:
                lineWidths[line] = width;
                width = 0;
                line++;
                break;
            case 0xFC:
                temp2 = strLocal[strPos++];
                switch (temp2)
                {
                    case 0x4:
                        ++strPos;
                    case 0xB:
                    case 0x10:
                        ++strPos;
                    case 0x1:
                    case 0x2:
                    case 0x3:
                    case 0x5:
                    case 0x6:
                    case 0x8:
                    case 0xC:
                    case 0xD:
                    case 0xE:
                    case 0x11:
                    case 0x12:
                    case 0x13:
                    case 0x14:
                        ++strPos;
                        break;
                    case 0x7:
                    case 0x9:
                    case 0xA:
                    case 0xF:
                    case 0x15:
                    case 0x16:
                    default:
                        break;
                }
                break;
            case 0xF7:
            case 0xFD:
                ++strPos;
                break;
            case 0xFA:
            case 0xFB:
                break;
            case 0xF8:
            case 0xF9:
                ++strPos;
            default:
                ++width;
                break;
        }
    } while (temp != 0xFF);

    for (width = 0, strPos = 0; strPos < 8; ++strPos)
    {
        if (width < lineWidths[strPos])
            width = lineWidths[strPos];
    }

    return (u8)(GetFontAttribute(fontId, 0) + letterSpacing) * width;
}

u32 (*GetFontWidthFunc(u8 glyphId))(u16, bool32)
{
    u32 i;

    for (i = 0; i < 7; ++i)
    {
        if (glyphId == gGlyphWidthFuncs[i].font_id)
            return gGlyphWidthFuncs[i].func;
    }

    return 0;
}

u32 GetStringWidth(u8 fontId, const u8 *str, s16 letterSpacing)
{
    bool8 isJapanese;
    int minGlyphWidth;
    u32 (*func)(u16 glyphId, bool32 isJapanese);
    int localLetterSpacing;
    register u32 lineWidth asm("r5");
    u8 *bufferPointer;
    int glyphWidth;
    u32 width;

    isJapanese = 0;
    minGlyphWidth = 0;

    func = GetFontWidthFunc(fontId);
    if (func == NULL)
        return 0;

    if (letterSpacing == -1)
        localLetterSpacing = GetFontAttribute(fontId, 2);
    else
        localLetterSpacing = letterSpacing;

    width = 0;
    lineWidth = 0;
    bufferPointer = 0;

    while (*str != 0xFF)
    {
        switch (*str)
        {
            case 0xFE:
                if (lineWidth > width)
                    width = lineWidth;
                lineWidth = 0;
                break;
            case 0xFD:
                switch (*++str)
                {
                    case 0x2:
                        bufferPointer = gStringVar1;
                        break;
                    case 0x3:
                        bufferPointer = gStringVar2;
                        break;
                    case 0x4:
                        bufferPointer = gStringVar3;
                        break;
                    default:
                        return 0;
                }
            case 0xF7:
                if (bufferPointer == NULL)
                    bufferPointer = UnkTextUtil_GetPtrI(*++str);
                while (*bufferPointer != 0xFF)
                {
                    glyphWidth = func(*bufferPointer++, isJapanese);
                    if (minGlyphWidth > 0)
                    {
                        if (glyphWidth < minGlyphWidth)
                            glyphWidth = minGlyphWidth;
                    }
                    else if (isJapanese)
                    {
                        glyphWidth += localLetterSpacing;
                    }
                    lineWidth += glyphWidth;
                }
                bufferPointer = 0;
                break;
            case 0xFC:
                switch (*++str)
                {
                    case 0x4:
                        ++str;
                    case 0xB:
                    case 0x10:
                        ++str;
                    case 0x1:
                    case 0x2:
                    case 0x3:
                    case 0x5:
                    case 0x8:
                    case 0xC:
                    case 0xD:
                    case 0xE:
                        ++str;
                        break;
                    case 0x6:
                        func = GetFontWidthFunc(*++str);
                        if (func == NULL)
                            return 0;
                        if (letterSpacing == -1)
                            localLetterSpacing = GetFontAttribute(*str, 2);
                        break;
                    case 0x11:
                        glyphWidth = *++str;
                        lineWidth += glyphWidth;
                        break;
                    case 0x12:
                        lineWidth = *++str;
                        break;
                    case 0x13:
                        if (*++str > lineWidth)
                            lineWidth = *str;
                        break;
                    case 0x14:
                        minGlyphWidth = *++str;
                        break;
                    case 0x15:
                        isJapanese = 1;
                        break;
                    case 0x16:
                        isJapanese = 0;
                        break;
                    case 0x7:
                    case 0x9:
                    case 0xA:
                    case 0xF:
                    default:
                        break;
                }
                break;
            case 0xF8:
            case 0xF9:
                if (*str == 0xF9)
                    glyphWidth = func(*++str | 0x100, isJapanese);
                else
                    glyphWidth = GetKeypadIconWidth(*++str);

                if (minGlyphWidth > 0)
                {
                    if (glyphWidth < minGlyphWidth)
                        glyphWidth = minGlyphWidth;
                }
                else if (isJapanese)
                {
                    glyphWidth += localLetterSpacing;
                }
                lineWidth += glyphWidth;
                break;
            case 0xFA:
            case 0xFB:
                break;
            default:
                glyphWidth = func(*str, isJapanese);
                if (minGlyphWidth > 0)
                {
                    if (glyphWidth < minGlyphWidth)
                        glyphWidth = minGlyphWidth;
                    lineWidth += glyphWidth;
                }
                else
                {
                    if (fontId != 6 && isJapanese)
                    {
                        glyphWidth += localLetterSpacing;
                    }
                    lineWidth += glyphWidth;
                }
                break;
        }
        ++str;
    }

    if (lineWidth > width)
        return lineWidth;
    return width;
}

u8 RenderTextFont9(u8 *pixels, u8 fontId, u8 *str)
{
    u8 shadowColor;
    u8 *strLocal;
    int strPos;
    int temp;
    int temp2;
    u8 colorBackup[3];
    u8 fgColor;
    u8 bgColor;

    SaveTextColors(&colorBackup[0], &colorBackup[1], &colorBackup[2]);

    fgColor = 1;
    bgColor = 0;
    shadowColor = 3;

    GenerateFontHalfRowLookupTable(1, 0, 3);
    strLocal = str;
    strPos = 0;

    do
    {
        temp = strLocal[strPos++];
        switch (temp)
        {
            case 0xFC:
                temp2 = strLocal[strPos++];
                switch (temp2)
                {
                    case 0x4:
                        fgColor = strLocal[strPos++];
                        bgColor = strLocal[strPos++];
                        shadowColor = strLocal[strPos++];
                        GenerateFontHalfRowLookupTable(fgColor, bgColor, shadowColor);
                        continue;
                    case 0x1:
                        fgColor = strLocal[strPos++];
                        GenerateFontHalfRowLookupTable(fgColor, bgColor, shadowColor);
                        continue;
                    case 0x2:
                        bgColor = strLocal[strPos++];
                        GenerateFontHalfRowLookupTable(fgColor, bgColor, shadowColor);
                        continue;
                    case 0x3:
                        shadowColor = strLocal[strPos++];
                        GenerateFontHalfRowLookupTable(fgColor, bgColor, shadowColor);
                        continue;
                    case 0x6:
                        fontId = strLocal[strPos++];
                        break;
                    case 0xB:
                    case 0x10:
                        ++strPos;
                    case 0x5:
                    case 0x8:
                    case 0xC:
                    case 0xD:
                    case 0xE:
                    case 0x11:
                    case 0x12:
                    case 0x13:
                    case 0x14:
                        ++strPos;
                        break;
                    case 0x7:
                    case 0x9:
                    case 0xA:
                    case 0xF:
                    case 0x15:
                    case 0x16:
                    default:
                        continue;
                }
                break;
            case 0xF7:
            case 0xF8:
            case 0xF9:
            case 0xFD:
                ++strPos;
                break;
            case 0xFA:
            case 0xFB:
            case 0xFE:
            case 0xFF:
                break;
            default:
                DecompressGlyphFont9(temp);
                CpuCopy32(gGlyphInfo, pixels, 0x20);
                CpuCopy32(gGlyphInfo + 0x40, pixels + 0x20, 0x20);
                pixels += 0x40;
                break;
        }
    }
    while (temp != 0xFF);

    RestoreTextColors(&colorBackup[0], &colorBackup[1], &colorBackup[2]);
    return 1;
}

// TODO: What is this?
struct Unk80062B0 {
    u8 filler0[0x26];
    u16 unk26;
    u8 filler28[0x6];
    s16 unk2E;
    s16 unk30;
};

void sub_80062B0(struct Unk80062B0 *unkStruct)
{
    if(unkStruct->unk2E)
    {
        unkStruct->unk2E--;
    }
    else
    {
        unkStruct->unk2E = 8;
        switch(unkStruct->unk30)
        {
            case 0:
                unkStruct->unk26 = 0;
                break;
            case 1:
                unkStruct->unk26 = 1;
                break;
            case 2:
                unkStruct->unk26 = 2;
                break;
            case 3:
                unkStruct->unk26 = 1;
                unkStruct->unk30 = 0;
                return;
        }
        unkStruct->unk30++;
    }
}

extern const struct SpriteSheet gUnknown_81EA68C[];
extern const struct SpritePalette gUnknown_81EA6A4;
extern const struct SpriteTemplate gUnknown_81EA6B4;

u8 sub_8006300(u8 sheetId, u16 x, u16 y, u8 priority, u8 subpriority)
{
    u8 spriteId;
    LoadSpriteSheet(&gUnknown_81EA68C[sheetId & 1]);
    LoadSpritePalette(&gUnknown_81EA6A4);
    spriteId = CreateSprite(&gUnknown_81EA6B4, x + 3, y + 4, subpriority);
    gSprites[spriteId].oam.priority = (priority & 3);
    gSprites[spriteId].oam.matrixNum = 0;
    gSprites[spriteId].data[0] = 8;
    return spriteId;
}

void sub_8006398(u8 spriteId)
{
    DestroySprite(&gSprites[spriteId]);
    FreeSpriteTilesByTag(0x8000);
    FreeSpritePaletteByTag(0x8000);
}

u8 DrawKeypadIcon(u8 windowId, u8 keypadIconId, u16 x, u16 y)
{
    BlitBitmapRectToWindow(
        windowId,
        gKeypadIconTiles + (gKeypadIcons[keypadIconId].tile_offset * 0x20),
        0,
        0,
        0x80,
        0x80,
        x,
        y,
        gKeypadIcons[keypadIconId].width,
        gKeypadIcons[keypadIconId].height);
    return gKeypadIcons[keypadIconId].width;
}

u8 GetKeypadIconTileOffset(u8 keypadIconId)
{
    return gKeypadIcons[keypadIconId].tile_offset;
}

u8 GetKeypadIconWidth(u8 keypadIconId)
{
    return gKeypadIcons[keypadIconId].width;
}

u8 GetKeypadIconHeight(u8 keypadIconId)
{
    return gKeypadIcons[keypadIconId].height;
}

void DecompressGlyphFont0(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;

    if (isJapanese == 1)
    {
        glyphs = gFont0JapaneseGlyphs + (0x100 * (glyphId >> 0x4)) + (0x8 * (glyphId & 0xF));
        DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
        DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));
        gGlyphInfo[0x80] = 8;     // gGlyphWidth
        gGlyphInfo[0x81] = 12;    // gGlyphHeight
    }
    else
    {
        glyphs = gFont0LatinGlyphs + (0x10 * glyphId);
        DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
        DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x40));
        gGlyphInfo[0x80] = gFont0LatinGlyphWidths[glyphId];
        gGlyphInfo[0x81] = 13;
    }
}

u32 GetGlyphWidthFont0(u16 glyphId, bool32 isJapanese)
{
    if (isJapanese == TRUE)
        return 8;
    else
        return gFont0LatinGlyphWidths[glyphId];
}

void DecompressGlyphFont1(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;

    if (isJapanese == TRUE)
    {
        int eff;
        glyphs = gFont1JapaneseGlyphs + (0x100 * (glyphId >> 0x4)) + (0x8 * (glyphId & (eff = 0xF)));  // shh, no questions, only matching now
        DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
        DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FD0
        gGlyphInfo[0x80] = 8;     // gGlyphWidth
        gGlyphInfo[0x81] = 16;    // gGlyphHeight
    }
    else
    {
        glyphs = gFont1LatinGlyphs + (0x20 * glyphId);
        DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
        DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));
        DecompressGlyphTile(glyphs + 0x10, (u16 *)(gGlyphInfo + 0x40));
        DecompressGlyphTile(glyphs + 0x18, (u16 *)(gGlyphInfo + 0x60));
        gGlyphInfo[0x80] = gFont1LatinGlyphWidths[glyphId];
        gGlyphInfo[0x81] = 14;
    }
}

u32 GetGlyphWidthFont1(u16 glyphId, bool32 isJapanese)
{
    if (isJapanese == TRUE)
        return 8;
    else
        return gFont1LatinGlyphWidths[glyphId];
}

void DecompressGlyphFont2(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;
    int i;
    u8 lastColor;

    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // Game Freak, please. writing the same values over and over...
                gGlyphInfo[0x80] = 10;
                gGlyphInfo[0x81] = 12;
            }
        }
        else // _080065F8
        {
            glyphs = gFont2JapaneseGlyphs + (0x100 * (glyphId >> 0x3)) + (0x10 * (glyphId & 0x7));
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x88, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = gFont2JapaneseGlyphWidths[glyphId];     // gGlyphWidth
            gGlyphInfo[0x81] = 12;    // gGlyphHeight
        }
    }
    else // _0800665C
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // but why
                gGlyphInfo[0x80] = gFont2LatinGlyphWidths[0];
                gGlyphInfo[0x81] = 14;
            }
        }
        else // _0800669C
        {
            glyphs = gFont2LatinGlyphs + (0x20 * glyphId);
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));
            DecompressGlyphTile(glyphs + 0x10, (u16 *)(gGlyphInfo + 0x40));
            DecompressGlyphTile(glyphs + 0x18, (u16 *)(gGlyphInfo + 0x60));
            gGlyphInfo[0x80] = gFont2LatinGlyphWidths[glyphId];
            gGlyphInfo[0x81] = 14;
        }
    }
}

u32 GetGlyphWidthFont2(u16 glyphId, bool32 isJapanese)
{
    if (isJapanese == TRUE)
    {
        if(glyphId == 0)
            return 10;

        return gFont2JapaneseGlyphWidths[glyphId];
    }
    else
    {
        return gFont2LatinGlyphWidths[glyphId];
    }
}

void DecompressGlyphFont3(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;
    int i;
    u8 lastColor;

    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // Game Freak, please. writing the same values over and over...
                gGlyphInfo[0x80] = 10;
                gGlyphInfo[0x81] = 12;
            }
        }
        else
        {
            glyphs = gFont2JapaneseGlyphs + (0x100 * (glyphId >> 0x3)) + (0x10 * (glyphId & 0x7));
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x88, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = 10;    // gGlyphWidth
            gGlyphInfo[0x81] = 12;    // gGlyphHeight
        }
    }
    else
        DecompressGlyphFont2(glyphId, isJapanese);
}

u32 GetGlyphWidthFont3(u16 glyphId, bool32 isJapanese)
{
    if(isJapanese == TRUE)
        return 10;
    else
        return gFont2LatinGlyphWidths[glyphId];
}

void DecompressGlyphFont4(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;
    int i;
    u8 lastColor;

    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // Game Freak, please. writing the same values over and over...
                gGlyphInfo[0x80] = 10;
                gGlyphInfo[0x81] = 12;
            }
        }
        else // _0800682C
        {
            glyphs = gFont4JapaneseGlyphs + (0x100 * (glyphId >> 0x3)) + (0x10 * (glyphId & 0x7));
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x88, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = gFont4JapaneseGlyphWidths[glyphId];    // gGlyphWidth
            gGlyphInfo[0x81] = 12;    // gGlyphHeight
        }
    }
    else
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // but why
                gGlyphInfo[0x80] = gFont4LatinGlyphWidths[0];
                gGlyphInfo[0x81] = 14;
            }
        }
        else // _080068D0
        {
            glyphs = gFont4LatinGlyphs + (0x20 * glyphId);
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x10, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x18, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = gFont4LatinGlyphWidths[glyphId];    // gGlyphWidth
            gGlyphInfo[0x81] = 14;    // gGlyphHeight
        }
    }
}

u32 GetGlyphWidthFont4(u16 glyphId, bool32 isJapanese)
{
    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
            return 10;

        return gFont4JapaneseGlyphWidths[glyphId];
    }
    else
        return gFont4LatinGlyphWidths[glyphId];
}

void DecompressGlyphFont5(u16 glyphId, bool32 isJapanese)
{
    const u16* glyphs;
    int i;
    u8 lastColor;

    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // Game Freak, please. writing the same values over and over...
                gGlyphInfo[0x80] = 10;
                gGlyphInfo[0x81] = 12;
            }
        }
        else // _08006998
        {
            glyphs = gFont5JapaneseGlyphs + (0x100 * (glyphId >> 0x3)) + (0x10 * (glyphId & 0x7));
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x88, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = gFont5JapaneseGlyphWidths[glyphId];    // gGlyphWidth
            gGlyphInfo[0x81] = 12;    // gGlyphHeight
        }
    }
    else
    {
        if(glyphId == 0)
        {
            lastColor = GetLastTextColor(2);

            for(i = 0; i < 0x80; i++)
            {
                gGlyphInfo[i] = lastColor | lastColor << 4;
                // but why
                gGlyphInfo[0x80] = gFont5LatinGlyphWidths[0];
                gGlyphInfo[0x81] = 14;
            }
        }
        else
        {
            glyphs = gFont5LatinGlyphs + (0x20 * glyphId);
            DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
            DecompressGlyphTile(glyphs + 0x8, (u16 *)(gGlyphInfo + 0x20));    // gUnknown_03002FD0
            DecompressGlyphTile(glyphs + 0x10, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FB0
            DecompressGlyphTile(glyphs + 0x18, (u16 *)(gGlyphInfo + 0x60));    // gUnknown_03002FF0
            gGlyphInfo[0x80] = gFont5LatinGlyphWidths[glyphId];    // gGlyphWidth
            gGlyphInfo[0x81] = 14;    // gGlyphHeight
        }
    }
}

u32 GetGlyphWidthFont5(u16 glyphId, bool32 isJapanese)
{
    if(isJapanese == TRUE)
    {
        if(glyphId == 0)
            return 10;
        
        return gFont5JapaneseGlyphWidths[glyphId];
    }
    else
        return gFont5LatinGlyphWidths[glyphId];
}

void DecompressGlyphFont9(u16 glyphId)
{
    const u16* glyphs = gFont9JapaneseGlyphs + (0x100 * (glyphId >> 0x4)) + (0x8 * (glyphId & 0xF));
    DecompressGlyphTile(glyphs, (u16 *)gGlyphInfo);
    DecompressGlyphTile(glyphs + 0x80, (u16 *)(gGlyphInfo + 0x40));    // gUnknown_03002FD0
    gGlyphInfo[0x80] = 8;
    gGlyphInfo[0x81] = 12;
}
