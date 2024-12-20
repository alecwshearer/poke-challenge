# import markdown

pokes = [
  ('NONE', 'NULL'),

  ('BULBASAUR', 'GrassStarter1'),
  ('IVYSAUR', 'GrassStarter2'),
  ('VENUSAUR', 'GrassStarter3'),

  ('CHARMANDER', 'FireStarter1'),
  ('CHARMELEON', 'FireStarter2'),
  ('CHARIZARD', 'FireStarter3'),

  ('SQUIRTLE', 'WaterStarter1'),
  ('WARTORTLE', 'WaterStarter2'),
  ('BLASTOISE', 'WaterStarter3'),

  ('CATERPIE', 'Bug1'),
  ('METAPOD', 'Bug2'),
  ('BUTTERFREE', 'Bug3'),

  ('WEEDLE', 'Bug1'),
  ('KAKUNA', 'Bug2'),
  ('BEEDRILL', 'Bug3'),

  ('PIDGEY', 'Bird1'),
  ('PIDGEOTTO', 'Bird2'),
  ('PIDGEOT', 'SafariZone'),

  ('RATTATA', 'Normal1'),
  ('RATICATE', 'Normal2'),

  ('SPEAROW', 'Bird1'),
  ('FEAROW', 'Bird2'),

  ('EKANS', 'Overworld'),
  ('ARBOK', 'SafariZone'),

  ('PIKACHU', 'Overworld'),
  ('RAICHU', 'SafariZone'),

  ('SANDSHREW', 'Overworld'),
  ('SANDSLASH', 'SafariZone'),

  ('NIDORAN_F', 'Overworld'),
  ('NIDORINA', 'SafariZone'),
  ('NIDOQUEEN', 'SafariZone'),

  ('NIDORAN_M', 'Overworld'),
  ('NIDORINO', 'SafariZone'),
  ('NIDOKING', 'SafariZone'),

  ('CLEFAIRY', 'Spooky1'),
  ('CLEFABLE', 'Spooky2'),

  ('VULPIX', 'Overworld'),
  ('NINETALES', 'SafariZone'),

  ('JIGGLYPUFF', 'Spooky1'),
  ('WIGGLYTUFF', 'Spooky2'),

  ('ZUBAT', 'Spooky1'),
  ('GOLBAT', 'Spooky1'),

  ('ODDISH', 'GrassRareBug1'),
  ('GLOOM', 'GrassRareBug2'),
  ('VILEPLUME', 'SafariZone'),

  ('PARAS', 'Bug2'),
  ('PARASECT', 'Bug3'),

  ('VENONAT', 'Bug1'),
  ('VENOMOTH', 'Bug3'),

  ('DIGLETT', 'Cave1'),
  ('DUGTRIO', 'Cave2'),

  ('MEOWTH', 'Normal1'),
  ('PERSIAN', 'Normal2'),

  ('PSYDUCK', 'LeggedWater1'),
  ('GOLDUCK', 'LeggedWater2'),

  ('MANKEY', 'Overworld'),
  ('PRIMEAPE', 'SafariZone'),

  ('GROWLITHE', 'Overworld'),
  ('ARCANINE', 'SafariZone'),

  ('POLIWAG', 'LeggedWater1'),
  ('POLIWHIRL', 'LeggedWater2'),
  ('POLIWRATH', 'SafariZone'),

  ('ABRA', 'Overworld'),
  ('KADABRA', 'CeruleanCave'),
  ('ALAKAZAM', 'NotCatchable'),

  ('MACHOP', 'Cave1'),
  ('MACHOKE', 'Cave2'),
  ('MACHAMP', 'NotCatchable'),

  ('BELLSPROUT', 'GrassRareBug1'),
  ('WEEPINBELL', 'GrassRareBug2'),
  ('VICTREEBEL', 'SafariZone'),

  ('TENTACOOL', 'Fish1'),
  ('TENTACRUEL', 'Fish2'),

  ('GEODUDE', 'Cave1'),
  ('GRAVELER', 'Cave2'),
  ('GOLEM', 'CeruleanCave'),

  ('PONYTA', 'Overworld'),
  ('RAPIDASH', 'SafariZone'),

  ('SLOWPOKE', 'LeggedWater1'),
  ('SLOWBRO', 'LeggedWater2'),

  ('MAGNEMITE', 'Urban1'),
  ('MAGNETON', 'Urban2'),

  ('FARFETCHD', 'Bird1'),

  ('DODUO', 'Bird1'),
  ('DODRIO', 'Bird2'),

  ('SEEL', 'LeggedWater1'),
  ('DEWGONG', 'LeggedWater2'),

  ('GRIMER', 'Urban1'),
  ('MUK', 'Urban2'),

  ('SHELLDER', 'Fish1'),
  ('CLOYSTER', 'LeggedWater2'),

  ('GASTLY', 'Spooky1'),
  ('HAUNTER', 'Spooky2'),
  ('GENGAR', 'NotCatchable'),

  ('ONIX', 'Cave2'),

  ('DROWZEE', 'Overworld'),
  ('HYPNO', 'SafariZone'),

  ('KRABBY', 'Fish1'),
  ('KINGLER', 'Fish2'),

  ('VOLTORB', 'Urban1'),
  ('ELECTRODE', 'Urban2'),

  ('EXEGGCUTE', 'GrassRareBug1'),
  ('EXEGGUTOR', 'SafariZone'),

  ('CUBONE', 'Spooky1'),
  ('MAROWAK', 'Spooky2'),

  ('HITMONLEE', 'Cave2'),
  ('HITMONCHAN', 'Cave2'),

  ('LICKITUNG', 'Overworld'),

  ('KOFFING', 'Urban1'),
  ('WEEZING', 'Urban2'),

  ('RHYHORN', 'Overworld'),
  ('RHYDON', 'SafariZone'),

  ('CHANSEY', 'Overworld'),

  ('TANGELA', 'GrassRareBug1'),

  ('KANGASKHAN', 'Overworld'),

  ('HORSEA', 'Fish1'),
  ('SEADRA', 'Fish2'),

  ('GOLDEEN', 'Fish1'),
  ('SEAKING', 'Fish2'),

  ('STARYU', 'LeggedWater1'),
  ('STARMIE', 'LeggedWater2'),

  ('MR_MIME', 'Urban2'),

  ('SCYTHER', 'GrassRareBug2'),

  ('JYNX', 'Urban2'),

  ('ELECTABUZZ', 'Urban2'),

  ('MAGMAR', 'Urban2'),

  ('PINSIR', 'GrassRareBug2'),

  ('TAUROS', 'Overworld'),

  ('MAGIKARP', 'Fish1'),
  ('GYARADOS', 'Fish2'),

  ('LAPRAS', 'SafariZone'),

  ('DITTO', 'Urban1'),

  ('EEVEE', 'Rare2Percent'),
  ('VAPOREON', 'Eevee'),
  ('JOLTEON', 'Eevee'),
  ('FLAREON', 'Eevee'),

  ('PORYGON', 'Urban1'),

  ('OMANYTE', 'LeggedWater1'),
  ('OMASTAR', 'LeggedWater2'),

  ('KABUTO', 'Spooky1'),
  ('KABUTOPS', 'LeggedWater2'),

  ('AERODACTYL', 'SafariZone'),

  ('SNORLAX', 'SafariZone'),

  ('ARTICUNO', 'Legendary'),
  ('ZAPDOS', 'Legendary'),
  ('MOLTRES', 'Legendary'),

  ('DRATINI', 'Rare2Percent'),
  ('DRAGONAIR', 'CeruleanCave'),
  ('DRAGONITE', 'NotCatchable'),

  ('MEWTWO', 'Uber'),

  ('MEW', 'Uber'),

  ('CHIKORITA', 'GrassStarter1'),
  ('BAYLEEF', 'GrassStarter2'),
  ('MEGANIUM', 'GrassStarter3'),

  ('CYNDAQUIL', 'FireStarter1'),
  ('QUILAVA', 'FireStarter2'),
  ('TYPHLOSION', 'FireStarter3'),

  ('TOTODILE', 'WaterStarter1'),
  ('CROCONAW', 'WaterStarter2'),
  ('FERALIGATR', 'WaterStarter3'),

  ('SENTRET', 'Normal1'),
  ('FURRET', 'Normal2'),

  ('HOOTHOOT', 'Bird1'),
  ('NOCTOWL', 'Bird2'),

  ('LEDYBA', 'Bug1'),
  ('LEDIAN', 'Bug3'),

  ('SPINARAK', 'Bug1'),
  ('ARIADOS', 'Bug3'),

  ('CROBAT', 'SafariZone'),

  ('CHINCHOU', 'Fish1'),
  ('LANTURN', 'Fish2'),

  ('PICHU', 'GameCorner'),
  ('CLEFFA', 'GameCorner'),
  ('IGGLYBUFF', 'GameCorner'),

  ('TOGEPI', 'GameCorner'),
  ('TOGETIC', 'Rare2Percent'),

  ('NATU', 'Overworld'),
  ('XATU', 'SafariZone'),

  ('MAREEP', 'Overworld'),
  ('FLAAFFY', 'SafariZone'),
  ('AMPHAROS', 'SafariZone'),

  ('BELLOSSOM', 'SafariZone'),

  ('MARILL', 'LeggedWater1'),
  ('AZUMARILL', 'LeggedWater2'),

  ('SUDOWOODO', 'Overworld'),

  ('POLITOED', 'LeggedWater2'),

  ('HOPPIP', 'GrassRareBug1'),
  ('SKIPLOOM', 'GrassRareBug2'),
  ('JUMPLUFF', 'SafariZone'),

  ('AIPOM', 'Normal1'),

  ('SUNKERN', 'GrassRareBug1'),
  ('SUNFLORA', 'GrassRareBug2'),

  ('YANMA', 'Bug1'),

  ('WOOPER', 'LeggedWater1'),
  ('QUAGSIRE', 'LeggedWater2'),

  ('ESPEON', 'Eevee'),
  ('UMBREON', 'Eevee'),

  ('MURKROW', 'Bird1'),

  ('SLOWKING', 'SafariZone'),

  ('MISDREAVUS', 'Spooky2'),

  ('UNOWN', 'Gift'),

  ('WOBBUFFET', 'Banned'),

  ('GIRAFARIG', 'Overworld'),

  ('PINECO', 'Bug1'),
  ('FORRETRESS', 'Bug3'),

  ('DUNSPARCE', 'Spooky1'),

  ('GLIGAR', 'Cave1'),

  ('STEELIX', 'CeruleanCave'),

  ('SNUBBULL', 'Normal1'),
  ('GRANBULL', 'Normal2'),

  ('QWILFISH', 'Fish1'),

  ('SCIZOR', 'NotCatchable'),

  ('SHUCKLE', 'Cave1'),

  ('HERACROSS', 'GrassRareBug2'),

  ('SNEASEL', 'Cave2'),

  ('TEDDIURSA', 'Normal2'),
  ('URSARING', 'SafariZone'),

  ('SLUGMA', 'Urban1'),
  ('MAGCARGO', 'Urban2'),

  ('SWINUB', 'Cave1'),
  ('PILOSWINE', 'CeruleanCave'),

  ('CORSOLA', 'Fish1'),

  ('REMORAID', 'Fish1'),
  ('OCTILLERY', 'Fish2'),

  ('DELIBIRD', 'Bird2'),

  ('MANTINE', 'Fish1'),

  ('SKARMORY', 'Bird2'),

  ('HOUNDOUR', 'Overworld'),
  ('HOUNDOOM', 'SafariZone'),

  ('KINGDRA', 'NotCatchable'),

  ('PHANPY', 'Overworld'),
  ('DONPHAN', 'SafariZone'),

  ('PORYGON2', 'Urban2'),

  ('STANTLER', 'Normal2'),
  ('SMEARGLE', 'Rare2Percent'),

  ('TYROGUE', 'Cave1'),

  ('HITMONTOP', 'Cave2'),

  ('SMOOCHUM', 'Urban1'),

  ('ELEKID', 'Urban1'),

  ('MAGBY', 'Urban1'),

  ('MILTANK', 'Overworld'),

  ('BLISSEY', 'NotCatchable'),

  ('RAIKOU', 'Legendary'),
  ('ENTEI', 'Legendary'),
  ('SUICUNE', 'Legendary'),

  ('LARVITAR', 'Rare2Percent'),
  ('PUPITAR', 'CeruleanCave'),
  ('TYRANITAR', 'NotCatchable'),

  ('LUGIA', 'Uber'),
  ('HO_OH', 'Uber'),

  ('CELEBI', 'Legendary'),

  ('TREECKO', 'GrassStarter1'),
  ('GROVYLE', 'GrassStarter2'),
  ('SCEPTILE', 'GrassStarter3'),

  ('TORCHIC', 'FireStarter1'),
  ('COMBUSKEN', 'FireStarter2'),
  ('BLAZIKEN', 'FireStarter3'),

  ('MUDKIP', 'WaterStarter1'),
  ('MARSHTOMP', 'WaterStarter2'),
  ('SWAMPERT', 'WaterStarter3'),

  ('POOCHYENA', 'Normal1'),
  ('MIGHTYENA', 'Normal2'),

  ('ZIGZAGOON', 'Normal1'),
  ('LINOONE', 'Normal2'),

  ('WURMPLE', 'Bug1'),
  ('SILCOON', 'Bug2'),
  ('BEAUTIFLY', 'Bug3'),
  ('CASCOON', 'Bug2'),
  ('DUSTOX', 'Bug3'),

  ('LOTAD', 'GrassRareBug1'),
  ('LOMBRE', 'GrassRareBug2'),
  ('LUDICOLO', 'SafariZone'),

  ('SEEDOT', 'GrassRareBug1'),
  ('NUZLEAF', 'GrassRareBug2'),
  ('SHIFTRY', 'SafariZone'),

  ('TAILLOW', 'Bird1'),
  ('SWELLOW', 'Bird2'),

  ('WINGULL', 'LeggedWater1'),
  ('PELIPPER', 'LeggedWater2'),

  ('RALTS', 'Overworld'),
  ('KIRLIA', 'CeruleanCave'),
  ('GARDEVOIR', 'NotCatchable'),

  ('SURSKIT', 'LeggedWater1'),
  ('MASQUERAIN', 'LeggedWater2'),

  ('SHROOMISH', 'GrassRareBug1'),
  ('BRELOOM', 'SafariZone'),

  ('SLAKOTH', 'Rare2Percent'),
  ('VIGOROTH', 'CeruleanCave'),
  ('SLAKING', 'NotCatchable'),

  ('NINCADA', 'Bug2'),
  ('NINJASK', 'Bug3'),
  ('SHEDINJA', 'Banned'),

  ('WHISMUR', 'Cave1'),
  ('LOUDRED', 'Cave2'),
  ('EXPLOUD', 'CeruleanCave'),

  ('MAKUHITA', 'Cave1'),
  ('HARIYAMA', 'Cave2'),

  ('AZURILL', 'GameCorner'),

  ('NOSEPASS', 'Cave1'),

  ('SKITTY', 'Normal1'),
  ('DELCATTY', 'Normal2'),

  ('SABLEYE', 'Spooky1'),

  ('MAWILE', 'Spooky1'),

  ('ARON', 'Cave1'),
  ('LAIRON', 'Cave2'),
  ('AGGRON', 'CeruleanCave'),

  ('MEDITITE', 'Cave1'),
  ('MEDICHAM', 'CeruleanCave'),

  ('ELECTRIKE', 'Overworld'),
  ('MANECTRIC', 'SafariZone'),

  ('PLUSLE', 'Urban1'),

  ('MINUN', 'Urban1'),

  ('VOLBEAT', 'Bug2'),

  ('ILLUMISE', 'Bug2'),

  ('ROSELIA', 'GrassRareBug1'),

  ('GULPIN', 'Overworld'),
  ('SWALOT', 'SafariZone'),

  ('CARVANHA', 'Fish1'),
  ('SHARPEDO', 'Fish2'),

  ('WAILMER', 'Fish1'),
  ('WAILORD', 'Fish2'),

  ('NUMEL', 'Overworld'),
  ('CAMERUPT', 'SafariZone'),

  ('TORKOAL', 'Overworld'),

  ('SPOINK', 'Overworld'),
  ('GRUMPIG', 'SafariZone'),

  ('SPINDA', 'Normal1'),

  ('TRAPINCH', 'Rare2Percent'),
  ('VIBRAVA', 'CeruleanCave'),
  ('FLYGON', 'NotCatchable'),

  ('CACNEA', 'GrassRareBug1'),
  ('CACTURNE', 'GrassRareBug2'),

  ('SWABLU', 'Rare2Percent'),
  ('ALTARIA', 'NotCatchable'),

  ('ZANGOOSE', 'Overworld'),

  ('SEVIPER', 'Overworld'),

  ('LUNATONE', 'Spooky1'),

  ('SOLROCK', 'Overworld'),

  ('BARBOACH', 'Fish1'),
  ('WHISCASH', 'Fish2'),

  ('CORPHISH', 'Fish1'),
  ('CRAWDAUNT', 'Fish2'),

  ('BALTOY', 'Spooky1'),
  ('CLAYDOL', 'Spooky2'),

  ('LILEEP', 'Cave1'),
  ('CRADILY', 'CeruleanCave'),

  ('ANORITH', 'Cave1'),
  ('ARMALDO', 'CeruleanCave'),

  ('FEEBAS', 'Fish1'),
  ('MILOTIC', 'NotCatchable'),

  ('CASTFORM', 'Rare2Percent'),

  ('KECLEON', 'Overworld'),

  ('SHUPPET', 'Spooky1'),
  ('BANETTE', 'Spooky2'),

  ('DUSKULL', 'Spooky1'),
  ('DUSCLOPS', 'Spooky2'),

  ('TROPIUS', 'Overworld'),

  ('CHIMECHO', 'Overworld'),

  ('ABSOL', 'Overworld'),

  ('WYNAUT', 'Banned'),

  ('SNORUNT', 'Cave2'),
  ('GLALIE', 'NotCatchable'),

  ('SPHEAL', 'LeggedWater1'),
  ('SEALEO', 'LeggedWater2'),
  ('WALREIN', 'SafariZone'),

  ('CLAMPERL', 'Fish1'),
  ('HUNTAIL', 'Fish2'),
  ('GOREBYSS', 'Fish2'),

  ('RELICANTH', 'Fish1'),

  ('LUVDISC', 'Fish1'),

  ('BAGON', 'Rare2Percent'),
  ('SHELGON', 'CeruleanCave'),
  ('SALAMENCE', 'NotCatchable'),

  ('BELDUM', 'Rare2Percent'),
  ('METANG', 'CeruleanCave'),
  ('METAGROSS', 'NotCatchable'),

  ('REGIROCK', 'Legendary'),
  ('REGICE', 'Legendary'),
  ('REGISTEEL', 'Legendary'),

  ('LATIAS', 'Legendary'),
  ('LATIOS', 'Legendary'),

  ('KYOGRE', 'Uber'),
  ('GROUDON', 'Uber'),
  ('RAYQUAZA', 'Uber'),

  ('JIRACHI', 'Legendary'),

  ('DEOXYS', 'Uber'),

  ('OLD_UNOWN_B', 'NULL'),
  ('OLD_UNOWN_C', 'NULL'),
  ('OLD_UNOWN_D', 'NULL'),
  ('OLD_UNOWN_E', 'NULL'),
  ('OLD_UNOWN_F', 'NULL'),
  ('OLD_UNOWN_G', 'NULL'),
  ('OLD_UNOWN_H', 'NULL'),
  ('OLD_UNOWN_I', 'NULL'),
  ('OLD_UNOWN_J', 'NULL'),
  ('OLD_UNOWN_K', 'NULL'),
  ('OLD_UNOWN_L', 'NULL'),
  ('OLD_UNOWN_M', 'NULL'),
  ('OLD_UNOWN_N', 'NULL'),
  ('OLD_UNOWN_O', 'NULL'),
  ('OLD_UNOWN_P', 'NULL'),
  ('OLD_UNOWN_Q', 'NULL'),
  ('OLD_UNOWN_R', 'NULL'),
  ('OLD_UNOWN_S', 'NULL'),
  ('OLD_UNOWN_T', 'NULL'),
  ('OLD_UNOWN_U', 'NULL'),
  ('OLD_UNOWN_V', 'NULL'),
  ('OLD_UNOWN_W', 'NULL'),
  ('OLD_UNOWN_X', 'NULL'),
  ('OLD_UNOWN_Y', 'NULL'),
  ('OLD_UNOWN_Z', 'NULL'),

  ('EGG', 'NULL'),
  ('UNOWN_B', 'NULL'),
  ('UNOWN_C', 'NULL'),
  ('UNOWN_D', 'NULL'),
  ('UNOWN_E', 'NULL'),
  ('UNOWN_F', 'NULL'),
  ('UNOWN_G', 'NULL'),
  ('UNOWN_H', 'NULL'),
  ('UNOWN_I', 'NULL'),
  ('UNOWN_J', 'NULL'),
  ('UNOWN_K', 'NULL'),
  ('UNOWN_L', 'NULL'),
  ('UNOWN_M', 'NULL'),
  ('UNOWN_N', 'NULL'),
  ('UNOWN_O', 'NULL'),
  ('UNOWN_P', 'NULL'),
  ('UNOWN_Q', 'NULL'),
  ('UNOWN_R', 'NULL'),
  ('UNOWN_S', 'NULL'),
  ('UNOWN_T', 'NULL'),
  ('UNOWN_U', 'NULL'),
  ('UNOWN_V', 'NULL'),
  ('UNOWN_W', 'NULL'),
  ('UNOWN_X', 'NULL'),
  ('UNOWN_Y', 'NULL'),
  ('UNOWN_Z', 'NULL'),
  ('UNOWN_EMARK', 'NULL'),
  ('UNOWN_QMARK', 'NULL'),
]

c_top = '''
#ifndef GUARD_AUTOGENERATED_POKEMON_GROUPS_H
#define GUARD_AUTOGENERATED_POKEMON_GROUPS_H

// +------------------------------------------------------+
// | !!! AUTOGENERATED BY generate_docs_and_groups.py !!! |
// +------------------------------------------------------+

#include "data.h"
#include "global.h"

'''

c_bottom = 'const u16* const gMonGroups[] =\n{\n  [SPECIES_NONE] = NULL,\n'

groups = {
  'Normal1': [],
  'Normal2': [],
  'Bird1': [],
  'Bird2': [],
  'Bug1': [],
  'Bug2': [],
  'Bug3': [],
  'Cave1': [],
  'Cave2': [],
  'Spooky1': [],
  'Spooky2': [],
  'GrassRareBug1': [],
  'GrassRareBug2': [],
  'Urban1': [],
  'Urban2': [],
  'Overworld': [],
  'SafariZone': [],
  'Fish1': [],
  'Fish2': [],
  'LeggedWater1': [],
  'LeggedWater2': [],
  'Rare2Percent': [],
  'GameCorner': [],
  'Gift': [],
  'CeruleanCave': [],
}

for pokedex_num in range (1, 387):
  (poke_name, group_name) = pokes[pokedex_num]
  if group_name not in groups:
    groups[group_name] = []
  groups[group_name].append((pokedex_num, poke_name))
  c_bottom += '  [SPECIES_' + poke_name + '] = gGroup_' + group_name + ',\n'
c_bottom += '};\n'

for starter_group in ['GrassStarter1', 'FireStarter1', 'WaterStarter1']:
  groups['Rare2Percent'].extend(groups[starter_group])

md = ''

for group_name, pokes_with_id in groups.items():
  if group_name == 'NULL':
      continue

  not_starter_group = 'Starter' not in group_name

  if not_starter_group:
    md += '| ' + group_name + ' |\n| --- |\n|'
  c = 'const u16 gGroup_' + group_name + '[] =\n{\n  /*SIZE=*/' + str(len(pokes_with_id)) + ',\n'

  for (poke_id, poke_name) in pokes_with_id:
    if not_starter_group:
      dex_num = str(poke_id).rjust(3, '0')
      image_url = 'https://www.serebii.net/pokedex-swsh/icon/' + dex_num + '.png'
      link_url = 'https://www.serebii.net/pokedex-dp/' + dex_num + '.shtml'
      md += '[![](' + image_url + " '" + poke_name + "')](" + link_url + ')'
    c += '  SPECIES_' + poke_name + ',\n'

  if not_starter_group:
    md += '|\n\n'
  c_top += c + '};\n\n'

with open('README.md', 'w') as md_file:
  md_file.write('''# Pokémon Challenge

A fork of https://github.com/pret/pokefirered that is meant to be played by multiple players in a timed challenge. The game doesn't support link battles -- players can battle using [Pokémon Showdown](https://pokemonshowdown.com/).

Major changes:
 - **Deterministic game seed:** Wild Pokémon, trainer Pokémon, and overworld items are randomized based on the Rival name specified at the beginning of the game. All non-key overworld items contain TMs. Some items may be randomly placed on water or in unreachable areas.
 - **Time limit:** After 5 hours pass, the player is locked in the Celadon Department Store. A PC and free Move Relearner are added to the Department Store. The game clock doesn't decrease while the START menu is active, including when the player is using the Pokémon summary screen, bag, etc. outside of battle.
 - **Level band:** Pokémon stop gaining experience if they become too overleveled compared to the rest of the team. Rare candies also stop working.
 - **Level scaling:** Wild and trainer Pokémon levels increase based on the player's party Pokémon levels and badge count.
 - **Starting items:** Start the game with balls, healing items, the Old Rod, 6 Exp Shares, and more.
 - **Move tutors & gift TMs:** Move tutors give the player a random TM instead. Purchasable, winnable, and gift TMs are randomized.

Other changes:
 - Faster movement and text. Hold B to use normal walking speed.
 - Gen IV HG/SS learnsets. Many Gen IV moves aren't implemented properly, and instead have the same effect as Metronome.
 - Starter Pokémon are randomized based on the game seed. There is still one grass, water, and fire starter, and they will be chosen from the gen 1-3 starters.
 - Gym leaders give the player Rare Candy in addition to a TM upon earning a badge.
 - Overworld Pokémon (e.g. Snorlax, Articuno) can't be caught.
 - Physical/special split.
 - Gift Pokémon are replaced with Unowns.
 - Game Corner prize Pokémon are replaced with baby Pokémon.
 - The Department Store desks on 5F now sell select battle items instead of their usual ones (notably excluding Choice Band). See full list [here](https://github.com/alecwshearer/poke-challenge/blob/master/data/maps/CeladonCity_DepartmentStore_5F/scripts.inc).
 - TMs are reusable, and aren't sellable.
 - HMs are deletable without the Move Deleter.
 - Trade and happiness evolutions have been replaced with Sun Stone, or Moon Stone in cases where one Pokémon can evolve into multiple others (e.g. Eevee into Espeon or Umbreon). See full list [here](https://github.com/alecwshearer/poke-challenge/blob/master/src/data/pokemon/evolution.h).
 - Hidden items have been removed, except for Coins in the Game Corner.
 - Player finds the Good Rod where the Old Rod used to be, and Super Rod where Good Rod used to be. The Super Rod can also still be found at its original location.
 - Flash is no longer required in Rock Tunnel.
 - Player gets 10x the number of steps in the Safari Zone.
 - Shiny Pokémon odds are increased 10x.
 - Party menu shortcut for giving/taking Exp Shares.
 - The Arena Trap ability has been removed from the game.
 - Pewter, Cerulean, and Vermillion Marts sell Revives.
 - Some early events are skipped; e.g. the Old Man.
 - Slightly modified wild encounters:
   - In the Power Plant, Pikachu is replaced with Plusle.
   - In the Safari Zone, Dratini is replaced with Gyarados.
   - In the Safari Zone, Dragonair is replaced with Starmie.

## Level band / level cap

A 5 level band is in place. A portion of the player's team must be within 5 levels, inclusive, of each other;
e.g. a range of 30-35 is valid but 30-36 isn’t. The number of Pokémon that must be within the band is equal
to the number of badges the player has plus 1. For example, the player has 3 badges, they must have 4 Pokémon
within 5 levels (inclusive) of each other. If the highest leveled Pokémon exceeds the top of the band (also called
the _level cap_), it will stop gaining experience until it is back within the band. Other party Pokémon holding an
EXP share will still gain EXP, but the Pokémon outside of the band won’t gain EXP (and the EXP it would have gained
won’t be distributed to the other party Pokémon).

The game will issue warnings when a Pokémon is near the current level cap, or the cap at the next badge. The latter
warning can be disabled in the OPTION menu.

## Level scaling

### Wild encounters

Wild Pokémon levels are scaled based on party Pokémon levels and the level that the wild Pokémon is
supposed to be at. This is done by replacing the highest party Pokémon level with the level that the
wild Pokémon is supposed to be at, and then taking the average level of party Pokémon that are required
to be within the level band, rounded down (floored).

#### Example

Input:
 - **Number of badges:** 3
 - **Required Pokémon in band:** 3 + 1 = 4
 - **Party Pokémon levels:** 25, 24, 22, 21, 12
 - **Level the wild Pokémon is supposed to be at:** 14

Output:
 - **Scaled level:** ⌊(14 + 24 + 22 + 21) / 4⌋ = ⌊81 / 4⌋ = 20

#### Exception for high level Pokémon

To disincentivize players from rushing to later routes to catch all of their Pokémon, wild Pokémon that
are supposed to be at level greater than or equal to the player's highest Pokémon will have their level
multiplied by 0.67 before it is plugged into the scaling formula.

### Trainer battles

Trainer Pokémon levels are increased based on the number of badges the player has. For each odd numbered badge,
even numbered trainer Pokémon levels are increased by 1. For each even numbered badge, odd numbered trainer
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

For every map (i.e. route, dungeon room) in the game, each Pokémon species
that is normally discoverable in the wild is deterministically replaced with 2
species from its group. For example, Pidgey might be replaced by {Taillow, Hoothoot}
in Route 1, and {Doduo, Pidgey} in Route 2. There's a ~66% and ~33% chance of
encountering the 2 replacements, respectively.

Additionally, each non-water game map is deterministically assigned a single
"rare" Pokémon from the `Rare2Percent` group. There is a 2% chance of encountering
the "rare" Pokémon in each map.

#### Example

In the original game, there's a 50% chance of encountering Pidgey
in Route 1. In our first example above, there will be a ~33% chance of encountering
Taillow and 17% chance of encountering Hoothoot. There will also be a fixed 2% chance
of encountering the "rare" species assigned to the route; e.g. Dratini.

### Trainer battles

Trainer Pokémon are deterministically replaced with a single Pokémon from their group.

### Group list

''' + md)

with open('include/autogenerated_pokemon_groups.h', 'w') as c_file:
  c_file.write(c_top + c_bottom + '\n#endif\n')

