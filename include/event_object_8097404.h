//
// Created by scott on 9/7/2017.
//

#ifndef GUARD_EVENT_OBJECT_8097404_H
#define GUARD_EVENT_OBJECT_8097404_H

#include "global.h"

// Exported type declarations

// Exported RAM declarations
extern void *gUnknown_020375B8;

// Exported ROM declarations
void sub_8097AC8(struct Sprite *);
void UnfreezeObjectEvent(struct ObjectEvent *);
void oamt_npc_ministep_reset(struct Sprite *, u8, u8);
u8 sub_8097F78(struct ObjectEvent *);
bool8 sub_80976EC(struct Sprite *sprite);
void sub_80976DC(struct Sprite *, u8);
void sub_809783C(struct Sprite *, u8, u8, u8);
void DoShadowFieldEffect(struct ObjectEvent *);
u8 sub_809785C(struct Sprite *);
u8 sub_80978E4(struct Sprite *);
bool8 sub_80979BC(struct Sprite *);
void sub_8097750(struct Sprite *);
bool8 sub_8097758(struct Sprite *);
void sub_8097FA4(struct ObjectEvent *);
void sub_8098044(u8);

#endif // GUARD_EVENT_OBJECT_8097404_H
