# Typical - fancy type names for Lua

The Lua builtin function `type` has a disadvantage: it only returns the 'primitive'
Lua type of a value.  So if you want to implement your own typing system with custom
type names, `type` won't provide you any interesting information:

```lua
local object = setmetatable({}, { __type = 'object' })
print(type(object)) -- prints 'table'
```

Some libraries (such as the I/O library included with standard Lua) offer alternative
type functions for identifying types used within that library:

```lua
print(io.type(value) or type(value))
```

Typical is a library that offers an enhanced version of `type` that is meant to be
more generic:

```lua
local type = require 'typical'
local object = setmetatable({}, { __type = 'object' })
print(type(object)) -- prints 'object'
```

Typical is *very* simple: it looks for a `__type` metafield on an object.
If it's a function, it passes the value to the function and uses the result
as the type name.  If it's a string, it uses that.  If `__type` is `nil`
or returns `nil`, the builtin `type` is used.

# Library Overview

If you want to use typical just like a function, you can:

```lua
local type = require 'typical'
```

However, the type object is just an alias for `typical.type`:

```lua
local typical = require 'typical'
print(typical.type(value)) -- same as typical(value)
```

Typical also provides other type-related methods for your convenience;
you can read about them in the 'Methods' section.

# Methods

## typical.type(value)

Returns the type name for a value.
