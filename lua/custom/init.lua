local defaults = require("custom.defaults")
local status, user = pcall(require,"custom.user")
if not status then
    return defaults
end
return vim.tbl_deep_extend("force", defaults, user)
