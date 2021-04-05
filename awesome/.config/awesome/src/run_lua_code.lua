local naughty = require('naughty')

-- {{{
-- https://www.reddit.com/r/awesomewm/comments/6cwevs/the_purpose_of_run_lua_code/dhysrk9/
-- turn run Lua command into a calculator
prt = function(...) naughty.notify{text=table.concat({...}, '\t')} end
col = function(str) naughty.notify{text="   ", bg=str} end
-- }}}
