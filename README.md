# Pokémon Challenge

https://github.com/alecwshearer/poke-challenge is a fork of https://github.com/pret/pokefirered that is meant to be played by multiple players in a timed challenge. The game doesn't support link battles -- players can battle using [Pokémon Showdown](https://pokemonshowdown.com/).

Major changes:
 - **Deterministic game seed:** Wild Pokémon, trainer Pokémon, and overworld items are randomized based on the Rival name specified at the beginning of the game. All non-key overworld items contain TMs. Some items may be randomly placed on water or in unreachable areas.
 - **Time limit:** After 5 hours pass, the player is locked in the Celadon Department Store. The game clock doesn't decrease while the START menu is active, including when the player is using the Pokémon summary screen, bag, etc. outside of battle.
 - **Level band:** Pokémon stop gaining experience if they become too overleveled compared to the rest of the team. Rare candies also stop working.
 - **Level scaling:** Wild and trainer Pokémon levels increase based on the player's party Pokémon levels and badge count.
 - **Gen 4 Pokemon, Moves, TMs, Abilities, & Items:** Most Gen 4 Pokémon in Gen 1-3 families (e.g. Munchlax, Weavile) are added, with Gen IV HG/SS learnsets and abilities. The Department Store sells Gen 4 battle items, Nature Mints, and Ability Patches. Many Gen IV moves and abilities aren't implemented properly, and instead have placeholder effects. The full Pokémon list at the bottom of this page.
 - **New TMs and learnsets:** 64 TMs are added to the game, bringing the total to 156. Fully evolved Pokémon learn non-TM pre-evolution and egg moves at level 1. TMs can teach moves that were previously only learnable via breeding or move tutors. I.e. if a move is on Smogon it can be learned in this game. A free Move Relearner are added to the Department Store.

Helpful code links:
 - TM list: https://github.com/alecwshearer/poke-challenge/blob/master/all_tms.txt
 - Pokémon level-up learnsets (including level 1): https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/level_up_learnsets.h
 - Pokémon TM01-TM50 and HM learnsets: https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/tmhm_learnsets.h
 - Pokémon TM51-TM92 learnsets: https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/gen4_tmhm_learnsets.h
 - Pokémon TM93-TM156 learnsets: https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/new_tmhm_learnsets.h
 - Pokémon evolution conditions: https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/evolution.h
 - Celadon City 5th floor items: https://github.com/alecwshearer/poke-challenge/blob/master/data/maps/CeladonCity_DepartmentStore_5F/scripts.inc
 - Item prices (CTRL+F for "price"): https://github.com/alecwshearer/poke-challenge/blob/master/src/data/items.json

Other changes:
 - Faster movement, animations, and text. Hold B to use normal walking speed.
 - Start the game with balls, healing items, the Old Rod, 6 Exp Shares, and more.
 - L button maps to A button. In battles, L button auto-fires A and holding R automatically runs away.
 - Gain experience for catching Pokémon.
 - Oak's aides give large sums of money for completing the Pokédex. You can find them in the Department Store and their original locations. The rewards are as follows:
   - 500 for 1 unique species.
   - 5k for 20 unique species.
   - 10k for 40 unique species.
   - 20k for 60 unique species.
   - 40k for 80 unique species.
   - 80k for 100 unique species.
 - Starter Pokémon are randomized based on the game seed. There is still one grass, water, and fire starter, and they will be chosen from the gen 1-3 starters.
 - Move tutors give the player a random TM instead. Purchasable, winnable, and gift TMs are randomized.
 - Gym leaders give the player a Rare Candy in addition to a TM upon earning a badge.
 - Legendary birds give the player a Rare Candy upon defeat.
 - Elite Four members give the player a Rare Candy, Nature Mint, and Ability Patch upon defeat (first time only).
 - Overworld Pokémon (e.g. Snorlax, Articuno) can't be caught.
 - Physical/special split.
 - Pokémon that evolve above level 45 now evolve at level 45 instead.
 - Gift Pokémon are replaced with Spinda.
 - Items aren't sellable.
 - HMs are deletable without the Move Deleter.
 - Flash is no longer required in Rock Tunnel.
 - Old Amber is removed from the game.
 - Trade and happiness evolutions have been replaced with a new "Trade+ Stone", or Sun Stone & Moon Stone in cases where one Pokémon can evolve into multiple others (e.g. Eevee into Espeon or Umbreon). See full list [here](https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/evolution.h).
 - Tyrogue can evolve using Sun Stone (Hitmonchan), Moon Stone (Hitmonlee), and Trade+ Stone (Hitmontop) in addition to his normal level 20 evolution. You can avoid evolving by pressing B if you want to wait to use a stone.
 - Pokémon that evolve by knowing a move (e.g. Ancient Power) instead evovle at the first level that they can know the move.
 - Player finds the Good Rod where the Old Rod used to be, and Super Rod where Good Rod used to be. The Super Rod can also still be found at its original location.
 - The PC is accessible from the START menu. Pokémon no longer heal when sent to the PC.
 - Start with a coin case containing 100 coins. Can no longer buy coins at the Game Corner. Earn 50 pity coins when you run out of coins at the slot machines.
 - The following prizes can be won at the Game Corner:
    - 100 Coins each: TMs for weather moves and Trick Room.
    - 150 Coins each: 6 random TMs, chosen based on the game seed.
    - 150 Coins: Level 1 Pikachu that knows Surf and Fly.
    - 150 Coins: Smeargle (doesn't work in-game, use it in Pokémon Showdown and give it average EVs IVs).
    - 150 Coins: Level 50 Ditto (can only be bought once -- subsequent ones are at level 2).
    - 300 Coins: Level 20 Lapras.
    - 500 Coins: Level 20 Eevee.
 - Once the timer has elapsed, players can see their party's EVs and IVs by holding L and R respectively in the "Pokémon Skills" summary screen.
 - Repel works on all wild Pokémon, regardless of level.
 - Player gets 10x the number of steps in the Safari Zone.
 - Shiny Pokémon odds are increased 10x.
 - Party menu shortcut for giving/taking Exp Shares.
 - The Arena Trap ability has been removed from the game.
 - Safari Balls are 53% more effective, which makes them 15% more effective than Ultra Balls.
 - Pewter, Cerulean, and Vermillion Marts sell Revives.
 - Celadon Mart sells Ultra Balls.
 - All Pokémon that aren't normally catchable in the Safari Zone have a Safari Zone [flee rate](https://bulbapedia.bulbagarden.net/wiki/Kanto_Safari_Zone) of 75 (base 25% chance of fleeing).
 - Some early events are skipped; e.g. the Old Man.
 - Slightly modified wild encounters:
   - Dragonair -> Seadra
   - Wobbuffet -> Dragonair
   - Unown -> Zubat
   - Smeargle -> Zubat
 - Surge's gym "puzzle" is simplified. Player always find the second switch on their first try.
 - Fishing rod hit rate is increased from 50% to 75%.
 - Misc. bugfixes included in the https://github.com/pret/pokefirered `firered_rev1_modern` build.

## Level band / level cap

**TL;DR: Your Pokémon will stop gaining experience if they become too high a level compared to the rest of your team. The game will warn you when this is close to happening. The number of Pokémon considered depends on the number of badges you have.**

A 7 level band is in place. A portion of the player's team must be within 7 levels, inclusive, of each other;
e.g. a range of 30-37 is valid but 30-38 isn’t. The number of Pokémon that must be within the band is equal
to the number of badges the player has plus 1, _with a maximum cutoff of 5_. This means that the 6th Pokémon
is never taken into account, so one low level Pokémon can be safely carried around for HM use, Pickup, etc.

For example, the player has 3 badges, they must have 4 Pokémon within 7 levels (inclusive) of each other. If the
highest leveled Pokémon exceeds the top of the band (also called the _level cap_), it will stop gaining experience
until it is back within the band. Other party Pokémon holding an EXP share will still gain EXP, but the Pokémon
outside of the band won’t gain EXP (and the EXP it would have gained won’t be distributed to the other party Pokémon).

The game will issue warnings when a Pokémon is near the current level cap, or the cap at the next badge. The latter
warning can be disabled in the OPTION menu, but this is not advised.

## Level scaling

### Wild encounters

**TL;DR: Wild Pokémon levels approach your party's average level as you gain badges. Your 1st and 6th highest level Pokémon are excluded from the calculation. Your party size must increase as you earn badges to take advantage of this.**

Wild Pokémon levels are scaled based on party Pokémon levels and the level that the wild Pokémon is supposed to be at. This is done by:
- Summing the levels of your 2nd through 5th highest Pokémon, for as many badges as you have.
  - I.e., your 1st and 6th higest Pokémon are ignored and the others are cycled through from higeest to lowest.
- Adding the level the wild Pokémon is supposed to be at.
- Dividing by the number of badges you have plus 1.

If you have fewer Pokémon in your party than the number of Pokémon required by the formula, empty party slots will be treated as level 2 Pokémon.

#### Example: less than 4 badges

Input:
 - **Number of badges:** 2
 - **Party Pokémon levels:** 20, 17, 16
 - **Level the wild Pokémon is supposed to be at:** 10

Output:
 - **Scaled level:** ⌊(`weighted_team_sum` + `original_wild_level`) / (`badge_count` + 1)⌋ = ⌊((17 + 16) + 10) / 3⌋ = ⌊43 / 3⌋ = 14

#### Example: more than 4 badges

Input:
 - **Number of badges:** 5
 - **Party Pokémon levels:** 28, 24, 22, 21, 20, 12
 - **Level the wild Pokémon is supposed to be at:** 14

Output:
 - **Scaled level:** (`weighted_team_sum` + `original_wild_level`) / (`badge_count` + 1)⌋ = ⌊((24 + 22 + 21 + 20 + 24) + 14) / 6⌋ = ⌊125 / 6⌋ = 20

#### Example: not enough Pokémon in party

Input:
 - **Number of badges:** 2
 - **Party Pokémon levels:** 20, 8
 - **Level the wild Pokémon is supposed to be at:** 6

Output:
 - **Scaled level:** ⌊(`weighted_team_sum` + `original_wild_level`) / (`badge_count` + 1)⌋ = ⌊((8 + **2**) + 6) / 3⌋ = ⌊16 / 3⌋ = 5

#### Exception for high level Pokémon

To disincentivize players from rushing to later routes to catch all of their Pokémon, wild Pokémon that
are supposed to be at level greater than or equal to the player's highest Pokémon will have their level
multiplied by 0.67 before it is plugged into the scaling formula.

### Trainer battles

**TL;DR: Trainer Pokémon levels increase by 0.5 on average for each badge you have.**

Trainer Pokémon levels are increased based on the number of badges the player has. For each odd numbered badge,
odd numbered trainer Pokémon levels are increased by 1. For each even numbered badge, even numbered trainer
Pokémon levels are increased by 1.

#### Example

| Player badge count  | Trainer party levels     |
| ------------------- | ------------------------ |
| 0 (vanilla FireRed) |   10,   10,   11,   11   |
| 1                   |   10, **11**, 11, **12** |
| 2                   | **11**, 11, **12**, 12   |
| 3                   |   11, **12**, 12, **13** |
| 4                   | **12**, 12, **13**, 13   |
| 5                   |   12, **13**, 13, **14** |
| 6                   | **13**, 13, **14**, 14   |
| 7                   |   13, **14**, 14, **15** |
| 8                   | **14**, 14, **15**, 15   |

## Pokémon randomization

Each Pokémon belongs to a group. Based on the Rival name specified at the
beginning of the game, Pokémon encountered in the normal FireRed game are
replaced with Pokémon from their group, as described below.

### Wild encounters

For every "map set" (e.g. Route 1, Mt. Moon) in the game:
  - All fishing Pokémon are deterministically replaced with 1 species from their
  group, regardless of encounter rate.
  - Non-fishing Pokémon with an encounter rate less than or equal to 20% are
  deterministically replaced with 1 species from their group.
  - Non-fishing Pokémon with an encounter rate greater than 20% are deterministically
  replaced with 2 _distinct_ species from their group. There is a ~66% and ~33% chance of
  encountering the 2 replacements, respectively. The Pokémon that comes first the group will
  be the more likely encounter, and one that comes later will be the less likely one.

Pokémon that are catchable via multiple methods (e.g. fishing and walking) in the same route
are replaced with the same Pokémon for each method.

#### Map sets

A "map set" is a collection of game locations that use the same Pokémon
replacement mappings. Note that this is a term specific to this ROM-hack, and is
different than the "map group" concept in the FR/LG source code.

The list of map sets is below. Any map that isn't in this list is in its own map set:
- Mt. Moon 1F, B1F, B2F
- Rock Tunnel 1F, B1F
- Diglett's Cave North Entrace, South Entrance, B1F
- Pokémon Tower 4F, 5F, 6F
- Pokémon Tower 7F, 8F
- Pokémon Mansion 1F, B1F
- Pokémon Mansion 2F, 3F
- Seafoam Islands 1F, B1F, B2F
- Seafoam Islands B3F, B4F
- Victory Road 1F, 2F, 3F
- Mt. Ember Summit Path 1F, 2F, 3F

#### Early boost

Additionally, each non-water game map (not map set) is deterministically assigned a
single Pokémon from the `EarlyBoost` group. The chance of finding one of these
Pokémon starts at 4%, and decreases by 0.5% for each badge you have.

#### Example

![Mt. Moon map set example](map_set_example.png "Mt. Moon Map Set")

In Mt. Moon, each species is replaced with 1 or 2 species from their group, depending
on the catch rate. We see that Paras' second replacement is only encounterable on
floor B1F, because that's the only floor where Paras has a catch rate >20% in the
original game. The EarlyBoost Pokémon will have a rate of 0-4%, depending on the number
of badges the player has (other rates will be adjusted acordingly).

### Trainer battles

Trainer Pokémon are deterministically replaced with a single Pokémon from their group.

### Group list

Pokémon that come first in these group are more likely to be the more common substitution
in situations where a Pokémon maps to 2 species (i.e. for non-fishing Pokémon with a >20% 
encounter rate).

| EarlyBoost |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/406.png 'BUDEW')](https://www.serebii.net/pokedex-dp/406.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/172.png 'PICHU')](https://www.serebii.net/pokedex-dp/172.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/175.png 'TOGEPI')](https://www.serebii.net/pokedex-dp/175.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/298.png 'AZURILL')](https://www.serebii.net/pokedex-dp/298.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/439.png 'MIME_JR')](https://www.serebii.net/pokedex-dp/439.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/238.png 'SMOOCHUM')](https://www.serebii.net/pokedex-dp/238.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/239.png 'ELEKID')](https://www.serebii.net/pokedex-dp/239.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/240.png 'MAGBY')](https://www.serebii.net/pokedex-dp/240.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/001.png 'BULBASAUR')](https://www.serebii.net/pokedex-dp/001.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/252.png 'TREECKO')](https://www.serebii.net/pokedex-dp/252.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/152.png 'CHIKORITA')](https://www.serebii.net/pokedex-dp/152.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/004.png 'CHARMANDER')](https://www.serebii.net/pokedex-dp/004.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/255.png 'TORCHIC')](https://www.serebii.net/pokedex-dp/255.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/155.png 'CYNDAQUIL')](https://www.serebii.net/pokedex-dp/155.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/007.png 'SQUIRTLE')](https://www.serebii.net/pokedex-dp/007.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/258.png 'MUDKIP')](https://www.serebii.net/pokedex-dp/258.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/158.png 'TOTODILE')](https://www.serebii.net/pokedex-dp/158.shtml)|

| NormalFlying1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/261.png 'POOCHYENA')](https://www.serebii.net/pokedex-dp/261.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/263.png 'ZIGZAGOON')](https://www.serebii.net/pokedex-dp/263.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/016.png 'PIDGEY')](https://www.serebii.net/pokedex-dp/016.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/161.png 'SENTRET')](https://www.serebii.net/pokedex-dp/161.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/019.png 'RATTATA')](https://www.serebii.net/pokedex-dp/019.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/163.png 'HOOTHOOT')](https://www.serebii.net/pokedex-dp/163.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/021.png 'SPEAROW')](https://www.serebii.net/pokedex-dp/021.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/276.png 'TAILLOW')](https://www.serebii.net/pokedex-dp/276.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/177.png 'NATU')](https://www.serebii.net/pokedex-dp/177.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/187.png 'HOPPIP')](https://www.serebii.net/pokedex-dp/187.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/190.png 'AIPOM')](https://www.serebii.net/pokedex-dp/190.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/083.png 'FARFETCHD')](https://www.serebii.net/pokedex-dp/083.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/327.png 'SPINDA')](https://www.serebii.net/pokedex-dp/327.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/209.png 'SNUBBULL')](https://www.serebii.net/pokedex-dp/209.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/333.png 'SWABLU')](https://www.serebii.net/pokedex-dp/333.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/216.png 'TEDDIURSA')](https://www.serebii.net/pokedex-dp/216.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/225.png 'DELIBIRD')](https://www.serebii.net/pokedex-dp/225.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/234.png 'STANTLER')](https://www.serebii.net/pokedex-dp/234.shtml)|

| NormalFlying2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/262.png 'MIGHTYENA')](https://www.serebii.net/pokedex-dp/262.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/264.png 'LINOONE')](https://www.serebii.net/pokedex-dp/264.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/017.png 'PIDGEOTTO')](https://www.serebii.net/pokedex-dp/017.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/162.png 'FURRET')](https://www.serebii.net/pokedex-dp/162.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/020.png 'RATICATE')](https://www.serebii.net/pokedex-dp/020.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/022.png 'FEAROW')](https://www.serebii.net/pokedex-dp/022.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/164.png 'NOCTOWL')](https://www.serebii.net/pokedex-dp/164.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/277.png 'SWELLOW')](https://www.serebii.net/pokedex-dp/277.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/178.png 'XATU')](https://www.serebii.net/pokedex-dp/178.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/424.png 'AMBIPOM')](https://www.serebii.net/pokedex-dp/424.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/084.png 'DODUO')](https://www.serebii.net/pokedex-dp/084.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/085.png 'DODRIO')](https://www.serebii.net/pokedex-dp/085.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/210.png 'GRANBULL')](https://www.serebii.net/pokedex-dp/210.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/334.png 'ALTARIA')](https://www.serebii.net/pokedex-dp/334.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/217.png 'URSARING')](https://www.serebii.net/pokedex-dp/217.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/227.png 'SKARMORY')](https://www.serebii.net/pokedex-dp/227.shtml)|

| Cave1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/268.png 'CASCOON')](https://www.serebii.net/pokedex-dp/268.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/041.png 'ZUBAT')](https://www.serebii.net/pokedex-dp/041.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/046.png 'PARAS')](https://www.serebii.net/pokedex-dp/046.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/293.png 'WHISMUR')](https://www.serebii.net/pokedex-dp/293.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/050.png 'DIGLETT')](https://www.serebii.net/pokedex-dp/050.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/296.png 'MAKUHITA')](https://www.serebii.net/pokedex-dp/296.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/299.png 'NOSEPASS')](https://www.serebii.net/pokedex-dp/299.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/304.png 'ARON')](https://www.serebii.net/pokedex-dp/304.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/307.png 'MEDITITE')](https://www.serebii.net/pokedex-dp/307.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/074.png 'GEODUDE')](https://www.serebii.net/pokedex-dp/074.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/206.png 'DUNSPARCE')](https://www.serebii.net/pokedex-dp/206.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/207.png 'GLIGAR')](https://www.serebii.net/pokedex-dp/207.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/213.png 'SHUCKLE')](https://www.serebii.net/pokedex-dp/213.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/215.png 'SNEASEL')](https://www.serebii.net/pokedex-dp/215.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/337.png 'LUNATONE')](https://www.serebii.net/pokedex-dp/337.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/220.png 'SWINUB')](https://www.serebii.net/pokedex-dp/220.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/347.png 'ANORITH')](https://www.serebii.net/pokedex-dp/347.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/361.png 'SNORUNT')](https://www.serebii.net/pokedex-dp/361.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/236.png 'TYROGUE')](https://www.serebii.net/pokedex-dp/236.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/066.png 'MACHOP')](https://www.serebii.net/pokedex-dp/066.shtml)|

| Cave2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/294.png 'LOUDRED')](https://www.serebii.net/pokedex-dp/294.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/051.png 'DUGTRIO')](https://www.serebii.net/pokedex-dp/051.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/297.png 'HARIYAMA')](https://www.serebii.net/pokedex-dp/297.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/305.png 'LAIRON')](https://www.serebii.net/pokedex-dp/305.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/308.png 'MEDICHAM')](https://www.serebii.net/pokedex-dp/308.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/067.png 'MACHOKE')](https://www.serebii.net/pokedex-dp/067.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/197.png 'UMBREON')](https://www.serebii.net/pokedex-dp/197.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/075.png 'GRAVELER')](https://www.serebii.net/pokedex-dp/075.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/208.png 'STEELIX')](https://www.serebii.net/pokedex-dp/208.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/095.png 'ONIX')](https://www.serebii.net/pokedex-dp/095.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/221.png 'PILOSWINE')](https://www.serebii.net/pokedex-dp/221.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/461.png 'WEAVILE')](https://www.serebii.net/pokedex-dp/461.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/106.png 'HITMONLEE')](https://www.serebii.net/pokedex-dp/106.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/107.png 'HITMONCHAN')](https://www.serebii.net/pokedex-dp/107.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/348.png 'ARMALDO')](https://www.serebii.net/pokedex-dp/348.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/472.png 'GLISCOR')](https://www.serebii.net/pokedex-dp/472.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/362.png 'GLALIE')](https://www.serebii.net/pokedex-dp/362.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/476.png 'PROBOPASS')](https://www.serebii.net/pokedex-dp/476.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/237.png 'HITMONTOP')](https://www.serebii.net/pokedex-dp/237.shtml)|

| GrassBug1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/010.png 'CATERPIE')](https://www.serebii.net/pokedex-dp/010.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/011.png 'METAPOD')](https://www.serebii.net/pokedex-dp/011.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/013.png 'WEEDLE')](https://www.serebii.net/pokedex-dp/013.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/014.png 'KAKUNA')](https://www.serebii.net/pokedex-dp/014.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/265.png 'WURMPLE')](https://www.serebii.net/pokedex-dp/265.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/266.png 'SILCOON')](https://www.serebii.net/pokedex-dp/266.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/165.png 'LEDYBA')](https://www.serebii.net/pokedex-dp/165.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/167.png 'SPINARAK')](https://www.serebii.net/pokedex-dp/167.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/290.png 'NINCADA')](https://www.serebii.net/pokedex-dp/290.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/191.png 'SUNKERN')](https://www.serebii.net/pokedex-dp/191.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/193.png 'YANMA')](https://www.serebii.net/pokedex-dp/193.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/313.png 'VOLBEAT')](https://www.serebii.net/pokedex-dp/313.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/204.png 'PINECO')](https://www.serebii.net/pokedex-dp/204.shtml)|

| GrassBug2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/270.png 'LOTAD')](https://www.serebii.net/pokedex-dp/270.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/273.png 'SEEDOT')](https://www.serebii.net/pokedex-dp/273.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/166.png 'LEDIAN')](https://www.serebii.net/pokedex-dp/166.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/168.png 'ARIADOS')](https://www.serebii.net/pokedex-dp/168.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/285.png 'SHROOMISH')](https://www.serebii.net/pokedex-dp/285.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/043.png 'ODDISH')](https://www.serebii.net/pokedex-dp/043.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/048.png 'VENONAT')](https://www.serebii.net/pokedex-dp/048.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/188.png 'SKIPLOOM')](https://www.serebii.net/pokedex-dp/188.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/192.png 'SUNFLORA')](https://www.serebii.net/pokedex-dp/192.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/069.png 'BELLSPROUT')](https://www.serebii.net/pokedex-dp/069.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/314.png 'ILLUMISE')](https://www.serebii.net/pokedex-dp/314.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/315.png 'ROSELIA')](https://www.serebii.net/pokedex-dp/315.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/331.png 'CACNEA')](https://www.serebii.net/pokedex-dp/331.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/214.png 'HERACROSS')](https://www.serebii.net/pokedex-dp/214.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/102.png 'EXEGGCUTE')](https://www.serebii.net/pokedex-dp/102.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/345.png 'LILEEP')](https://www.serebii.net/pokedex-dp/345.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/114.png 'TANGELA')](https://www.serebii.net/pokedex-dp/114.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/123.png 'SCYTHER')](https://www.serebii.net/pokedex-dp/123.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/127.png 'PINSIR')](https://www.serebii.net/pokedex-dp/127.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/371.png 'BAGON')](https://www.serebii.net/pokedex-dp/371.shtml)|

| GrassBug3 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/012.png 'BUTTERFREE')](https://www.serebii.net/pokedex-dp/012.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/015.png 'BEEDRILL')](https://www.serebii.net/pokedex-dp/015.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/267.png 'BEAUTIFLY')](https://www.serebii.net/pokedex-dp/267.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/269.png 'DUSTOX')](https://www.serebii.net/pokedex-dp/269.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/271.png 'LOMBRE')](https://www.serebii.net/pokedex-dp/271.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/274.png 'NUZLEAF')](https://www.serebii.net/pokedex-dp/274.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/407.png 'ROSERADE')](https://www.serebii.net/pokedex-dp/407.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/286.png 'BRELOOM')](https://www.serebii.net/pokedex-dp/286.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/044.png 'GLOOM')](https://www.serebii.net/pokedex-dp/044.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/291.png 'NINJASK')](https://www.serebii.net/pokedex-dp/291.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/189.png 'JUMPLUFF')](https://www.serebii.net/pokedex-dp/189.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/070.png 'WEEPINBELL')](https://www.serebii.net/pokedex-dp/070.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/205.png 'FORRETRESS')](https://www.serebii.net/pokedex-dp/205.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/332.png 'CACTURNE')](https://www.serebii.net/pokedex-dp/332.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/346.png 'CRADILY')](https://www.serebii.net/pokedex-dp/346.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/465.png 'TANGROWTH')](https://www.serebii.net/pokedex-dp/465.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/469.png 'YANMEGA')](https://www.serebii.net/pokedex-dp/469.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/470.png 'LEAFEON')](https://www.serebii.net/pokedex-dp/470.shtml)|

| Spooky1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/035.png 'CLEFAIRY')](https://www.serebii.net/pokedex-dp/035.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/173.png 'CLEFFA')](https://www.serebii.net/pokedex-dp/173.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/174.png 'IGGLYBUFF')](https://www.serebii.net/pokedex-dp/174.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/039.png 'JIGGLYPUFF')](https://www.serebii.net/pokedex-dp/039.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/042.png 'GOLBAT')](https://www.serebii.net/pokedex-dp/042.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/302.png 'SABLEYE')](https://www.serebii.net/pokedex-dp/302.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/303.png 'MAWILE')](https://www.serebii.net/pokedex-dp/303.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/198.png 'MURKROW')](https://www.serebii.net/pokedex-dp/198.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/200.png 'MISDREAVUS')](https://www.serebii.net/pokedex-dp/200.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/343.png 'BALTOY')](https://www.serebii.net/pokedex-dp/343.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/104.png 'CUBONE')](https://www.serebii.net/pokedex-dp/104.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/353.png 'SHUPPET')](https://www.serebii.net/pokedex-dp/353.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/355.png 'DUSKULL')](https://www.serebii.net/pokedex-dp/355.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/092.png 'GASTLY')](https://www.serebii.net/pokedex-dp/092.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/246.png 'LARVITAR')](https://www.serebii.net/pokedex-dp/246.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/142.png 'AERODACTYL')](https://www.serebii.net/pokedex-dp/142.shtml)|

| Spooky2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/169.png 'CROBAT')](https://www.serebii.net/pokedex-dp/169.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/036.png 'CLEFABLE')](https://www.serebii.net/pokedex-dp/036.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/040.png 'WIGGLYTUFF')](https://www.serebii.net/pokedex-dp/040.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/429.png 'MISMAGIUS')](https://www.serebii.net/pokedex-dp/429.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/430.png 'HONCHKROW')](https://www.serebii.net/pokedex-dp/430.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/196.png 'ESPEON')](https://www.serebii.net/pokedex-dp/196.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/093.png 'HAUNTER')](https://www.serebii.net/pokedex-dp/093.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/344.png 'CLAYDOL')](https://www.serebii.net/pokedex-dp/344.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/105.png 'MAROWAK')](https://www.serebii.net/pokedex-dp/105.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/354.png 'BANETTE')](https://www.serebii.net/pokedex-dp/354.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/356.png 'DUSCLOPS')](https://www.serebii.net/pokedex-dp/356.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/478.png 'FROSLASS')](https://www.serebii.net/pokedex-dp/478.shtml)|

| Urban1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/311.png 'PLUSLE')](https://www.serebii.net/pokedex-dp/311.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/081.png 'MAGNEMITE')](https://www.serebii.net/pokedex-dp/081.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/088.png 'GRIMER')](https://www.serebii.net/pokedex-dp/088.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/218.png 'SLUGMA')](https://www.serebii.net/pokedex-dp/218.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/100.png 'VOLTORB')](https://www.serebii.net/pokedex-dp/100.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/109.png 'KOFFING')](https://www.serebii.net/pokedex-dp/109.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/122.png 'MR_MIME')](https://www.serebii.net/pokedex-dp/122.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/124.png 'JYNX')](https://www.serebii.net/pokedex-dp/124.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/125.png 'ELECTABUZZ')](https://www.serebii.net/pokedex-dp/125.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/126.png 'MAGMAR')](https://www.serebii.net/pokedex-dp/126.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/132.png 'DITTO')](https://www.serebii.net/pokedex-dp/132.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/133.png 'EEVEE')](https://www.serebii.net/pokedex-dp/133.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/176.png 'TOGETIC')](https://www.serebii.net/pokedex-dp/176.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/137.png 'PORYGON')](https://www.serebii.net/pokedex-dp/137.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/374.png 'BELDUM')](https://www.serebii.net/pokedex-dp/374.shtml)|

| Urban2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/082.png 'MAGNETON')](https://www.serebii.net/pokedex-dp/082.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/089.png 'MUK')](https://www.serebii.net/pokedex-dp/089.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/101.png 'ELECTRODE')](https://www.serebii.net/pokedex-dp/101.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/219.png 'MAGCARGO')](https://www.serebii.net/pokedex-dp/219.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/110.png 'WEEZING')](https://www.serebii.net/pokedex-dp/110.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/466.png 'ELECTIVIRE')](https://www.serebii.net/pokedex-dp/466.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/467.png 'MAGMORTAR')](https://www.serebii.net/pokedex-dp/467.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/468.png 'TOGEKISS')](https://www.serebii.net/pokedex-dp/468.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/233.png 'PORYGON2')](https://www.serebii.net/pokedex-dp/233.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/135.png 'JOLTEON')](https://www.serebii.net/pokedex-dp/135.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/136.png 'FLAREON')](https://www.serebii.net/pokedex-dp/136.shtml)|

| WaterIce1 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/278.png 'WINGULL')](https://www.serebii.net/pokedex-dp/278.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/170.png 'CHINCHOU')](https://www.serebii.net/pokedex-dp/170.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/283.png 'SURSKIT')](https://www.serebii.net/pokedex-dp/283.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/183.png 'MARILL')](https://www.serebii.net/pokedex-dp/183.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/054.png 'PSYDUCK')](https://www.serebii.net/pokedex-dp/054.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/060.png 'POLIWAG')](https://www.serebii.net/pokedex-dp/060.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/194.png 'WOOPER')](https://www.serebii.net/pokedex-dp/194.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/072.png 'TENTACOOL')](https://www.serebii.net/pokedex-dp/072.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/318.png 'CARVANHA')](https://www.serebii.net/pokedex-dp/318.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/320.png 'WAILMER')](https://www.serebii.net/pokedex-dp/320.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/079.png 'SLOWPOKE')](https://www.serebii.net/pokedex-dp/079.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/086.png 'SEEL')](https://www.serebii.net/pokedex-dp/086.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/211.png 'QWILFISH')](https://www.serebii.net/pokedex-dp/211.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/090.png 'SHELLDER')](https://www.serebii.net/pokedex-dp/090.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/098.png 'KRABBY')](https://www.serebii.net/pokedex-dp/098.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/339.png 'BARBOACH')](https://www.serebii.net/pokedex-dp/339.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/341.png 'CORPHISH')](https://www.serebii.net/pokedex-dp/341.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/222.png 'CORSOLA')](https://www.serebii.net/pokedex-dp/222.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/223.png 'REMORAID')](https://www.serebii.net/pokedex-dp/223.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/349.png 'FEEBAS')](https://www.serebii.net/pokedex-dp/349.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/226.png 'MANTINE')](https://www.serebii.net/pokedex-dp/226.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/116.png 'HORSEA')](https://www.serebii.net/pokedex-dp/116.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/118.png 'GOLDEEN')](https://www.serebii.net/pokedex-dp/118.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/120.png 'STARYU')](https://www.serebii.net/pokedex-dp/120.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/363.png 'SPHEAL')](https://www.serebii.net/pokedex-dp/363.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/366.png 'CLAMPERL')](https://www.serebii.net/pokedex-dp/366.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/129.png 'MAGIKARP')](https://www.serebii.net/pokedex-dp/129.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/369.png 'RELICANTH')](https://www.serebii.net/pokedex-dp/369.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/138.png 'OMANYTE')](https://www.serebii.net/pokedex-dp/138.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/140.png 'KABUTO')](https://www.serebii.net/pokedex-dp/140.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/147.png 'DRATINI')](https://www.serebii.net/pokedex-dp/147.shtml)|

| WaterIce2 |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/279.png 'PELIPPER')](https://www.serebii.net/pokedex-dp/279.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/171.png 'LANTURN')](https://www.serebii.net/pokedex-dp/171.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/284.png 'MASQUERAIN')](https://www.serebii.net/pokedex-dp/284.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/184.png 'AZUMARILL')](https://www.serebii.net/pokedex-dp/184.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/061.png 'POLIWHIRL')](https://www.serebii.net/pokedex-dp/061.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/195.png 'QUAGSIRE')](https://www.serebii.net/pokedex-dp/195.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/073.png 'TENTACRUEL')](https://www.serebii.net/pokedex-dp/073.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/319.png 'SHARPEDO')](https://www.serebii.net/pokedex-dp/319.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/321.png 'WAILORD')](https://www.serebii.net/pokedex-dp/321.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/080.png 'SLOWBRO')](https://www.serebii.net/pokedex-dp/080.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/087.png 'DEWGONG')](https://www.serebii.net/pokedex-dp/087.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/091.png 'CLOYSTER')](https://www.serebii.net/pokedex-dp/091.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/099.png 'KINGLER')](https://www.serebii.net/pokedex-dp/099.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/340.png 'WHISCASH')](https://www.serebii.net/pokedex-dp/340.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/342.png 'CRAWDAUNT')](https://www.serebii.net/pokedex-dp/342.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/224.png 'OCTILLERY')](https://www.serebii.net/pokedex-dp/224.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/350.png 'MILOTIC')](https://www.serebii.net/pokedex-dp/350.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/117.png 'SEADRA')](https://www.serebii.net/pokedex-dp/117.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/471.png 'GLACEON')](https://www.serebii.net/pokedex-dp/471.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/119.png 'SEAKING')](https://www.serebii.net/pokedex-dp/119.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/121.png 'STARMIE')](https://www.serebii.net/pokedex-dp/121.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/364.png 'SEALEO')](https://www.serebii.net/pokedex-dp/364.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/367.png 'HUNTAIL')](https://www.serebii.net/pokedex-dp/367.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/130.png 'GYARADOS')](https://www.serebii.net/pokedex-dp/130.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/368.png 'GOREBYSS')](https://www.serebii.net/pokedex-dp/368.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/131.png 'LAPRAS')](https://www.serebii.net/pokedex-dp/131.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/134.png 'VAPOREON')](https://www.serebii.net/pokedex-dp/134.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/139.png 'OMASTAR')](https://www.serebii.net/pokedex-dp/139.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/141.png 'KABUTOPS')](https://www.serebii.net/pokedex-dp/141.shtml)|

| Overworld |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/023.png 'EKANS')](https://www.serebii.net/pokedex-dp/023.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/025.png 'PIKACHU')](https://www.serebii.net/pokedex-dp/025.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/027.png 'SANDSHREW')](https://www.serebii.net/pokedex-dp/027.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/029.png 'NIDORAN_F')](https://www.serebii.net/pokedex-dp/029.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/032.png 'NIDORAN_M')](https://www.serebii.net/pokedex-dp/032.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/280.png 'RALTS')](https://www.serebii.net/pokedex-dp/280.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/037.png 'VULPIX')](https://www.serebii.net/pokedex-dp/037.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/287.png 'SLAKOTH')](https://www.serebii.net/pokedex-dp/287.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/179.png 'MAREEP')](https://www.serebii.net/pokedex-dp/179.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/052.png 'MEOWTH')](https://www.serebii.net/pokedex-dp/052.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/185.png 'SUDOWOODO')](https://www.serebii.net/pokedex-dp/185.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/300.png 'SKITTY')](https://www.serebii.net/pokedex-dp/300.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/056.png 'MANKEY')](https://www.serebii.net/pokedex-dp/056.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/058.png 'GROWLITHE')](https://www.serebii.net/pokedex-dp/058.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/063.png 'ABRA')](https://www.serebii.net/pokedex-dp/063.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/309.png 'ELECTRIKE')](https://www.serebii.net/pokedex-dp/309.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/316.png 'GULPIN')](https://www.serebii.net/pokedex-dp/316.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/077.png 'PONYTA')](https://www.serebii.net/pokedex-dp/077.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/203.png 'GIRAFARIG')](https://www.serebii.net/pokedex-dp/203.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/322.png 'NUMEL')](https://www.serebii.net/pokedex-dp/322.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/325.png 'SPOINK')](https://www.serebii.net/pokedex-dp/325.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/446.png 'MUNCHLAX')](https://www.serebii.net/pokedex-dp/446.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/335.png 'ZANGOOSE')](https://www.serebii.net/pokedex-dp/335.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/336.png 'SEVIPER')](https://www.serebii.net/pokedex-dp/336.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/096.png 'DROWZEE')](https://www.serebii.net/pokedex-dp/096.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/338.png 'SOLROCK')](https://www.serebii.net/pokedex-dp/338.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/108.png 'LICKITUNG')](https://www.serebii.net/pokedex-dp/108.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/352.png 'KECLEON')](https://www.serebii.net/pokedex-dp/352.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/228.png 'HOUNDOUR')](https://www.serebii.net/pokedex-dp/228.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/231.png 'PHANPY')](https://www.serebii.net/pokedex-dp/231.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/357.png 'TROPIUS')](https://www.serebii.net/pokedex-dp/357.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/358.png 'CHIMECHO')](https://www.serebii.net/pokedex-dp/358.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/359.png 'ABSOL')](https://www.serebii.net/pokedex-dp/359.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/241.png 'MILTANK')](https://www.serebii.net/pokedex-dp/241.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/328.png 'TRAPINCH')](https://www.serebii.net/pokedex-dp/328.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/440.png 'HAPPINY')](https://www.serebii.net/pokedex-dp/440.shtml)|

| SafariZone |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/018.png 'PIDGEOT')](https://www.serebii.net/pokedex-dp/018.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/272.png 'LUDICOLO')](https://www.serebii.net/pokedex-dp/272.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/024.png 'ARBOK')](https://www.serebii.net/pokedex-dp/024.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/026.png 'RAICHU')](https://www.serebii.net/pokedex-dp/026.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/275.png 'SHIFTRY')](https://www.serebii.net/pokedex-dp/275.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/028.png 'SANDSLASH')](https://www.serebii.net/pokedex-dp/028.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/030.png 'NIDORINA')](https://www.serebii.net/pokedex-dp/030.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/031.png 'NIDOQUEEN')](https://www.serebii.net/pokedex-dp/031.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/033.png 'NIDORINO')](https://www.serebii.net/pokedex-dp/033.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/281.png 'KIRLIA')](https://www.serebii.net/pokedex-dp/281.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/034.png 'NIDOKING')](https://www.serebii.net/pokedex-dp/034.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/038.png 'NINETALES')](https://www.serebii.net/pokedex-dp/038.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/288.png 'VIGOROTH')](https://www.serebii.net/pokedex-dp/288.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/045.png 'VILEPLUME')](https://www.serebii.net/pokedex-dp/045.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/180.png 'FLAAFFY')](https://www.serebii.net/pokedex-dp/180.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/181.png 'AMPHAROS')](https://www.serebii.net/pokedex-dp/181.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/047.png 'PARASECT')](https://www.serebii.net/pokedex-dp/047.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/182.png 'BELLOSSOM')](https://www.serebii.net/pokedex-dp/182.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/049.png 'VENOMOTH')](https://www.serebii.net/pokedex-dp/049.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/053.png 'PERSIAN')](https://www.serebii.net/pokedex-dp/053.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/055.png 'GOLDUCK')](https://www.serebii.net/pokedex-dp/055.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/301.png 'DELCATTY')](https://www.serebii.net/pokedex-dp/301.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/057.png 'PRIMEAPE')](https://www.serebii.net/pokedex-dp/057.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/059.png 'ARCANINE')](https://www.serebii.net/pokedex-dp/059.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/064.png 'KADABRA')](https://www.serebii.net/pokedex-dp/064.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/310.png 'MANECTRIC')](https://www.serebii.net/pokedex-dp/310.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/071.png 'VICTREEBEL')](https://www.serebii.net/pokedex-dp/071.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/199.png 'SLOWKING')](https://www.serebii.net/pokedex-dp/199.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/317.png 'SWALOT')](https://www.serebii.net/pokedex-dp/317.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/078.png 'RAPIDASH')](https://www.serebii.net/pokedex-dp/078.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/323.png 'CAMERUPT')](https://www.serebii.net/pokedex-dp/323.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/324.png 'TORKOAL')](https://www.serebii.net/pokedex-dp/324.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/326.png 'GRUMPIG')](https://www.serebii.net/pokedex-dp/326.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/212.png 'SCIZOR')](https://www.serebii.net/pokedex-dp/212.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/097.png 'HYPNO')](https://www.serebii.net/pokedex-dp/097.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/103.png 'EXEGGUTOR')](https://www.serebii.net/pokedex-dp/103.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/463.png 'LICKILICKY')](https://www.serebii.net/pokedex-dp/463.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/111.png 'RHYHORN')](https://www.serebii.net/pokedex-dp/111.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/112.png 'RHYDON')](https://www.serebii.net/pokedex-dp/112.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/113.png 'CHANSEY')](https://www.serebii.net/pokedex-dp/113.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/115.png 'KANGASKHAN')](https://www.serebii.net/pokedex-dp/115.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/229.png 'HOUNDOOM')](https://www.serebii.net/pokedex-dp/229.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/232.png 'DONPHAN')](https://www.serebii.net/pokedex-dp/232.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/365.png 'WALREIN')](https://www.serebii.net/pokedex-dp/365.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/128.png 'TAUROS')](https://www.serebii.net/pokedex-dp/128.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/242.png 'BLISSEY')](https://www.serebii.net/pokedex-dp/242.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/143.png 'SNORLAX')](https://www.serebii.net/pokedex-dp/143.shtml)|

| CeruleanCave |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/329.png 'VIBRAVA')](https://www.serebii.net/pokedex-dp/329.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/372.png 'SHELGON')](https://www.serebii.net/pokedex-dp/372.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/375.png 'METANG')](https://www.serebii.net/pokedex-dp/375.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/247.png 'PUPITAR')](https://www.serebii.net/pokedex-dp/247.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/148.png 'DRAGONAIR')](https://www.serebii.net/pokedex-dp/148.shtml)|

| NotCatchable |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/282.png 'GARDEVOIR')](https://www.serebii.net/pokedex-dp/282.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/289.png 'SLAKING')](https://www.serebii.net/pokedex-dp/289.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/295.png 'EXPLOUD')](https://www.serebii.net/pokedex-dp/295.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/186.png 'POLITOED')](https://www.serebii.net/pokedex-dp/186.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/306.png 'AGGRON')](https://www.serebii.net/pokedex-dp/306.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/062.png 'POLIWRATH')](https://www.serebii.net/pokedex-dp/062.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/065.png 'ALAKAZAM')](https://www.serebii.net/pokedex-dp/065.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/068.png 'MACHAMP')](https://www.serebii.net/pokedex-dp/068.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/076.png 'GOLEM')](https://www.serebii.net/pokedex-dp/076.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/330.png 'FLYGON')](https://www.serebii.net/pokedex-dp/330.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/094.png 'GENGAR')](https://www.serebii.net/pokedex-dp/094.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/462.png 'MAGNEZONE')](https://www.serebii.net/pokedex-dp/462.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/464.png 'RHYPERIOR')](https://www.serebii.net/pokedex-dp/464.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/230.png 'KINGDRA')](https://www.serebii.net/pokedex-dp/230.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/473.png 'MAMOSWINE')](https://www.serebii.net/pokedex-dp/473.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/474.png 'PORYGON_Z')](https://www.serebii.net/pokedex-dp/474.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/475.png 'GALLADE')](https://www.serebii.net/pokedex-dp/475.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/477.png 'DUSKNOIR')](https://www.serebii.net/pokedex-dp/477.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/373.png 'SALAMENCE')](https://www.serebii.net/pokedex-dp/373.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/376.png 'METAGROSS')](https://www.serebii.net/pokedex-dp/376.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/248.png 'TYRANITAR')](https://www.serebii.net/pokedex-dp/248.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/149.png 'DRAGONITE')](https://www.serebii.net/pokedex-dp/149.shtml)|

| Legendary |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/144.png 'ARTICUNO')](https://www.serebii.net/pokedex-dp/144.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/145.png 'ZAPDOS')](https://www.serebii.net/pokedex-dp/145.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/146.png 'MOLTRES')](https://www.serebii.net/pokedex-dp/146.shtml)|

| NotInGame |
| --- |
|[![](https://www.serebii.net/pokedex-swsh/icon/292.png 'SHEDINJA')](https://www.serebii.net/pokedex-dp/292.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/433.png 'CHINGLING')](https://www.serebii.net/pokedex-dp/433.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/312.png 'MINUN')](https://www.serebii.net/pokedex-dp/312.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/438.png 'BONSLY')](https://www.serebii.net/pokedex-dp/438.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/201.png 'UNOWN')](https://www.serebii.net/pokedex-dp/201.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/202.png 'WOBBUFFET')](https://www.serebii.net/pokedex-dp/202.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/458.png 'MANTYKE')](https://www.serebii.net/pokedex-dp/458.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/351.png 'CASTFORM')](https://www.serebii.net/pokedex-dp/351.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/360.png 'WYNAUT')](https://www.serebii.net/pokedex-dp/360.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/235.png 'SMEARGLE')](https://www.serebii.net/pokedex-dp/235.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/370.png 'LUVDISC')](https://www.serebii.net/pokedex-dp/370.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/243.png 'RAIKOU')](https://www.serebii.net/pokedex-dp/243.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/244.png 'ENTEI')](https://www.serebii.net/pokedex-dp/244.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/245.png 'SUICUNE')](https://www.serebii.net/pokedex-dp/245.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/377.png 'REGIROCK')](https://www.serebii.net/pokedex-dp/377.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/378.png 'REGICE')](https://www.serebii.net/pokedex-dp/378.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/379.png 'REGISTEEL')](https://www.serebii.net/pokedex-dp/379.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/380.png 'LATIAS')](https://www.serebii.net/pokedex-dp/380.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/249.png 'LUGIA')](https://www.serebii.net/pokedex-dp/249.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/381.png 'LATIOS')](https://www.serebii.net/pokedex-dp/381.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/250.png 'HO_OH')](https://www.serebii.net/pokedex-dp/250.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/382.png 'KYOGRE')](https://www.serebii.net/pokedex-dp/382.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/251.png 'CELEBI')](https://www.serebii.net/pokedex-dp/251.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/383.png 'GROUDON')](https://www.serebii.net/pokedex-dp/383.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/384.png 'DUSKNOIR')](https://www.serebii.net/pokedex-dp/384.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/385.png 'JIRACHI')](https://www.serebii.net/pokedex-dp/385.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/150.png 'MEWTWO')](https://www.serebii.net/pokedex-dp/150.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/151.png 'MEW')](https://www.serebii.net/pokedex-dp/151.shtml)[![](https://www.serebii.net/pokedex-swsh/icon/386.png 'DEOXYS')](https://www.serebii.net/pokedex-dp/386.shtml)|

