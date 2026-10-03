-- lua/overseer/template/user/python_run.lua
return {
  name = "Python 运行",
  builder = function()
    return {
      cmd = { "python3" },
      args = { vim.fn.expand("%") },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
