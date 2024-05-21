local defaults = require("settings.defaults")
local status, user = pcall(require,"settings.user")
if not status then
    return defaults
end
return vim.tbl_deep_extend("force", defaults, user)
