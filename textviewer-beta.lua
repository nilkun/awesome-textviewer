local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local textbox = require("wibox.widget.textbox")
local HOME = os.getenv("HOME")

-- some global values
isFree = 1
--true

-- function to get content from textfile
function fileToString(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

-- toggle to create popup
local function toggleFree()
  if(isFree == 1) then isFree = 0
  else isFree = 1
  end
end

-- release the popup
local function setFree()
  isFree = 1
end

local nilkun_widget = wibox.widget {
    {
        id = "icon",
        widget = textbox,
        text=fileToString('title.txt'),
        resize = false
    },
    layout = wibox.container.margin(_, 0, 0, 3)
}
--local openOnEnter = 0;
-- openOnEnter++;
-- if(openOnEnter = 0)
local function onEnter()
  if(isFree==1) then
    isFree = 0
    naughty.notify{
        text =  fileToString('text.txt'),
        title = "Grab the title",
        timeout = 5, hover_timeout = 0.5,
        width = 200,
        destroy = toggleFree()
    }
  end
end

if(isFree == 1) then
nilkun_widget:connect_signal("mouse::enter", function() onEnter() end)
end
return nilkun_widget
