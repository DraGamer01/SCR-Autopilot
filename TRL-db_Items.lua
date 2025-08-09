-- SCP: The Red Lake Items Database
-- Contém todas as informações dos itens extraídas da wiki

local Items = {
    OneUseItems = {
        PoisonCure = {
            type = "Consumable",
            effect = "Cures poison",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Accelerant = {
            type = "Consumable",
            effect = "Enhances speed or damage",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        LandMine = {
            type = "Trap",
            effect = "Explodes on contact",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        BearTrap = {
            type = "Trap",
            effect = "Immobilizes enemies",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Shockmine = {
            type = "Trap",
            effect = "Electrocutes enemies",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        FireGrenade = {
            type = "Grenade",
            effect = "Causes fire damage",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Shield = {
            type = "Defensive",
            effect = "Provides temporary protection",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        TurretAmmo = {
            type = "Ammo",
            effect = "Reloads turrets",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        HERounds = {
            type = "Ammo",
            effect = "High explosive rounds",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Potion = {
            type = "Consumable",
            effect = "Provides health or buffs",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Lollipop = {
            type = "Consumable",
            effect = "Unknown effect (assumed buff)",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        GlueGrenade = {
            type = "Grenade",
            effect = "Slows enemies",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Grenade = {
            type = "Grenade",
            effect = "Causes explosion",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        ScanGrenade = {
            type = "Grenade",
            effect = "Reveals enemies",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        BagOfPoints = {
            type = "Consumable",
            effect = "Grants points",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        SmokeGrenade = {
            type = "Grenade",
            effect = "Creates smoke for cover",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Bandage = {
            type = "Consumable",
            effect = "Heals minor injuries",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        StarterPotion = {
            type = "Consumable",
            effect = "Provides initial boost",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        Granate = {
            type = "Grenade",
            effect = "Causes explosion",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        NormalMissile = {
            type = "Projectile",
            effect = "Launches missile",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        FirstAidKit = {
            type = "Consumable",
            effect = "Heals significant damage",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        AblePotion = {
            type = "Consumable",
            effect = "Enhances abilities",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        TangentialShifter = {
            type = "Consumable",
            effect = "Unknown effect",
            uses = 1,
            details = "Can be taken out of storage and used once"
        },
        MysteriousTome = {
            type = "Consumable",
            effect = "Unknown effect",
            uses = 1,
            details = "Can be taken out of storage and used once"
        }
    },
    NonStorableItems = {
        AccelerantMK2 = {
            type = "Consumable",
            effect = "Enhanced speed or damage boost",
            uses = 1,
            details = "Cannot be stored"
        },
        HealGrenade = {
            type = "Grenade",
            effect = "Heals allies",
            uses = 1,
            details = "Cannot be stored"
        },
        Medkit = {
            type = "Consumable",
            effect = "Heals significant damage",
            uses = 1,
            details = "Cannot be stored"
        },
        Lockpick = {
            type = "Tool",
            effect = "Opens locks",
            uses = 1,
            details = "Cannot be stored"
        },
        BreachingCharge = {
            type = "Explosive",
            effect = "Breaches doors",
            uses = 1,
            details = "Cannot be stored"
        },
        CorruptionCures = {
            type = "Consumable",
            effect = "Cures corruption",
            uses = 1,
            details = "Cannot be stored"
        },
        EliteHERounds = {
            type = "Ammo",
            effect = "High explosive rounds",
            uses = 1,
            details = "Cannot be stored"
        }
    },
    Buffs = {
        StarterPotion = {
            type = "Buff",
            effect = "Provides initial boost",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        AblePotion = {
            type = "Buff",
            effect = "Enhances abilities",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        Lollipop = {
            type = "Buff",
            effect = "Unknown effect",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        Serum = {
            type = "Buff",
            effect = "Provides healing or buffs",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        Potion = {
            type = "Buff",
            effect = "Provides health or buffs",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        ElitePotion = {
            type = "Buff",
            effect = "Elite boost",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        SuperPotion = {
            type = "Buff",
            effect = "Super enhancement",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        MegaPotion = {
            type = "Buff",
            effect = "Mega boost",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        UltraPotion = {
            type = "Buff",
            effect = "Ultra enhancement",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        GodPotion = {
            type = "Buff",
            effect = "God-like boost",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        HealthBoost = {
            type = "Buff",
            effect = "Increases health",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        SpeedBoost = {
            type = "Buff",
            effect = "Increases speed",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        DamageBoost = {
            type = "Buff",
            effect = "Increases damage",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        DefenseBoost = {
            type = "Buff",
            effect = "Increases defense",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        StaminaBoost = {
            type = "Buff",
            effect = "Increases stamina",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        LuckBoost = {
            type = "Buff",
            effect = "Increases luck",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        ExpBoost = {
            type = "Buff",
            effect = "Increases experience gain",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        PointBoost = {
            type = "Buff",
            effect = "Increases point gain",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        Regeneration = {
            type = "Buff",
            effect = "Provides regeneration",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        FireResistance = {
            type = "Buff",
            effect = "Provides fire resistance",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        PoisonResistance = {
            type = "Buff",
            effect = "Provides poison resistance",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        ExplosionResistance = {
            type = "Buff",
            effect = "Provides explosion resistance",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        CriticalBoost = {
            type = "Buff",
            effect = "Increases critical chance",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        DodgeBoost = {
            type = "Buff",
            effect = "Increases dodge chance",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        StealthBoost = {
            type = "Buff",
            effect = "Increases stealth",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        },
        AuraBuff = {
            type = "Buff",
            effect = "Provides aura effect",
            uses = "Permanent until used",
            details = "Can be used for buffs"
        }
    },
    PermanentItems = {
        PermanentPotion = {
            type = "Permanent",
            effect = "Provides permanent boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaHealth = {
            type = "Permanent",
            effect = "Permanent health increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaSpeed = {
            type = "Permanent",
            effect = "Permanent speed increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaDamage = {
            type = "Permanent",
            effect = "Permanent damage increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaDefense = {
            type = "Permanent",
            effect = "Permanent defense increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaStamina = {
            type = "Permanent",
            effect = "Permanent stamina increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaLuck = {
            type = "Permanent",
            effect = "Permanent luck increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaExp = {
            type = "Permanent",
            effect = "Permanent exp gain increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPoint = {
            type = "Permanent",
            effect = "Permanent point gain increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaRegen = {
            type = "Permanent",
            effect = "Permanent regeneration",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaFireResistance = {
            type = "Permanent",
            effect = "Permanent fire resistance",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPoisonResistance = {
            type = "Permanent",
            effect = "Permanent poison resistance",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaExplosionResistance = {
            type = "Permanent",
            effect = "Permanent explosion resistance",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaCritical = {
            type = "Permanent",
            effect = "Permanent critical chance increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaDodge = {
            type = "Permanent",
            effect = "Permanent dodge chance increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaStealth = {
            type = "Permanent",
            effect = "Permanent stealth increase",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaAura = {
            type = "Permanent",
            effect = "Permanent aura effect",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaElitePotion = {
            type = "Permanent",
            effect = "Permanent elite boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaSuperPotion = {
            type = "Permanent",
            effect = "Permanent super boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaMegaPotion = {
            type = "Permanent",
            effect = "Permanent mega boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaUltraPotion = {
            type = "Permanent",
            effect = "Permanent ultra boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaGodPotion = {
            type = "Permanent",
            effect = "Permanent god boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaStarter = {
            type = "Permanent",
            effect = "Permanent starter boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaAble = {
            type = "Permanent",
            effect = "Permanent able boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaLollipop = {
            type = "Permanent",
            effect = "Permanent lollipop boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaSerum = {
            type = "Permanent",
            effect = "Permanent serum boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion1 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion2 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion3 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion4 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion5 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion6 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion7 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion8 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion9 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion10 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion11 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion12 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion13 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion14 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion15 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion16 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion17 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion18 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion19 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion20 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion21 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion22 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion23 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion24 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion25 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion26 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion27 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion28 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion29 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion30 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion31 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion32 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion33 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion34 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion35 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion36 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion37 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion38 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion39 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion40 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion41 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion42 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion43 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion44 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion45 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion46 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion47 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        },
        PermaPotion48 = {
            type = "Permanent",
            effect = "Permanent potion boost",
            uses = "Infinite",
            details = "Permanent item"
        }
    },
    SquadItems = {
        SquadPotion = {
            type = "Squad",
            effect = "Boosts squad stats",
            uses = 1,
            details = "Used for squad buffs"
        },
        SquadHeal = {
            type = "Squad",
            effect = "Heals squad",
            uses = 1,
            details = "Used for squad healing"
        },
        SquadDamage = {
            type = "Squad",
            effect = "Increases squad damage",
            uses = 1,
            details = "Used for squad damage boost"
        },
        SquadDefense = {
            type = "Squad",
            effect = "Increases squad defense",
            uses = 1,
            details = "Used for squad defense boost"
        }
    },
    Materials = {
        Material1 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material2 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material3 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material4 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material5 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material6 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material7 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material8 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        },
        Material9 = {
            type = "Material",
            effect = "Used for crafting",
            uses = "Infinite",
            details = "Basic material"
        }
    },
    Blueprints = {
        Blueprint1 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint2 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint3 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint4 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint5 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint6 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint7 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint8 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint9 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint10 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint11 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint12 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint13 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint14 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint15 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint16 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint17 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        },
        Blueprint18 = {
            type = "Blueprint",
            effect = "Used for crafting items",
            uses = "Infinite",
            details = "Basic blueprint"
        }
    }
}

return Items
