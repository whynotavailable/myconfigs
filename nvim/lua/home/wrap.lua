local function hard_wrap()
  local linelength = tonumber(vim.o.colorcolumn)
  local vstart = vim.fn.getpos("v")
  local vend = vim.fn.getpos(".")

  if vstart[2] > vend[2] then
    local tmp = vend
    vend = vstart
    vstart = tmp
  end

  -- Need to reset the columns to be correct otherwise everything breaks.
  vstart[3] = 1
  vend[3] = vim.v.maxcol

  if false then
    print(vstart[2], vstart[3], vend[2], vend[3])
    return
  end

  if vstart == nil or vend == nil then
    -- no selection: eject
    return
  end

  local buffer = ""
  local replacetext = {}

  for _, value in ipairs(vim.fn.getregion(vstart, vend)) do
    for word in string.gmatch(value, "%S+") do
      local bufferlen = string.len(buffer)
      local wordlen = string.len(word)

      if buffer ~= "" then
        -- TODO: Make the 100 here customizable
        if (bufferlen + wordlen + 1) > linelength then
          table.insert(replacetext, buffer)
          buffer = ""
        else
          buffer = buffer .. " "
        end
      end

      buffer = buffer .. word
    end
  end

  table.insert(replacetext, buffer)

  -- I have no idea why the start line is zero indexed.
  vim.api.nvim_buf_set_lines(0, vstart[2] - 1, vend[2], false, replacetext)
  vim.api.nvim_input("<esc>")
end

vim.keymap.set({ "v", "x" }, "<Leader>pp", hard_wrap, {
  desc = "Wrap Some Text",
  noremap = true,
})
