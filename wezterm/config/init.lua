local module = {}

function module.get_config()
  return require("utils.fun").tbl_merge(
    (require "config.gpu"),
    (require "config.appearance").get_config(),
    (require "config.font"),
    (require "config.general")
  )
end

return module
