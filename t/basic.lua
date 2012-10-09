local typical = require 'typical'

pcall(require, 'Test.More')
require 'Test.More'

plan(11)

do -- basic values (should behave like type() )
  is(typical(nil), 'nil')
  is(typical(true), 'boolean')
  is(typical(1), 'number')
  is(typical('foo'), 'string')
  is(typical(function() end), 'function')
  is(typical({}), 'table')
  is(typical(coroutine.create(function() end)), 'thread')

  if type(_G.newproxy) == 'function' then
    is(typical(newproxy(true)), 'userdata')
  else
    skip 'newproxy is needed for testing userdata'
  end
end

do -- io.type stuff works
  is(typical(io.stdin), 'file')
end

do -- __type metafield
  local value = setmetatable({}, { __type = 'object' })

  is(typical(value), 'object')

  value = setmetatable({ _class = 'something' }, { __type = function(self)
    return self._class
  end})

  is(typical(value), 'something')
end
