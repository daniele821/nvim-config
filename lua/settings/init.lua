local defaults = require("settings.defaults")
local status, user = pcall(require,"settings.user")
if not status or type(user) ~= "table" then
    return defaults
end
return vim.tbl_deep_extend("force", defaults, user)
