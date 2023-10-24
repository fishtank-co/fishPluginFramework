-- Services

local Services = {
	CoreGui = game:GetService("CoreGui"),
	Tween = game:GetService("TweenService")
}

-- Variables

local Plugin = {}
local plugin: Plugin = script:FindFirstAncestorWhichIsA("Plugin")

-- Objects

local Objects = {
	Plugin = {},
	Button = {},
	UI = {}
}

Objects.Plugin.__index = Objects.Plugin
Objects.Button.__index = Objects.Button
Objects.UI.__index = Objects.UI

function Objects.UI:Prompt(Message: string)
	local Label = Instance.new("TextLabel", self.GUI)

	Label.Size = UDim2.fromOffset(0, 0)
	Label.AutomaticSize = Enum.AutomaticSize.XY
	Label.AnchorPoint = Vector2.new(0.5, 1)
	Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Label.Position = UDim2.fromScale(0.5, 1)
	Label.TextSize = 20
	Label.TextWrapped = true
	Label.TextStrokeColor3 = Color3.fromRGB(25, 25, 25)
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.SourceSans
	Label.Text = Message

	local Corner = Instance.new("UICorner", Label)

	Corner.Name = "Corner"
	Corner.CornerRadius = UDim.new(0, 20)

	local Padding = Instance.new("UIPadding", Label)

	Padding.Name = "Padding"
	Padding.PaddingBottom = UDim.new(0, 10)
	Padding.PaddingTop = UDim.new(0, 10)
	Padding.PaddingLeft = UDim.new(0, 20)
	Padding.PaddingRight = UDim.new(0, 20)

	local Size = Instance.new("UISizeConstraint", Label)

	Size.Name = "Size"
	Size.MaxSize = Vector2.new(500, math.huge)

	Label.BackgroundTransparency = 1
	Label.TextTransparency = 1
	Label.TextStrokeTransparency = 1

	local In = Services.Tween:Create(Label, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0.8,
		TextTransparency = 0,
		TextStrokeTransparency = 0.8,
		Position = UDim2.fromScale(0.5, 0.95)
	})

	local Out = Services.Tween:Create(Label, TweenInfo.new(10, Enum.EasingStyle.Linear), {
		BackgroundTransparency = 1,
		TextTransparency = 1,
		TextStrokeTransparency = 1
	})

	Out.Completed:Connect(function()
		Label:Destroy()
	end)

	In:Play()

	task.spawn(function()
		task.wait(10)

		Out:Play()
	end)
end

function Objects.Plugin:Create(Type: string, Properties: {})
	local Main = {}

	if Type == "Button" then
		local ClickEvent = Instance.new("BindableEvent")
		local Button: PluginToolbarButton = Plugin.Toolbar:CreateButton(Properties.Name, Properties.Tooltip or "", Properties.Icon or "rbxassetid://4458901886")

		Button.ClickableWhenViewportHidden = true
		Button.Click:Connect(function()
			ClickEvent:Fire(Button)
		end)

		Main.OnClick = ClickEvent.Event

		setmetatable(Main, Objects.Button)
	elseif Type == "UI" then
		local GUI = Services.CoreGui:FindFirstChild(`UI_{self.Name}`)

		if not GUI then
			GUI = Instance.new("ScreenGui")

			GUI.Name = `UI_{self.Name}`
			GUI.DisplayOrder = 999

			GUI.Parent = Services.CoreGui
		else
			GUI = Services.CoreGui[self.Name]
		end

		Main.GUI = GUI

		setmetatable(Main, Objects.UI)
	end

	return Main
end

-- App

local App = {}

function App:Init(Plugin: Plugin)
	plugin = Plugin
end

function App.new(Name: string)
	local self = setmetatable({}, Objects.Plugin)

	local Toolbar = Services.CoreGui:FindFirstChild(Name) or plugin:CreateToolbar(Name)

	Toolbar.Name = Name
	Toolbar.Parent = Services.CoreGui

	Plugin.Toolbar = Toolbar
	self.Name = Name

	return self
end

return App
