#include "global.h"
#include "malloc.h"
#include "battle.h"
#include "data.h"
#include "graphics.h"
#include "constants/items.h"
#include "constants/moves.h"
#include "constants/species.h"
#include "constants/trainers.h"
#include "constants/battle_ai.h"

const struct SpriteFrameImage gUnknown_8234698[] =
{
    gHeap + 0x8000, 0x800,
    gHeap + 0x8800, 0x800,
    gHeap + 0x9000, 0x800,
    gHeap + 0x9800, 0x800,
};

const struct SpriteFrameImage gUnknown_82346B8[] =
{
    gHeap + 0xA000, 0x800,
    gHeap + 0xA800, 0x800,
    gHeap + 0xB000, 0x800,
    gHeap + 0xB800, 0x800,
};

const struct SpriteFrameImage gUnknown_82346D8[] =
{
    gHeap + 0xC000, 0x800,
    gHeap + 0xC800, 0x800,
    gHeap + 0xD000, 0x800,
    gHeap + 0xD800, 0x800,
};

const struct SpriteFrameImage gUnknown_82346F8[] =
{
    gHeap + 0xE000, 0x800,
    gHeap + 0xE800, 0x800,
    gHeap + 0xF000, 0x800,
    gHeap + 0xF800, 0x800,
};

const struct SpriteFrameImage gTrainerBackPicTable_Red[] =
{
    gTrainerBackPic_Red, 0x0800,
    gTrainerBackPic_Red + 0x0800, 0x0800,
    gTrainerBackPic_Red + 0x1000, 0x0800,
    gTrainerBackPic_Red + 0x1800, 0x0800,
    gTrainerBackPic_Red + 0x2000, 0x0800,
};

const struct SpriteFrameImage gTrainerBackPicTable_Leaf[] =
{
    gTrainerBackPic_Leaf, 0x0800,
    gTrainerBackPic_Leaf + 0x0800, 0x0800,
    gTrainerBackPic_Leaf + 0x1000, 0x0800,
    gTrainerBackPic_Leaf + 0x1800, 0x0800,
    gTrainerBackPic_Leaf + 0x2000, 0x0800,
};

const struct SpriteFrameImage gTrainerBackPicTable_PokeDude[] =
{
    gTrainerBackPic_PokeDude, 0x0800,
    gTrainerBackPic_PokeDude + 0x0800, 0x0800,
    gTrainerBackPic_PokeDude + 0x1000, 0x0800,
    gTrainerBackPic_PokeDude + 0x1800, 0x0800,
};

const struct SpriteFrameImage gTrainerBackPicTable_OldMan[] =
{
    gTrainerBackPic_OldMan, 0x0800,
    gTrainerBackPic_OldMan + 0x0800, 0x0800,
    gTrainerBackPic_OldMan + 0x1000, 0x0800,
    gTrainerBackPic_OldMan + 0x1800, 0x0800,
};

const struct SpriteFrameImage gTrainerBackPicTable_RubySapphireBrendan[] =
{
    gTrainerBackPic_RubySapphireBrendan, 0x0800,
    gTrainerBackPic_RubySapphireBrendan + 0x0800, 0x0800,
    gTrainerBackPic_RubySapphireBrendan + 0x1000, 0x0800,
    gTrainerBackPic_RubySapphireBrendan + 0x1800, 0x0800,
};

const struct SpriteFrameImage gTrainerBackPicTable_RubySapphireMay[] =
{
    gTrainerBackPic_RubySapphireMay, 0x0800,
    gTrainerBackPic_RubySapphireMay + 0x0800, 0x0800,
    gTrainerBackPic_RubySapphireMay + 0x1000, 0x0800,
    gTrainerBackPic_RubySapphireMay + 0x1800, 0x0800,
};

static const union AnimCmd sAnim_GeneralFrame0[] =
{
    ANIMCMD_FRAME(0, 0),
    ANIMCMD_END,
};

static const union AnimCmd sAnim_GeneralFrame3[] =
{
    ANIMCMD_FRAME(3, 0),
    ANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_82347F8[] =
{
    AFFINEANIMCMD_FRAME(0x0100, 0x0100, 0x00, 0x00),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234808[] =
{
    AFFINEANIMCMD_FRAME(0xff00, 0x0100, 0x00, 0x00),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234818[] =
{
    AFFINEANIMCMD_FRAME(0x0028, 0x0028, 0x00, 0x00),
    AFFINEANIMCMD_FRAME(0x0012, 0x0012, 0x00, 0x0c),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234830[] =
{
    AFFINEANIMCMD_FRAME(0xfffe, 0xfffe, 0x00, 0x12),
    AFFINEANIMCMD_FRAME(0xfff0, 0xfff0, 0x00, 0x0f),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234848[] =
{
    AFFINEANIMCMD_FRAME(0x00a0, 0x0100, 0x00, 0x00),
    AFFINEANIMCMD_FRAME(0x0004, 0x0000, 0x00, 0x08),
    AFFINEANIMCMD_FRAME(0xfffc, 0x0000, 0x00, 0x08),
    AFFINEANIMCMD_JUMP(1),
};

static const union AffineAnimCmd gSpriteAffineAnim_8234868[] =
{
    AFFINEANIMCMD_FRAME(0x0002, 0x0002, 0x00, 0x14),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234878[] =
{
    AFFINEANIMCMD_FRAME(0xfffe, 0xfffe, 0x00, 0x14),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234888[] =
{
    AFFINEANIMCMD_FRAME(0x0100, 0x0100, 0x00, 0000),
    AFFINEANIMCMD_FRAME(0xfff0, 0xfff0, 0x00, 0x09),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_82348A0[] =
{
    AFFINEANIMCMD_FRAME(0x0004, 0x0004, 0x00, 0x3f),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_82348B0[] =
{
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0xfd, 0x05),
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0x03, 0x05),
    AFFINEANIMCMD_END,
};

const union AffineAnimCmd *const gSpriteAffineAnimTable_82348C8[] =
{
    gSpriteAffineAnim_82347F8,
    gSpriteAffineAnim_8234818,
    gSpriteAffineAnim_8234830,
    gSpriteAffineAnim_8234848,
    gSpriteAffineAnim_8234868,
    gSpriteAffineAnim_8234878,
    gSpriteAffineAnim_82348A0,
    gSpriteAffineAnim_82348B0,
    gSpriteAffineAnim_8234888,
};

static const union AffineAnimCmd gSpriteAffineAnim_82348EC[] =
{
    AFFINEANIMCMD_FRAME(0xfffc, 0xfffc, 0x04, 0x3f),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_82348FC[] =
{
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0x03, 0x05),
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0xfd, 0x05),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234914[] =
{
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0xfb, 0x14),
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0x00, 0x14),
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0x05, 0x14),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd gSpriteAffineAnim_8234934[] =
{
    AFFINEANIMCMD_FRAME(0x0000, 0x0000, 0x09, 0x6e),
    AFFINEANIMCMD_END,
};

const union AffineAnimCmd *const gSpriteAffineAnimTable_8234944[] =
{
    gSpriteAffineAnim_82347F8,
    gSpriteAffineAnim_8234818,
    gSpriteAffineAnim_8234830,
    gSpriteAffineAnim_8234848,
    gSpriteAffineAnim_8234868,
    gSpriteAffineAnim_8234878,
    gSpriteAffineAnim_82348EC,
    gSpriteAffineAnim_82348FC,
    gSpriteAffineAnim_8234914,
    gSpriteAffineAnim_8234888,
    gSpriteAffineAnim_8234934,
};

const union AffineAnimCmd *const gSpriteAffineAnimTable_82349470[] =
{
    gSpriteAffineAnim_8234808,
    gSpriteAffineAnim_8234818,
    gSpriteAffineAnim_8234830,
    gSpriteAffineAnim_8234848,
    gSpriteAffineAnim_8234868,
    gSpriteAffineAnim_8234878,
    gSpriteAffineAnim_82348EC,
    gSpriteAffineAnim_82348FC,
    gSpriteAffineAnim_8234914,
    gSpriteAffineAnim_8234888,
    gSpriteAffineAnim_8234934,
};

static const union AnimCmd gSpriteAnim_823499C[] =
{
    ANIMCMD_FRAME(0, 0),
    ANIMCMD_END,
};

static const union AnimCmd gSpriteAnim_82349A4[] =
{
    ANIMCMD_FRAME(1, 0),
    ANIMCMD_END,
};

static const union AnimCmd gSpriteAnim_82349AC[] =
{
    ANIMCMD_FRAME(2, 0),
    ANIMCMD_END,
};

static const union AnimCmd gSpriteAnim_82349B4[] =
{
    ANIMCMD_FRAME(3, 0),
    ANIMCMD_END,
};

const union AnimCmd *const gSpriteAnimTable_82349BC[] =
{
    gSpriteAnim_823499C,
    gSpriteAnim_82349A4,
    gSpriteAnim_82349AC,
    gSpriteAnim_82349B4,
};

#define SPECIES_SPRITE(species, sprite) [SPECIES_##species] = {sprite, 0x800, SPECIES_##species}

#include "data/pokemon_graphics/front_pic_coordinates.h"
#include "data/pokemon_graphics/front_pic_table.h"
#include "data/pokemon_graphics/back_pic_coordinates.h"
