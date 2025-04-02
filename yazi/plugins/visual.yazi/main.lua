---@sync entry
return {
  entry = function()
    local nor = tostring(cx.active.mode):find("nor")
    ya.mgr_emit(nor and "visual_mode" or "escape", { visual = true })
  end,
}
