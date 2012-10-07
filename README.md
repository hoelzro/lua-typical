# Typical - fancy type names for Lua

The Lua builtin function `type` has a disadvantage: it only returns the 'primitive'
Lua type of a value.  So if you want to implement your own typing system with custom
type names, `type` won't provide you any interesting information:

```lua
local object = setmetatable({}, { __type = 'object' })
print(type(object)) -- prints 'table'
```

Typical is a library that offers an enhanced version of `type`:

```lua
local type = require 'typical'
local object = setmetatable({}, { __type = 'object' })
print(type(object)) -- prints 'object'
```

Typical is *very* simple: it looks for a `\_\_type` metafield on an object.
If it's a function, it passes the value to the function and uses the result
as the type name.  If it's a string, it uses that.  If `\_\_type` is nil
or returns nil, the builtin `type` is used.
