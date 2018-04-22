local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local textbox = require("wibox.widget.textbox")
local HOME = os.getenv("HOME")
--local manu = require("strlib_open")

-- function to get content from textfile
function fileToString(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end
local tvText = "placeholder"
local tvTitle = "placeholder"
local tvContents = "placeholder"

function extractor(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  local locationOfText = string.find(content, "\n")
  local locationOfTitle = string.find(content, "\n", locationOfText+1)
  tvText = string.sub(content, 0, locationOfText)
  tvTitle = string.sub(content, locationOfText+1, locationOfTitle - 1)
  tvContents = string.sub(content, locationOfTitle + 1)
  f.close()
end

-- some global values
local fileText = fileToString('textfile.txt')
--local isFree 
isFree = true
local notification
extractor('textfile.txt')
--true



-- toggle to create popup
local function toggleFree()
  -- if(isFree) then isFree = false
  --else
   isFree = true
  -- end
end

local textviewer_widget = wibox.widget {
    {   
        id = "icon",
        widget = textbox,
        text= tvText,
        resize = false
    },
    layout = wibox.container.margin(_, 0, 0, 3)
}

local function onEnter()
  if(isFree) then
    isFree = false
    naughty.destroy(notification)
    notification = naughty.notify{
        text =  tvContents,
        title = tvTitle,
        timeout = 5, hover_timeout = 0.5,
        width = 200,
        destroy = toggleFree()
    }
  end
end
if(isFree) then
textviewer_widget:connect_signal("mouse::enter", function() onEnter() end)
end
-- textviewer_widget:connect_signal("mouse::leave", 
--    function() naughty.destroy(notification) 
-- end)
return textviewer_widget
