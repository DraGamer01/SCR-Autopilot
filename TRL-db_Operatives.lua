-- SCP: The Red Lake Weapons Database
-- Contém todas as informações das armas extraídas da wiki

local Weapons = {
    Pistols = {
        G18 = {
            damage = 20,
            ammo = 17,
            fire_mode = "Selective (Semi/Auto)",
            other_details = "Real-life basis: Developed for EKO Cobra unit. Machine-pistol with switchable firing mode."
        },
        M1911 = {
            damage = 25,
            ammo = 7,
            fire_mode = "Semi",
            other_details = "Standard sidearm for early upgrades."
        },
        M9A = {
            damage = 22,
            ammo = 15,
            fire_mode = "Automatic",
            other_details = "Good for sustained fire with decent accuracy."
        },
        M1911MK2 = {
            damage = 40,
            ammo = 7,
            fire_mode = "Semi",
            other_details = "Exclusive to UIUElite operative."
        },
        AkimboG18 = {
            damage = 25,
            ammo = 17,
            fire_mode = "Selective (Semi/Auto)",
            other_details = "High fire rate with upgrade potential."
        },
        AkimboVoids = {
            damage = 30,
            ammo = 10,
            fire_mode = "Semi",
            other_details = "Stun effect lasts 2 seconds."
        },
        Deagle = {
            damage = 50,
            ammo = "Exceeds 1000 reserve",
            fire_mode = "Semi",
            other_details = "High damage, slow fire rate."
        },
        M1985 = {
            damage = 60,
            ammo = 6,
            fire_mode = "Semi",
            other_details = "Effective for precision shots."
        },
        TEC9 = {
            damage = 18,
            ammo = 20,
            fire_mode = "Automatic",
            other_details = "Moderate spread, good for rapid engagements."
        }
    },
    SMGs = {
        Uzi = {
            damage = 15,
            ammo = 32,
            fire_mode = "Automatic",
            other_details = "Most SMGs are secondaries, good for early levels."
        },
        Vector = {
            damage = 18,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "Spawn weapon for Scout operative."
        },
        MP5 = {
            damage = 20,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Popular choice for mid-game."
        },
        U10 = {
            damage = 19,
            ammo = 50,
            fire_mode = "Automatic",
            other_details = "Preferred by criminal organizations."
        },
        MPX = {
            damage = 22,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Balanced damage and fire rate."
        },
        P90 = {
            damage = 17,
            ammo = 50,
            fire_mode = "Automatic",
            other_details = "Spawn weapon for Guard at mastery."
        },
        Thompson = {
            damage = 20,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Spawn weapon for Private operative."
        },
        MP40 = {
            damage = 19,
            ammo = 32,
            fire_mode = "Automatic",
            other_details = "Historical design, moderate performance."
        },
        UMP45 = {
            damage = 21,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "Good for mid-range combat."
        },
        Prototype = {
            damage = 25,
            ammo = 20,
            fire_mode = "Automatic",
            other_details = "Exclusive to Researcher at mastery."
        },
        AkimboUzi = {
            damage = 15,
            ammo = 32,
            fire_mode = "Automatic",
            other_details = "High spread, situational use."
        },
        AkimboMP5s = {
            damage = 20,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Requires RRT operative."
        },
        T45 = {
            damage = 18,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "Lightweight, good for mobility."
        },
        PPSH41 = {
            damage = 16,
            ammo = 71,
            fire_mode = "Automatic",
            other_details = "Historical WW2 design."
        },
        StenGun = {
            damage = 17,
            ammo = 32,
            fire_mode = "Automatic",
            other_details = "Low cost, moderate performance."
        }
    },
    Shotguns = {
        Shorty = {
            damage = 30,
            ammo = 2,
            fire_mode = "Single",
            other_details = "Effective only at short distances."
        },
        R870 = {
            damage = 40,
            ammo = 5,
            fire_mode = "Pump",
            other_details = "GOC Ally exclusive."
        },
        Scattergun = {
            damage = 35,
            ammo = 2,
            fire_mode = "Single",
            other_details = "Expensive but powerful."
        },
        AA12 = {
            damage = 40,
            ammo = 8,
            fire_mode = "Automatic",
            other_details = "MTF exclusive, great for groups."
        },
        RC12 = {
            damage = 25,
            ammo = 6,
            fire_mode = "Pump",
            other_details = "Stuns enemies for 2 seconds."
        },
        SPAS12 = {
            damage = 45,
            ammo = 6,
            fire_mode = "Semi",
            other_details = "High damage, moderate range."
        },
        AkimboShotgun = {
            damage = 40,
            ammo = 6,
            fire_mode = "Semi",
            other_details = "Double the firepower, high spread."
        }
    },
    Rifles = {
        AK47 = {
            damage = 35,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "VIP gamepass reward."
        },
        G36 = {
            damage = 32,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Standard MTF weapon."
        },
        CRL10 = {
            damage = 40,
            ammo = 20,
            fire_mode = "Semi",
            other_details = "Effective at long range."
        },
        CRL11 = {
            damage = 38,
            ammo = 20,
            fire_mode = "Semi",
            other_details = "Good for sniping support."
        },
        BRH17 = {
            damage = 45,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "GOC Brutal exclusive."
        },
        SK17 = {
            damage = 30,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Good for mobility."
        },
        M4 = {
            damage = 30,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Standard UIUAssault weapon."
        },
        MRL4 = {
            damage = 35,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "Popular among mid-level players."
        },
        ASR = {
            damage = 33,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Effective against groups."
        },
        K4LAS = {
            damage = 40,
            ammo = 20,
            fire_mode = "Semi",
            other_details = "Requires tech upgrade."
        },
        AK74M = {
            damage = 36,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Polatia Arms Dealer weapon."
        },
        R416 = {
            damage = 34,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "HK416 variant, popular choice."
        },
        RV9 = {
            damage = 38,
            ammo = 25,
            fire_mode = "Automatic",
            other_details = "Pratva Hitman weapon."
        },
        T32 = {
            damage = 42,
            ammo = 20,
            fire_mode = "Semi",
            other_details = "High damage, slow fire rate."
        },
        M1915 = {
            damage = 30,
            ammo = 5,
            fire_mode = "Single",
            other_details = "Low ammo, high damage per shot."
        }
    },
    LMGs = {
        PKM = {
            damage = 28,
            ammo = 100,
            fire_mode = "Automatic",
            other_details = "Long reload, high spread."
        },
        M249 = {
            damage = 30,
            ammo = 200,
            fire_mode = "Automatic",
            other_details = "Slows movement speed."
        },
        MK49 = {
            damage = 32,
            ammo = 150,
            fire_mode = "Automatic",
            other_details = "Good for sustained fire."
        },
        T49 = {
            damage = 35,
            ammo = 200,
            fire_mode = "Automatic",
            other_details = "Expensive, high spread."
        }
    },
    SniperRifles = {
        AMR127 = {
            damage = 100,
            ammo = 5,
            fire_mode = "Single",
            other_details = "Requires Steelhead operative."
        },
        M1 = {
            damage = 90,
            ammo = 8,
            fire_mode = "Single",
            other_details = "Good for mid-range sniping."
        }
    },
    SpecialWeapons = {
        LTL_Laser = {
            damage = 25,
            ammo = 50,
            fire_mode = "Automatic",
            other_details = "Emits stun rounds, effective for crowd control."
        },
        Freeze_Ray = {
            damage = 20,
            ammo = 30,
            fire_mode = "Automatic",
            other_details = "Slows movement of targets."
        },
        Flamethrower = {
            damage = 30,
            ammo = 100,
            fire_mode = "Continuous",
            other_details = "Requires fuel, short range."
        },
        Flare_Gun = {
            damage = 15,
            ammo = 6,
            fire_mode = "Single",
            other_details = "Useful for night maps."
        },
        Scan_Rifle = {
            damage = 10,
            ammo = 20,
            fire_mode = "Semi",
            other_details = "Reveals enemy weak points, low damage."
        },
        Annihilator = {
            damage = 80,
            ammo = 1,
            fire_mode = "Single",
            other_details = "High damage, single use per reload."
        },
        Egg_Launcher = {
            damage = 25,
            ammo = 5,
            fire_mode = "Single",
            other_details = "Limited stock, fun weapon."
        },
        GL06 = {
            damage = 50,
            ammo = 6,
            fire_mode = "Single",
            other_details = "Tactical Response mastery weapon."
        },
        Firework_Launcher = {
            damage = 30,
            ammo = 10,
            fire_mode = "Single",
            other_details = "Festive, moderate range."
        },
        Freezethrower = {
            damage = 20,
            ammo = 80,
            fire_mode = "Continuous",
            other_details = "Longer range than Flamethrower."
        },
        M32 = {
            damage = 60,
            ammo = 6,
            fire_mode = "Single",
            other_details = "High explosive potential."
        },
        M32NL = {
            damage = 55,
            ammo = 6,
            fire_mode = "Single",
            other_details = "Useful for crowd control."
        },
        Railgun = {
            damage = 100,
            ammo = 5,
            fire_mode = "Single",
            other_details = "Requires high skill."
        },
        Maxim_HMG = {
            damage = 35,
            ammo = 250,
            fire_mode = "Automatic",
            other_details = "Juggernaut mastery weapon."
        },
        PTRS41 = {
            damage = 90,
            ammo = 5,
            fire_mode = "Single",
            other_details = "Rare, long reload."
        }
    }
}

return Database
