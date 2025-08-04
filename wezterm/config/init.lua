local fun = require "utils.fun"

local module = {}

function module.get_config()
  return fun.tbl_merge(
    (require "config.gpu"),
    (require "config.appearance").get_config(),
    (require "config.general")
  )
end

return module
