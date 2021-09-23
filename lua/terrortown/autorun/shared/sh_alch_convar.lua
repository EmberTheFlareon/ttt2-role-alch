
CreateConVar("ttt2_alch_time_until_potion", "35", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_potion_timer_repeat", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("ttt2_alch_jump_potion_time", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_jump_potion_jump", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_jump_potion_splash", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("ttt2_alch_speed_potion_time", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_speed_potion_speed", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_speed_potion_splash", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})


CreateConVar("ttt2_alch_armor_potion_amnt", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_armor_potion_splash", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("ttt2_alch_health_potion_splash", "250", {FCVAR_ARCHIVE, FCVAR_NOTIFY})


hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicAlchemistCVars", function(tbl)
  tbl[ROLE_ALCHEMIST] = tbl[ROLE_ALCHEMIST] or {}


  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_time_until_potion",
    slider = true,
    min = 1,
    max = 60,
    desc = "Time until potion (def. 35)"
  })
  
  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_potion_timer_repeat",
    slider = true,
    min = 1,
    max = 60,
    desc = "How many times a potion is given (def. 5)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_armor_potion_amnt",
    slider = true,
    min = 1,
    max = 60,
    desc = "Armor Potion Amount (def. 10)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_armor_potion_splash",
    slider = true,
    min = 200,
    max = 400,
    desc = "Armor Potion Splash Radius (def. 250)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_speed_potion_time",
    slider = true,
    min = 1,
    max = 60,
    desc = "Speed Potion Duration (def. 5)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_speed_potion_speed",
    slider = true,
    min = 250,
    max = 600,
    desc = "Speed Potion Speed (def. 250)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_speed_potion_splash",
    slider = true,
    min = 200,
    max = 400,
    desc = "Speed Potion Splash Radius (def. 250)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_jump_potion_jump",
    slider = true,
    min = 200,
    max = 600,
    desc = "Jump Potion Height (def. 250)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_jump_potion_time",
    slider = true,
    min = 1,
    max = 60,
    desc = "Jump Potion Duration (def. 5)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_jump_potion_splash",
    slider = true,
    min = 200,
    max = 400,
    desc = "Jump Potion Splash Radius (def. 250)"
  })

  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_health_potion_splash",
    slider = true,
    min = 200,
    max = 400,
    desc = "Health Potion Splash Radius (def. 250)"
  })
  
end)
