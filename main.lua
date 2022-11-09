-- bootstrap the compiler
fennel = require("lib.fennel")
table.insert(package.loaders, fennel.make_searcher({correlate=true}))

fennel.path = love.filesystem.getSource() .. "/?.fnl;" ..
   love.filesystem.getSource() .. "/src/?.fnl;" ..
   love.filesystem.getSource() .. "/src/?/init.fnl;" ..
   fennel.path

debug_mode = true
pp = function(x) print(fennel.view(x)) end
db = function(x)
   if (debug_mode == true) then
      local debug_info = debug.getinfo(1)
      -- print debug.getinfo
      local currentline = debug_info.currentline
      -- local file = debug_info.source:match("^.+/(.+)$")
      local file = debug_info["short_src"] or ""
      local name = debug_info["namewhat"] or ""
      pp({"db", x})
   end
end


js = (require "lib.js")
lume = require("lib.lume")

local make_love_searcher = function(env)
   return function(module_name)
      local path = module_name:gsub("%.", "/") .. ".fnl"
      if love.filesystem.getInfo(path) then
         return function(...)
            local code = love.filesystem.read(path)
            return fennel.eval(code, {env=env}, ...)
         end, path
      end
   end
end

table.insert(package.loaders, make_love_searcher(_G))
table.insert(fennel["macro-searchers"], make_love_searcher("_COMPILER"))

require("lib.js")

-- taken from bump
function rect_isIntersecting(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and
         y1 < y2+h2 and y2 < y1+h1
end

function pointWithin(px,py,x,y,w,h)
  return px < x + w  and px > x and
         py < y + h and py > y
end

math.randomseed( os.time() )

require("wrap")
