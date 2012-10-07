local mt      = {}
local typical = setmetatable({}, mt)
local rawtype = type

function typical.type(value)
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

  return rawtype(value)
end

function mt:__call(...)
  return self.type(...)
end

return typical
