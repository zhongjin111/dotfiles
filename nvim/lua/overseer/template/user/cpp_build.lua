-- lua/overseer/template/user/cpp_build.lua
return {
  name = "C++ 编译",
  builder = function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    return {
      cmd = { "g++" },
      args = { "-std=c++20", "-g", "-O2", "-Wall", file, "-o", output },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c", "cpp" },
  },
}
