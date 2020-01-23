#ifndef GUARD_RENEWABLE_HIDDEN_ITEMS_H
#define GUARD_RENEWABLE_HIDDEN_ITEMS_H

bool32 ReadTrainerHillAndValidate(void);
void IncrementRenewableHiddenItemStepCounter(void);
void TryRegenerateRenewableHiddenItems(void);
void SetAllRenewableItemFlags(void);

#endif //GUARD_RENEWABLE_HIDDEN_ITEMS_H
