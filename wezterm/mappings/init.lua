local fun = require "utils.fun"

return fun.tbl_merge(
  (require "mappings.default"),
  (require "mappings.modes")
)

