# fishPluginFramework

fishPluginFramework (abbreviated to FPF) is a framework for Roblox Plugins. Created for easy development of plugins.

### Example

```lua
-- Grab the framework using require
local Framework = require(15158507995)

-- We need to init the core plugin object.
Framework:Init(plugin)

-- Create a Plugin with a name for the toolbar
local Plugin = Framework.new("My Toolbar")

-- Create a UI object (Optional)
local UI = Plugin:Create("UI")
-- Create a button object
local Button = Plugin:Create("Button", {
	Name = "Test Button",
	Tooltip = "For testing purposes.",
	Icon = "rbxassetid://113981357"
})

-- Connect to the OnClick event, which returns the PluginToolbarButton object
Button.OnClick:Connect(function(MyButton)
	MyButton.Enabled = false
	
  -- Use the FPF's prompt command to send a prompt at the bottom of the screen
	UI:Prompt("I'm using FPF!")
end)
```

Result

![Result](https://media.discordapp.net/attachments/1093703948084445196/1166363481495322696/image.png)
![OnClick](https://cdn.discordapp.com/attachments/1093703948084445196/1166363688710709420/image.png)
