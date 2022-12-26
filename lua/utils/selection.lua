local M = {}

function M.getVisualSelection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

local function getSelectedLines()
  local _, first_line, _, _ = unpack(vim.fn.getpos("v"))
  local _, last_line,  _, _ = unpack(vim.fn.getpos("."))

  if last_line < first_line  then
    return last_line, first_line
  else
    return first_line, last_line
  end
end

function M.reverseLines()
  local first_line, last_line = getSelectedLines()
  print(first_line, last_line)
  local reversed_lines = {}
  for i = last_line, first_line, -1 do
    reversed_lines[#reversed_lines + 1] = vim.fn.getline(i)
  end

  for i = #reversed_lines, 1, -1 do
    vim.fn.setline(first_line + i - 1, reversed_lines[i])
  end
end

return M
