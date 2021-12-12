vim.cmd [[packadd packer.nvim]]

local packer = nil
local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
		'kyazdani42/nvim-web-devicons', -- optional, for file icon
    	},
	config = function() require'nvim-tree'.setup {} end
	}
	use "savq/melange"

end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
