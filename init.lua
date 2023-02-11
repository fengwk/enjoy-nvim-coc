-- 执行初始化脚本
local utils_ok, utils = pcall(require, "fengwk.utils")
if utils_ok then
    local nvim_config_path = vim.fn.stdpath("config")
    utils.exec_cmd(nvim_config_path .. "/lib/init.sh")
end

-- 导入模块
require("fengwk.plugins-setup")
require("fengwk.core.options")
require("fengwk.core.keymaps")
require("fengwk.plugins")
require("fengwk.core.colorscheme")
