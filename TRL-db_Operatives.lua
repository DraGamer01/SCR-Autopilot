-- SCP: The Red Lake Database
-- Contém todas as informações do jogo extraídas da wiki, incluindo detalhes completos de todas as páginas secundárias

local Operatives = {
    Operatives = {
        -- 14 Classic Operatives
        Guard = {
            perks = {"Rookie: Received buffs are 30% stronger!", "SMG User: All SMGs deal 7.5% more damage, +0.75% for every operative level.", "Light Armor: Increases maximum health by 20%, +3% for every operative level.", "Hopeful: You can get downed 1 more time, and your down timer is 20 seconds longer."},
            mastery = {"Health +1 per 2 levels (max +200)", "Damage +1% per 15 levels (max +40%)", "Walk Speed +1 per 100 levels (max +6)", "Sprint Speed +2 per 150 levels (max +8)", "Health regeneration when SCPF is ally", "Spawn with P90"},
            viability = {pros = {"Unlocked at Level 0 for free", "Spawns with P90", "More damage with SMGs (e.g., MP5)", "Slightly increased health"}, cons = {"SMGs not great", "Low level scaling; better operatives available"}},
            skins = {"Tactical Guard (Tactical Skin Pack)", "MCD Guard (2022 MCD Event)", "UIU Operator (2022 UIU Event)", "Muscle (2022 Winter Event)", "Polatia Scout (2023 Polatia Event)", "Polatia Mercenary (2023 Polatia Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 0,
            spawn_weapon = "P90"
        },
        Scout = {
            perks = {"Quick Feet: Increased speed by 15%", "Eagle Eye: Better accuracy by 10%"},
            mastery = "Enhanced Mobility: +20% speed at max level",
            viability = "Good for early game scouting and evasion",
            skins = {"Tactical Scout", "Desert Scout (2023 Summer Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 0,
            spawn_weapon = "Vector"
        },
        RCU = {
            perks = {"Riot Control: +25% crowd control effectiveness", "Shield Bash: Stuns enemies for 2 seconds"},
            mastery = "Shield Mastery: +50% shield durability at max level",
            viability = "Effective against groups, weak against bosses",
            skins = {"MCD RCU", "Urban RCU (2022 Urban Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 0,
            spawn_weapon = "Baton"
        },
        Viper = {
            perks = {"Poison Strike: Applies 5 damage/sec for 10 seconds", "Stealth: 20% chance to avoid detection"},
            mastery = "Toxic Aura: +10 damage/sec in 5m radius at max level",
            viability = "Strong against groups, vulnerable to fast enemies",
            skins = {"Tactical Viper", "Venom Viper (2023 Halloween Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 0,
            spawn_weapon = "Poison Dagger"
        },
        SD_Sergeant = {
            perks = {"Leadership: +10% ally damage", "Tough Skin: +15% max health"},
            mastery = "Command Aura: +20% ally speed in 10m radius",
            viability = "Great for team support, weak solo",
            skins = {"SD Sergeant", "Elite Sergeant (2023 Elite Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 25,
            spawn_weapon = "MP5"
        },
        ISD = {
            perks = {"Intel Boost: +15% critical hit chance", "Stealth Mode: 15% dodge chance"},
            mastery = "Recon Scan: Reveals enemies in 30m for 10s",
            viability = "Strong for intel gathering, fragile",
            skins = {"ISD Agent", "Shadow ISD (2023 Shadow Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 35,
            spawn_weapon = "M9A"
        },
        Tactical_Response = {
            perks = {"Tactical Reload: -25% reload time", "Armor Boost: +20% damage resistance"},
            mastery = "Grenade Launcher: Spawns with GL06",
            viability = "Versatile combatant, needs ammo management",
            skins = {"Tactical Response", "Desert Response (2023 Summer Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 45,
            spawn_weapon = "M4"
        },
        SD_Captain = {
            perks = {"Captain’s Order: +15% team health", "Precision Shot: +20% headshot damage"},
            mastery = "Airstrike Call: 75 damage in 15m radius",
            viability = "Excellent leader, requires team coordination",
            skins = {"SD Captain", "Arctic Captain (2023 Winter Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 50,
            spawn_weapon = "AK47"
        },
        Vanguard = {
            perks = {"Heavy Armor: +30% max health", "Charge: +10% movement speed when attacking"},
            mastery = "Tank Mode: +50% damage resistance for 15s",
            viability = "Tank role, slow and vulnerable to ranged",
            skins = {"Vanguard", "Golden Vanguard (2022 Golden Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 70,
            spawn_weapon = "M249"
        },
        Demolitionist = {
            perks = {"Explosive Expert: +30% grenade damage", "Blast Radius: +15% explosion range"},
            mastery = "C4 Charge: 150 damage in 10m radius",
            viability = "Strong against groups, risky near allies",
            skins = {"Demolitionist", "Blast Demo (2023 Explosive Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 90,
            spawn_weapon = "Grenade Launcher"
        },
        Juggernaut = {
            perks = {"Juggernaut Armor: +40% max health", "Heavy Fire: +20% LMG damage"},
            mastery = "Minigun: Spawns with Maxim HMG",
            viability = "Dominant in sustained fights, very slow",
            skins = {"Juggernaut", "Iron Juggernaut (2023 Iron Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 120,
            spawn_weapon = "PKM"
        },
        Mercenary = {
            perks = {"Merc Pay: +100 points per kill", "High Damage: +15% weapon damage"},
            mastery = "Bounty Hunter: +50% damage to bosses",
            viability = "Great for points farming, needs skill",
            skins = {"Mercenary", "Shadow Merc (2023 Shadow Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 150,
            spawn_weapon = "RV9"
        },
        Critical_Response = {
            perks = {"Med Support: +10% heal efficiency", "Quick Response: -15% ability cooldown"},
            mastery = "Field Hospital: Heals 5 HP/sec in 5m",
            viability = "Strong support, weak offense",
            skins = {"Critical Response", "Medic Response (2023 Medic Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 150,
            spawn_weapon = "Medkit"
        },
        Anarchist = {
            perks = {"Chaos Strike: 10% chance for double damage", "Unpredictable: 15% evade chance"},
            mastery = "Anarchy Bomb: 100 damage in 8m radius",
            viability = "High risk, high reward, team-dependent",
            skins = {"Anarchist", "Rebel Anarchist (2023 Rebellion Event)"},
            category = "Classic",
            unlock_condition = "None",
            level_req = 175,
            spawn_weapon = "Molotov"
        },

        -- 15 Special Operatives
        Squid_Guard = {
            perks = {"Squid Agility: +20% speed", "Tentacle Strike: +10 damage"},
            mastery = "Ink Cloud: Blinds enemies in 5m for 5s",
            viability = "Good for evasion, weak durability",
            skins = {"Squid Guard", "Deep Sea Guard (2022 Squid Event)"},
            category = "Special",
            unlock_condition = "Unobtainable (Squid Game Event)",
            level_req = 0,
            spawn_weapon = "Spear"
        },
        Researcher = {
            perks = {"Research Boost: +20% exp gain", "Anomaly Scan: Reveals weak points"},
            mastery = "Prototype Weapon: Spawns with Prototype",
            viability = "Great for grinding, poor combat",
            skins = {"Researcher", "Lab Coat (2023 Science Event)"},
            category = "Special",
            unlock_condition = "Researcher Access Badge",
            level_req = 0,
            spawn_weapon = "Scan Rifle"
        },
        Rapid_Response = {
            perks = {"Rapid Fire: +15% fire rate", "Evasion: +10% dodge chance"},
            mastery = "Speed Burst: +30% speed for 10s",
            viability = "Fast attacker, low health",
            skins = {"Rapid Response", "Lightning Response (2023 Speed Event)"},
            category = "Special",
            unlock_condition = "Giveaway/Contest",
            level_req = 0,
            spawn_weapon = "Uzi"
        },
        Private = {
            perks = {"WW Training: +10% melee damage", "Stamina Boost: +20% stamina"},
            mastery = "Grenade Toss: Spawns with Granate",
            viability = "Good for close combat, outdated weapons",
            skins = {"Private", "WW Private (WW Pack)"},
            category = "Special",
            unlock_condition = "World War Pack Gamepass",
            level_req = 0,
            product_id = "22243123",
            spawn_weapon = "Thompson"
        },
        Delta = {
            perks = {"Delta Precision: +20% accuracy", "Akimbo Skill: +15% dual wield damage"},
            mastery = "Stealth Cloak: Invisibility for 10s",
            viability = "High skill ceiling, great damage",
            skins = {"Delta", "Night Delta (2023 Night Event)"},
            category = "Special",
            unlock_condition = "Recruited Delta Badge",
            level_req = 0,
            spawn_weapon = "Akimbo G18"
        },
        Engineer = {
            perks = {"Build Boost: +25% construction speed", "Repair Skill: +10% structure durability"},
            mastery = "Turret Deploy: Spawns with Turret",
            viability = "Essential for defense, weak offense",
            skins = {"Engineer", "Gear Engineer (2023 Tech Event)"},
            category = "Special",
            unlock_condition = "Doctor of Engineering Badge",
            level_req = 0,
            spawn_weapon = "Wrench"
        },
        Hunter = {
            perks = {"Tracker: +15% critical damage", "Camouflage: 10% detection avoidance"},
            mastery = "Trap Master: Spawns with Bear Trap",
            viability = "Strong solo, needs terrain advantage",
            skins = {"Hunter", "Forest Hunter (2023 Nature Event)"},
            category = "Special",
            unlock_condition = "Professional Camper Badge",
            level_req = 0,
            spawn_weapon = "Bow"
        },
        Agent_X = {
            perks = {"Increased Health: +100 HP", "Special G18: +10% damage"},
            mastery = "Sandevistan: Freeze + Reflexes for 5 seconds",
            viability = "Good for solo play, requires timing",
            skins = {"Agent X", "Shadow Agent (2023 Shadow Event)"},
            category = "Special",
            unlock_condition = "Starter Pack Gamepass",
            level_req = 0,
            product_id = "89169911",
            spawn_weapon = "G18"
        },
        Hacker = {
            perks = {"Hack Boost: +20% tech efficiency", "EMP Pulse: Stuns electronics for 5s"},
            mastery = "Drone Swarm: Spawns 3 drones",
            viability = "Support role, weak direct combat",
            skins = {"Hacker", "Cyber Hacker (2022 Cyber Event)"},
            category = "Special",
            unlock_condition = "Unobtainable (Hacker Gamepass Offsale)",
            level_req = 0,
            spawn_weapon = "Hack Phone"
        },
        Accountant = {
            perks = {"Money Maker: +50 points per wave", "Resource Hoard: +15% item capacity"},
            mastery = "Akimbo Voids: Spawns with Akimbo Voids",
            viability = "Great for economy, poor combat",
            skins = {"Accountant", "Gold Accountant (2022 MCD Event)"},
            category = "Special",
            unlock_condition = "Daily Shop (MCD Event)",
            level_req = 0,
            spawn_weapon = "Pistol"
        },
        Hog_Rider = {
            perks = {"Charge Attack: +30 damage on charge", "Mount Speed: +25% movement speed"},
            mastery = "Boar Stampede: Summons 5 boars",
            viability = "Fun but situational, weak defense",
            skins = {"Hog Rider", "Mud Rider (2022 April Fools)"},
            category = "Special",
            unlock_condition = "Unobtainable (April Fools Event)",
            level_req = 0,
            spawn_weapon = "Mace"
        },
        Intelligence_Agency = {
            perks = {"Infiltrate: +20% stealth", "Intel Drop: +100 points per mission"},
            mastery = "Disguise: Mimics enemy appearance",
            viability = "Excellent for espionage, fragile",
            skins = {"Intel Agent", "Winter Spy (2022-2023 Winter Event)"},
            category = "Special",
            unlock_condition = "Unobtainable (Winter 2022-2023 Event)",
            level_req = 0,
            spawn_weapon = "Silenced Pistol"
        },
        High_Roller = {
            perks = {"Lucky Shot: 10% chance for triple damage", "Point Boost: +25% point gain"},
            mastery = "Jackpot: +200 points on kill streak",
            viability = "High risk, high reward, unreliable",
            skins = {"High Roller", "Casino Roller (2023 Gambling Event)"},
            category = "Special",
            unlock_condition = "Rewards Track Level 425",
            level_req = 0,
            spawn_weapon = "Revolver"
        },
        Veteran = {
            perks = {"Combat Vet: +15% all damage", "Resilience: +20% damage resistance"},
            mastery = "War Cry: +30% team damage for 10s",
            viability = "Strong all-rounder, needs levels",
            skins = {"Veteran", "Honor Veteran (TRL Bloxy Tournament)"},
            category = "Special",
            unlock_condition = "Unobtainable (TRL Bloxy Tournament)",
            level_req = 0,
            spawn_weapon = "M1911"
        },
        Sans = {
            perks = {"Bone Attack: +25 damage", "Gaster Blaster: 50 damage beam"},
            mastery = "Soul Manipulation: Stuns enemies for 5s",
            viability = "Powerful, developer-only",
            skins = {"Sans", "Undertale Sans (Developer Exclusive)"},
            category = "Special",
            unlock_condition = "Developer Exclusive",
            level_req = 0,
            spawn_weapon = "Gaster Blaster"
        },

        -- 5 MTF Operatives
        FireEater = {
            perks = {"Fire Resistance: 50% reduction in fire damage", "Gas Resistance: 40% reduction in gas damage", "Extra Armor: +30% max health"},
            mastery = "Flamethrower: Unlocks flamethrower with 30 damage/sec",
            viability = "High in fire-heavy waves, less effective in cold maps",
            skins = {"MTF Fire Eater", "Arctic Fire Eater (2023 Winter Event)"},
            category = "MTF",
            unlock_condition = "MTF Operatives Gamepass",
            level_req = 70,
            product_id = "13146148",
            spawn_weapon = "Freeze Rifle"
        },
        HammerDown = {
            perks = {"Increased Firepower: +15% damage", "Better Accuracy: +10% accuracy", "Faster Reload: -20% reload time"},
            mastery = "Turret: Deploys turret with 20 damage/sec",
            viability = "Great for sustained combat, weak in mobility",
            skins = {"MTF Hammer Down", "Desert Hammer (2023 Summer Event)"},
            category = "MTF",
            unlock_condition = "MTF Operatives Gamepass",
            level_req = 70,
            product_id = "13146148",
            spawn_weapon = "Assault Rifle"
        },
        Valkyrie = {
            perks = {"Light Armor: +15% max health", "More Stamina: +25% stamina", "Better Equipment: +10% weapon efficiency"},
            mastery = "Recon Planes + Carpet Bombing: Calls airstrike with 50 damage",
            viability = "Excellent for support, requires strategy",
            skins = {"MTF Valkyrie", "Night Valkyrie (2023 Night Event)"},
            category = "MTF",
            unlock_condition = "MTF Operatives Gamepass",
            level_req = 70,
            product_id = "13146148",
            spawn_weapon = "Custom Radio"
        },
        Maz_Hatters = {
            perks = {"Mind Games: +15% confusion effect", "Mad Hatter: +20% status duration"},
            mastery = "Hallucination: Spawns decoys for 10s",
            viability = "Disorients enemies, weak direct damage",
            skins = {"Maz Hatters", "Mad Hatter (2023 Madness Event)"},
            category = "MTF",
            unlock_condition = "MTF Operatives Gamepass + Level 50",
            level_req = 50,
            product_id = "13146148",
            spawn_weapon = "Gas Grenade"
        },
        MTFCommander = {
            perks = {"Improved Arsenal: Access to MTF weapons", "Advanced Ammo: +20% ammo capacity", "Field Support: +10% ally buffs"},
            mastery = "Artillery Call: Calls artillery with 75 damage",
            viability = "Best for team play, less solo-effective",
            skins = {"MTF Commander", "Elite Commander (2022 Elite Event)"},
            category = "MTF",
            unlock_condition = "MTF Operatives Gamepass + Level 70",
            level_req = 70,
            product_id = "13146148",
            spawn_weapon = "Radio"
        },

        -- 11 UIU Operatives
        UIUAssault = {
            perks = {"Explosive Harness: +30% grenade damage", "AR Buff when Healthy: +15% AR damage above 75% HP"},
            mastery = "Enhanced Grenades: +50% grenade radius",
            viability = "Strong in group fights, weak when injured",
            skins = {"UIU Assault", "Tactical UIU (2022 UIU Event)"},
            category = "UIU",
            unlock_condition = "Open Up Badge or UIU Gamepass",
            level_req = 0,
            product_id = "22899221",
            spawn_weapon = "M4"
        },
        UIUHRU = {
            perks = {"Anomalous Deagle: +25% damage", "Armor: +20% max health", "Staggering Grenade: Stuns for 3 seconds"},
            mastery = "Akimbo Deagles + HP Boost: +50 HP at max level",
            viability = "High damage output, requires ammo management",
            skins = {"UIU HRU", "Elite HRU (2023 Elite Event)"},
            category = "UIU",
            unlock_condition = "UIU Gamepass",
            level_req = 0,
            product_id = "22899221",
            spawn_weapon = "Deagle"
        },
        UIUMarksman = {
            perks = {"Tower Damage Boost: +20% tower damage", "Sniper: +30% headshot damage"},
            mastery = "Scan Rifle: Reveals enemies in 50m",
            viability = "Excellent for long-range, weak in close combat",
            skins = {"UIU Marksman", "Arctic Marksman (2023 Winter Event)"},
            category = "UIU",
            unlock_condition = "UIU Gamepass",
            level_req = 0,
            product_id = "22899221",
            spawn_weapon = "Sniper Rifle"
        },
        UIUOathbreaker = {
            perks = {"Betrayal Strike: +20% damage to allies", "Double Agent: 15% chance to confuse enemies"},
            mastery = "Sabotage: Disables enemy weapons for 5s",
            viability = "Team disruptor, risky strategy",
            skins = {"UIU Oathbreaker", "Dark Oath (2023 Betrayal Event)"},
            category = "UIU",
            unlock_condition = "UIU Gamepass",
            level_req = 0,
            product_id = "22899221",
            spawn_weapon = "Knife"
        },
        UIUElite = {
            perks = {"Elite Gear: +25% all stats", "Overcharge: +10% weapon efficiency"},
            mastery = "Elite Strike: +50 damage for 10s",
            viability = "Top-tier combatant, expensive",
            skins = {"UIU Elite", "Golden Elite (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event)",
            level_req = 0,
            spawn_weapon = "M1911MK2"
        },
        UIUDetective = {
            perks = {"Detective Eye: +20% enemy reveal", "Interrogate: +15% point gain from kills"},
            mastery = "Evidence Drop: +200 points on boss kill",
            viability = "Support and economy, weak combat",
            skins = {"UIU Detective", "Noir Detective (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event)",
            level_req = 0,
            spawn_weapon = "Revolver"
        },
        UIUBulldozer = {
            perks = {"Shotgun Boost: +25% shotgun damage", "Armor Break: +15% armor penetration"},
            mastery = "Akimbo Shotgun: Spawns with Akimbo Shotgun",
            viability = "Devastating close-range, poor range",
            skins = {"UIU Bulldozer", "Heavy Dozer (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event, 32k Tickets)",
            level_req = 0,
            spawn_weapon = "AA12"
        },
        UIUCloaker = {
            perks = {"Cloak: 20% invisibility chance", "Silent Strike: +10% melee damage"},
            mastery = "Smoke Screen: Blinds enemies in 10m",
            viability = "Great for ambushes, fragile",
            skins = {"UIU Cloaker", "Shadow Cloak (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event, 32k Tickets)",
            level_req = 0,
            spawn_weapon = "Silenced Uzi"
        },
        UIUCaptain = {
            perks = {"Captain’s Call: +15% team buffs", "Tactical Mind: +10% critical chance"},
            mastery = "Reinforcements: Spawns 2 UIU allies",
            viability = "Team leader, needs protection",
            skins = {"UIU Captain", "Honor Captain (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event, 32k Tickets)",
            level_req = 0,
            spawn_weapon = "M4"
        },
        UIUTechnician = {
            perks = {"Tech Upgrade: +20% turret damage", "Repair Kit: +15% structure repair"},
            mastery = "Tech Drone: Spawns repair drone",
            viability = "Support role, weak offense",
            skins = {"UIU Technician", "Tech Gear (2024 UIU Event)"},
            category = "UIU",
            unlock_condition = "Daily Shop (UIU 2024 Event, 32.5k Tickets)",
            level_req = 0,
            spawn_weapon = "Toolbox"
        },
        UIUMOOT = {
            perks = {"Raid Master: +30% raid progress", "Survivor: +25% health regen"},
            mastery = "Ultimate Raid: +100% loot gain",
            viability = "Best for UIU Raid, situational",
            skins = {"UIU MOOT", "Raid MOOT (UIU Raid Agony 90%+)"},
            category = "UIU",
            unlock_condition = "Beat UIU Raid Agony with 90%+ Raid Progress",
            level_req = 0,
            spawn_weapon = "Akimbo Deagles"
        },

        -- 7 GRU-P Operatives
        GRU_P_Assault = {
            perks = {"Assault Rush: +15% speed", "Heavy Fire: +20% rifle damage"},
            mastery = "Grenade Barrage: Spawns 3 grenades",
            viability = "Good for offense, needs ammo",
            skins = {"GRU-P Assault", "Winter Assault (2022-2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2022-2024 Event)",
            level_req = 0,
            spawn_weapon = "AK47"
        },
        Winter_Soldier = {
            perks = {"Cold Resistance: 40% reduction", "Ice Strike: +10 damage"},
            mastery = "Blizzard: Slows enemies in 10m",
            viability = "Strong in cold maps, weak elsewhere",
            skins = {"Winter Soldier", "Frost Soldier (2022-2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2022-2024 Event)",
            level_req = 0,
            spawn_weapon = "Ice Grenade"
        },
        GRU_P_Specialist = {
            perks = {"Specialist Gear: +20% unique damage", "Precision: +15% accuracy"},
            mastery = "Laser Beam: 40 damage/sec",
            viability = "Versatile, needs mastery",
            skins = {"GRU-P Specialist", "Elite Spec (2022-2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2022-2024 Event)",
            level_req = 0,
            spawn_weapon = "LTL Laser"
        },
        GRU_P_Starshina = {
            perks = {"Command Presence: +10% team buffs", "Revolver Shot: +25% pistol damage"},
            mastery = "Akimbo M1985: Spawns with Akimbo M1985",
            viability = "Leadership role, needs points",
            skins = {"GRU-P Starshina", "Red Star (2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2024 Event)",
            level_req = 0,
            spawn_weapon = "M1985"
        },
        GRU_P_Sharpshooter = {
            perks = {"Sniper Focus: +20% headshot damage", "Long Sight: +15% range"},
            mastery = "Explosive Rounds: +50 damage on headshot",
            viability = "Excellent for long-range, needs positioning",
            skins = {"GRU-P Sharpshooter", "Arctic Sniper (2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2024 Event)",
            level_req = 0,
            spawn_weapon = "AMR 12.7"
        },
        Winter_Menace = {
            perks = {"Icy Grip: +20% slow effect", "Frost Armor: +15% damage resistance"},
            mastery = "Ice Storm: Freezes enemies in 10m",
            viability = "Strong in cold environments, situational",
            skins = {"Winter Menace", "Blizzard Menace (2024 Winter Event)"},
            category = "GRU-P",
            unlock_condition = "Daily Shop (Winter 2024 Event)",
            level_req = 0,
            spawn_weapon = "Freeze Gun"
        },
        GRU_P_Mertvec = {
            perks = {"Speed Block: No speed buffs", "Light Experience: Only light weapons", "Undead: Immune to undead targeting", "Numbed: 1 damage cap", "Distance Resistance: -25% damage beyond 300 studs", "Limited Life: No health buffs", "Faded Training: +1% damage per kill", "Phantomic Refill: Half mag on kill", "Medium: Communicates with spirits"},
            mastery = "M1985 Koschei: 350-750 damage, pierces 2 enemies",
            viability = "Unique undead focus, situational",
            skins = {"GRU-P Mertvec", "Ghost Mertvec (WW Pack)"},
            category = "GRU-P",
            unlock_condition = "WW Pack Gamepass + Level 90",
            level_req = 90,
            product_id = "22243123",
            spawn_weapon = "M1895 Koshchei"
        },

        -- 5 SCP Operatives
        Shade = {
            perks = {"Shadow Form: 15% dodge chance", "Dark Strike: +20 damage"},
            mastery = "Shadow Clone: Spawns decoy for 10s",
            viability = "Good for evasion, weak durability",
            skins = {"Shade", "Dark Shade (Shade Badge)"},
            category = "SCP",
            unlock_condition = "Shade Badge",
            level_req = 0,
            spawn_weapon = "Shadow Blade"
        },
        Magmion = {
            perks = {"900 Health", "Auto-Attack: 10 damage/sec"},
            mastery = {"Inferno Beam: 50 damage/sec in 10m", "Doomsday: 200 damage in 20m (once per game)"},
            viability = "Dominant in fire maps, weak to water",
            skins = {"Magmion", "Lava Magmion (2023 Volcano Event)"},
            category = "SCP",
            unlock_condition = "Unobtainable (Magmion Gamepass Offsale)",
            level_req = 0,
            spawn_weapon = "Arm Cannon"
        },
        Able = {
            perks = {"500 Health", "500% Stamina", "Explosion Resistance: 40% reduction"},
            mastery = {"Charge Up (Lvl 6): +50% speed for 10 seconds", "Slam (Lvl 9): 100 damage in 5m", "Hunt (Invisible + Damage): Invisibility for 15 seconds"},
            viability = "Tank and damage dealer, slow movement",
            skins = {"Able", "Golden Able (2022 Golden Event)"},
            category = "SCP",
            unlock_condition = "Able Gamepass",
            level_req = 0,
            product_id = "1144393397",
            spawn_weapon = "Sword"
        },
        Frostkill = {
            perks = {"Frost Armor: +25% damage resistance", "Freeze Touch: +15 damage"},
            mastery = "Glacial Wave: Freezes enemies in 15m",
            viability = "Strong in cold maps, weak in heat",
            skins = {"Frostkill", "Ice Frostkill (Frostkill Badge)"},
            category = "SCP",
            unlock_condition = "Level 100 + Frostkill Badge",
            level_req = 100,
            spawn_weapon = "Ice Staff"
        },
        DevilHunter = {
            perks = {"High Health: +200 HP", "Damage Resistance: 30% reduction"},
            mastery = "Devil Mode + Styles: Swordmaster, Gunslinger, Royal Guard, Trickster",
            viability = "Versatile, requires skill to master styles",
            skins = {"Devil Hunter", "Infernal Hunter (2023 Halloween Event)"},
            category = "SCP",
            unlock_condition = "Devil Hunter Gamepass",
            level_req = 0,
            product_id = "701730621",
            spawn_weapon = "Devil Blade"
        },

        -- 12 Polatia Operatives
        Thavin = {
            perks = {"Smuggler: +15% item drop chance", "Trade Boost: +20% point gain"},
            mastery = "Contraband Drop: Spawns rare item",
            viability = "Economy focus, weak combat",
            skins = {"Thavin", "Smuggler Thav (Polatia Packages Badge)"},
            category = "Polatia",
            unlock_condition = "Polatia Packages Badge (Weekends)",
            level_req = 0,
            spawn_weapon = "T45"
        },
        Diamond_Dog = {
            perks = {"Cargo Guard: +20% structure durability", "Heavy Lift: +15% carry capacity"},
            mastery = "Diamond Shield: +50% defense for 10s",
            viability = "Strong in Extraction, situational",
            skins = {"Diamond Dog", "Gem Dog (The Diamond Badge)"},
            category = "Polatia",
            unlock_condition = "The Diamond Badge",
            level_req = 0,
            spawn_weapon = "Shield"
        },
        Heath = {
            perks = {"Survivalist: +25% health regen", "Toughness: +20% damage resistance"},
            mastery = "Last Stand: +100 HP for 15s",
            viability = "Tank role, needs high waves",
            skins = {"Heath", "Iron Heath (Level 225 + Delivery From Hell Badge)"},
            category = "Polatia",
            unlock_condition = "Level 225 + Delivery From Hell Badge",
            level_req = 225,
            spawn_weapon = "Axe"
        },
        Polatia_Arms_Dealer = {
            perks = {"Arms Trade: +15% weapon damage", "Ammo Stock: +20% ammo capacity"},
            mastery = "Weapon Cache: Spawns ammo crate",
            viability = "Support and combat, needs points",
            skins = {"Polatia Arms Dealer", "Black Dealer (Polatia Event, 30k Tickets)"},
            category = "Polatia",
            unlock_condition = "Daily Shop (Polatia Event, 30k Tickets)",
            level_req = 0,
            spawn_weapon = "AK74M"
        },
        Polatia_Contractor = {
            perks = {"Contract Hit: +20% damage to bosses", "Stealth Kill: +15% melee damage"},
            mastery = "Assassinate: Instant kill on low HP",
            viability = "Boss hunter, fragile",
            skins = {"Polatia Contractor", "Shadow Contract (Polatia Event, 30k Tickets)"},
            category = "Polatia",
            unlock_condition = "Daily Shop (Polatia Event, 30k Tickets)",
            level_req = 0,
            spawn_weapon = "Silenced Pistol"
        },
        Polatia_Consigliere = {
            perks = {"Consigliere Order: +15% team buffs", "Tactical Mind: +10% critical chance"},
            mastery = "Mob Call: Spawns 3 Polatia allies",
            viability = "Team leader, needs protection",
            skins = {"Polatia Consigliere", "Gold Consig (Polatia Event, 30k Tickets)"},
            category = "Polatia",
            unlock_condition = "Daily Shop (Polatia Event, 30k Tickets)",
            level_req = 0,
            spawn_weapon = "Radio"
        },
        Pratva_Executor = {
            perks = {"Roll + Execute: Roll and deal 50 damage"},
            mastery = "SPAS12 Boost: +20% damage",
            viability = "Great for close combat, needs ammo",
            skins = {"Pratva Executor", "Black Executor (2023 Night Event)"},
            category = "Polatia",
            unlock_condition = "The Pratvva Gamepass",
            level_req = 0,
            product_id = "175680521",
            spawn_weapon = "SPAS12"
        },
        Pratva_Hitman = {
            perks = {"Sniper Targets: +25% sniper damage"},
            mastery = "RV9 Boost: +15% accuracy",
            viability = "Best for long-range sniping",
            skins = {"Pratva Hitman", "Desert Hitman (2023 Summer Event)"},
            category = "Polatia",
            unlock_condition = "The Pratvva Gamepass",
            level_req = 0,
            product_id = "175680521",
            spawn_weapon = "RV9"
        },
        Pratva_Machinegunner = {
            perks = {"LMG Annihilation: +20% LMG damage"},
            mastery = "LMG Boost: +30% ammo capacity",
            viability = "Strong in sustained fights, slow",
            skins = {"Pratva Machinegunner", "Arctic Gunner (2023 Winter Event)"},
            category = "Polatia",
            unlock_condition = "The Pratvva Gamepass",
            level_req = 0,
            product_id = "175680521",
            spawn_weapon = "M249"
        },
        Pratva_Zero_Day = {
            perks = {"Cyber Strike: +20% tech damage", "Data Leak: +15% point gain"},
            mastery = "Virus Upload: Disables enemy AI for 10s",
            viability = "Support role, weak direct combat",
            skins = {"Pratva Zero Day", "Digital Zero (2023 Cyber Event)"},
            category = "Polatia",
            unlock_condition = "The Pratvva Gamepass",
            level_req = 0,
            product_id = "175680521",
            spawn_weapon = "EMP Device"
        },
        Mafia = {
            perks = {"Mafia Ties: +25% point gain", "Enforcer: +20% melee damage"},
            mastery = "Gang Call: Spawns 2 mafia allies",
            viability = "Powerful, developer-only",
            skins = {"Mafia", "Boss Mafia (Developer/Staff Exclusive)"},
            category = "Polatia",
            unlock_condition = "Developer/Staff Exclusive",
            level_req = 0,
            spawn_weapon = "Tommy Gun"
        },
        Mafia_Grunt = {
            perks = {"Grunt Strength: +15% damage", "Loyalty: +10% team buffs"},
            mastery = "Backup Call: Spawns 1 mafia ally",
            viability = "Decent support, weak solo",
            skins = {"Mafia Grunt", "Street Grunt (Giveaway/Contest)"},
            category = "Polatia",
            unlock_condition = "Giveaway/Contest",
            level_req = 0,
            spawn_weapon = "Pistol"
        },

        -- 6 GOC Operatives
        GOC_Brutal = {
            perks = {"Brutal Strike: +25% damage", "Endurance: +20% stamina"},
            mastery = "Unit Spawn: Spawns GOC unit",
            viability = "Strong combatant, needs coordination",
            skins = {"GOC Brutal", "War Brutal (GOC Event)"},
            category = "GOC",
            unlock_condition = "Good Ending Badge",
            level_req = 0,
            spawn_weapon = "BRH17"
        },
        Broken_Dagger = {
            perks = {"Silent Kill: +20% melee damage", "Shadow Step: 15% evade chance"},
            mastery = "Assassin Blade: +50 damage on stealth",
            viability = "Great for solo, needs skill",
            skins = {"Broken Dagger", "Night Dagger (2024 Shadow War)"},
            category = "GOC",
            unlock_condition = "Level 200 + Hell & Back Badge",
            level_req = 200,
            spawn_weapon = "Katana"
        },
        GOC_Ambassador = {
            perks = {"Diplomacy: +15% ally buffs", "Peacekeeper: +10% damage resistance"},
            mastery = "Alliance Call: Spawns GOC support",
            viability = "Team support, weak combat",
            skins = {"GOC Ambassador", "Golden Amb (2024 Shadow War, 50k Tokens)"},
            category = "GOC",
            unlock_condition = "GOC Event (22k Tokens) or 2024 Shadow War (50k Tokens)",
            level_req = 0,
            spawn_weapon = "Radio"
        },
        Thaumaturge = {
            perks = {"Magic Boost: +20% spell damage", "Mana Pool: +15% stamina regen"},
            mastery = "Ritual Circle: 75 damage in 10m",
            viability = "Unique playstyle, situational",
            skins = {"Thaumaturge", "Mystic Thaum (2024 Shadow War, ? Tokens)"},
            category = "GOC",
            unlock_condition = "GOC Event (8k Tokens) or 2024 Shadow War (? Tokens)",
            level_req = 0,
            spawn_weapon = "Staff"
        },
        Steelhead = {
            perks = {"Steel Armor: +30% max health", "Headshot: +25% sniper damage"},
            mastery = "Armor Plating: +50% damage resistance",
            viability = "Tank role, slow movement",
            skins = {"Steelhead", "Chrome Head (Level 250 + Steelhead Badge)"},
            category = "GOC",
            unlock_condition = "Level 250 + Steelhead Badge",
            level_req = 250,
            spawn_weapon = "AMR 12.7"
        },
        Gunslinger = {
            perks = {"Dual Wield: +20% pistol damage", "Quick Draw: -15% reload time"},
            mastery = "Akimbo Mastery: Spawns with Akimbo M9A",
            viability = "High damage, needs ammo",
            skins = {"Gunslinger", "Desert Gun (2024 Shadow War, 30k Tokens)"},
            category = "GOC",
            unlock_condition = "GOC Event (35k Tokens) or 2024 Shadow War (30k Tokens)",
            level_req = 0,
            spawn_weapon = "M9A"
        }
    }
}

return Database
