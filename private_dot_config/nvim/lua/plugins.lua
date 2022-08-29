local use = require('packer').use
require('packer').startup(function()

    use 'wbthomason/packer.nvim'
    use { 'numToStr/Comment.nvim', tag = 'v0.*' }
    use 'ggandor/lightspeed.nvim'

end)

require('Comment').setup {}
