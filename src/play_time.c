#include "play_time.h"
#include "event_data.h"

static u8 sPlayTimeCounterState;

enum
{
    STOPPED,
    RUNNING,
    MAXED_OUT,
};

void PlayTimeCounter_Reset(void)
{
    sPlayTimeCounterState = STOPPED;
    gSaveBlock2Ptr->playTimeHours = 0;
    gSaveBlock2Ptr->playTimeMinutes = 0;
    gSaveBlock2Ptr->playTimeSeconds = 0;
    gSaveBlock2Ptr->playTimeVBlanks = 0;
}

void PlayTimeCounter_Start(void)
{
    sPlayTimeCounterState = RUNNING;
    if (gSaveBlock2Ptr->playTimeHours > 999)
        PlayTimeCounter_SetToMax();
}

void PlayTimeCounter_Stop(void)
{
    sPlayTimeCounterState = STOPPED;
}

void PlayTimeCounter_Update(void)
{
    if (!FlagGet(FLAG_CHALLENGE_NOT_OVER) || (sPlayTimeCounterState != RUNNING)) {
        return;
    }
    gSaveBlock2Ptr->playTimeVBlanks++;
    if (gSaveBlock2Ptr->playTimeVBlanks > 59)
    {
        gSaveBlock2Ptr->playTimeVBlanks = 0;
        gSaveBlock2Ptr->playTimeSeconds++;
        if (gSaveBlock2Ptr->playTimeSeconds > 59)
        {
            gSaveBlock2Ptr->playTimeSeconds = 0;
            gSaveBlock2Ptr->playTimeMinutes++;
            if (gSaveBlock2Ptr->playTimeMinutes > 59)
            {
                gSaveBlock2Ptr->playTimeMinutes = 0;
                gSaveBlock2Ptr->playTimeHours++;
                if (gSaveBlock2Ptr->playTimeHours > 999)
                    PlayTimeCounter_SetToMax();
            }
        }
    }
}

void PlayTimeCounter_SetToMax(void)
{
    sPlayTimeCounterState = MAXED_OUT;
    gSaveBlock2Ptr->playTimeHours = 999;
    gSaveBlock2Ptr->playTimeMinutes = 59;
    gSaveBlock2Ptr->playTimeSeconds = 59;
    gSaveBlock2Ptr->playTimeVBlanks = 59;
}
