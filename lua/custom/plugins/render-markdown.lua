return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' }, -- Only load for markdown files
  opts = {
    -- Preset rendering styles
    preset = 'obsidian', -- Use obsidian-style rendering (beautiful callouts, nice bullets)

    -- Heading configuration
    heading = {
      enabled = true,
      sign = true,
      icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' }, -- Plain markdown heading symbols
      foregrounds = {
        'RenderMarkdownH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
    },

    -- Code block configuration
    code = {
      enabled = true,
      sign = true,
      style = 'full', -- Full width background
      position = 'left',
      language_pad = 0,
      left_pad = 1,
      right_pad = 1,
      width = 'block',
      border = 'thin',
    },

    -- Bullet points
    bullet = {
      enabled = true,
      icons = { '•', '◦', '▸', '▹' }, -- Smaller, subtle bullets
    },

    -- Checkboxes
    checkbox = {
      enabled = true,
      unchecked = {
        icon = '󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
      },
      checked = {
        icon = '󰱒 ',
        highlight = 'RenderMarkdownChecked',
      },
      custom = {
        todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
      },
    },

    -- Link rendering - this is the key feature!
    link = {
      enabled = true,
      -- Icon for regular links
      image = '󰥶 ', -- Image icon
      hyperlink = '󰌹 ', -- Link icon
      -- Highlight for links
      highlight = 'RenderMarkdownLink',
      -- Custom link patterns for different services
      custom = {
        web = { pattern = '^http[s]?://', icon = '󰖟 ', highlight = 'RenderMarkdownLink' },
        github = { pattern = 'github%.com', icon = ' ', highlight = 'RenderMarkdownLink' },
        discord = { pattern = 'discord%.com', icon = '󰙯 ', highlight = 'RenderMarkdownLink' },
        reddit = { pattern = 'reddit%.com', icon = '󰑍 ', highlight = 'RenderMarkdownLink' },
        youtube = { pattern = 'youtube%.com', icon = '󰗃 ', highlight = 'RenderMarkdownLink' },
        stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ', highlight = 'RenderMarkdownLink' },
        wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 ', highlight = 'RenderMarkdownLink' },
      },
    },

    -- Block quotes
    quote = {
      enabled = true,
      icon = '▋',
      repeat_linebreak = true,
    },

    -- Pipe tables
    pipe_table = {
      enabled = true,
      style = 'full',
      cell = 'padded',
      border = {
        '┌', '┬', '┐',
        '├', '┼', '┤',
        '└', '┴', '┘',
        '│', '─',
      },
    },

    -- Callouts (info, warning, etc.)
    callout = {
      note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
      tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
      important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
      warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
      caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
    },

    -- Inline code
    inline_code = {
      enabled = true,
      highlight = 'RenderMarkdownCode',
    },

    -- Anti-conceal - show raw text on cursor line
    anti_conceal = {
      enabled = true,
    },

    -- Performance: only render visible window
    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 3,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = '',
      },
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)

    -- Custom highlight groups to work beautifully with gruvbox
    vim.cmd([[
      " Heading foregrounds - bright gruvbox colors
      hi RenderMarkdownH1 guifg=#fb4934 gui=bold
      hi RenderMarkdownH2 guifg=#fabd2f gui=bold
      hi RenderMarkdownH3 guifg=#b8bb26 gui=bold
      hi RenderMarkdownH4 guifg=#83a598 gui=bold
      hi RenderMarkdownH5 guifg=#d3869b gui=bold
      hi RenderMarkdownH6 guifg=#8ec07c gui=bold

      " Links - gruvbox blue
      hi RenderMarkdownLink guifg=#83a598 gui=underline

      " Code - gruvbox dark background
      hi RenderMarkdownCode guibg=#3c3836 guifg=#8ec07c

      " Checkboxes
      hi RenderMarkdownChecked guifg=#b8bb26
      hi RenderMarkdownUnchecked guifg=#928374
      hi RenderMarkdownTodo guifg=#fabd2f

      " Callouts
      hi RenderMarkdownInfo guifg=#83a598
      hi RenderMarkdownSuccess guifg=#b8bb26
      hi RenderMarkdownHint guifg=#8ec07c
      hi RenderMarkdownWarn guifg=#fabd2f
      hi RenderMarkdownError guifg=#fb4934

      " Markdown emphasis - italic and bold
      hi @markup.italic gui=italic
      hi @markup.strong gui=bold
      hi @markup.strikethrough gui=strikethrough
      " For older treesitter versions
      hi @text.emphasis gui=italic
      hi @text.strong gui=bold
    ]])
  end,
}
