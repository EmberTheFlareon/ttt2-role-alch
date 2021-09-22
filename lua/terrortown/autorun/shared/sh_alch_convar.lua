
CreateConVar("ttt2_alch_time_until_potion", "35", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_alch_potion_timer_repeat", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})


hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicAlchemistCVars", function(tbl)
  tbl[ROLE_ALCHEMIST] = tbl[ROLE_ALCHEMIST] or {}


  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_time_until_potion",
    slider = true,
    min = 1,
    max = 60,
    desc = "ttt2_alch_time_until_potion (def. 35)"
  })
  
  table.insert(tbl[ROLE_ALCHEMIST], {
    cvar = "ttt2_alch_potion_timer_repeat",
    slider = true,
    min = 1,
    max = 60,
    desc = "ttt2_alch_potion_timer_repeat (def. 5)"
  })

end)
