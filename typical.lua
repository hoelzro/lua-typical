-- Copyright (c) 2012 Rob Hoelz <rob@hoelz.ro>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

local mt      = {}
local typical = setmetatable({}, mt)
local rawtype = type

local function metatype(value)
  local value_mt = getmetatable(value)

  if value_mt then
    local metatype = value_mt.__type

    if rawtype(metatype) == 'function' then
      metatype = metatype(value)
    end

    if metatype then
      return metatype
    end
  end
end

local resolvers = {
  metatype,
  io.type,
  rawtype,
}

function typical.type(value)
  for _, resolver in ipairs(resolvers) do
    local type = resolver(value)
    if type then
      return type
    end
  end
end

function mt:__call(...)
  return self.type(...)
end

return typical
