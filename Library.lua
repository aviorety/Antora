local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')

for _, object in CoreGui:GetChildren() do
    if object.Name == 'Antora' then
        object:Destroy()
    end
end

local assets = game:GetObjects('rbxassetid://17093091546')[1]

local GUI_OPEN = false

local DRAG = false
local DRAG_POSITION = nil
local START_POSITION = nil

local Library = {}
Library.flags = {}


function Library:play_toggle_sound()
    if self then
        assets.Sounds.ToggleEnabled:Play()
    else
        assets.Sounds.ToggleDisabled:Play()
    end
end


function Library:update_toggle()
    Library.play_toggle_sound(self.state)

    if self.state then
        TweenService:Create(self.toggle.Checkbox, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(81, 163, 94)
        }):Play()

        TweenService:Create(self.toggle.Checkbox.Icon, TweenInfo.new(0.3), {
            ImageTransparency = 0
        }):Play()
    else
        TweenService:Create(self.toggle.Checkbox, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()

        TweenService:Create(self.toggle.Checkbox.Icon, TweenInfo.new(0.3), {
            ImageTransparency = 1
        }):Play()
    end
end


function Library:drag()
	if not DRAG_POSITION then
		return
	end
	
	if not START_POSITION then
		return
	end
	
	local delta = self.input.Position - DRAG_POSITION
	local position = UDim2.new(START_POSITION.X.Scale, START_POSITION.X.Offset + delta.X, START_POSITION.Y.Scale, START_POSITION.Y.Offset + delta.Y)

	TweenService:Create(self.container, TweenInfo.new(0.2), {
		Position = position
	}):Play()

    TweenService:Create(self.shadow, TweenInfo.new(0.2), {
		Position = position
	}):Play()
end


function Library:new()
    local screen_gui = game:GetObjects('rbxassetid://17093344927')[1]
    screen_gui.Parent = CoreGui

    local container = game:GetObjects('rbxassetid://17093181844')[1]
    container.Parent = screen_gui

    local shadow = game:GetObjects('rbxassetid://17093327176')[1]
    shadow.Parent = screen_gui

    UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
        if process then
            return
        end

        if input.KeyCode == Enum.KeyCode.Insert then
            GUI_OPEN = not GUI_OPEN

            if not GUI_OPEN then
                TweenService:Create(container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()

                TweenService:Create(shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()
            else
                TweenService:Create(container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 789, 0, 443)
                }):Play()

                TweenService:Create(shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 860, 0, 492)
                }):Play()
            end
        end
    end)

    container.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            DRAG = true
            DRAG_POSITION = input.Position
            START_POSITION = container.Position
    
            TweenService:Create(shadow, TweenInfo.new(0.6), {
                ImageTransparency = 0
            }):Play()

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    DRAG = false
                    DRAG_POSITION = nil
                    START_POSITION = nil

                    TweenService:Create(shadow, TweenInfo.new(0.6), {
                        ImageTransparency = 0.5
                    }):Play()
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            Library.drag({
                input = input,
                container = container,
                shadow = shadow
            })
        end
    end)

    local tabs = game:GetObjects('rbxassetid://17084048806')[1]
    tabs.Parent = container.LeftContainer

    local TabFunctions = {}

    function TabFunctions:update_pages()
        for _, object in container:GetChildren() do
            if object.Name:find('Page') then
                object.Visible = false
            end
        end
    
        self.page_1.Visible = true
        self.page_2.Visible = true
    end
    
    function TabFunctions:update_tabs()
        TabFunctions.update_pages({
            page_1 = self.page_1,
            page_2 = self.page_2
        })

        TweenService:Create(self.tab, TweenInfo.new(0.2), {
            BackgroundTransparency = 0
        }):Play()
    
        TweenService:Create(self.tab.UIStroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(50, 98, 58)
        }):Play()
    
        TweenService:Create(self.tab.Icon, TweenInfo.new(0.2), {
            ImageTransparency = 0
        }):Play()
    
        TweenService:Create(self.tab.Title, TweenInfo.new(0.2), {
            TextTransparency = 0
        }):Play()
    
        for _, object in tabs:GetChildren() do
            if object == self.tab then
                continue
            end
    
            if object.Name == 'Tab' then
                TweenService:Create(object, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play()
    
                TweenService:Create(object.UIStroke, TweenInfo.new(0.2), {
                    Color = Color3.fromRGB(30, 30, 35)
                }):Play()
    
                TweenService:Create(object.Icon, TweenInfo.new(0.2), {
                    ImageTransparency = 0.5
                }):Play()
    
                TweenService:Create(object.Title, TweenInfo.new(0.2), {
                    TextTransparency = 0.5
                }):Play()
            end
        end
    end

    function TabFunctions:create_tab()
        local tab = game:GetObjects('rbxassetid://17084806493')[1]
        tab.Parent = tabs
        tab.Title.Text = self

        local page_1 = game:GetObjects('rbxassetid://17084082350')[1]
        local page_2 = game:GetObjects('rbxassetid://17084088521')[1]
        
        if container:FindFirstChild('Page_2') then
            page_1.Visible = false
            page_2.Visible = false
        else
            TabFunctions.update_tabs({
                tab = tab,
                page_1 = page_1,
                page_2 = page_2
            })
        end

        page_1.Parent = container
        page_2.Parent = container

        tab.MouseButton1Click:Connect(function()
            TabFunctions.update_tabs({
                tab = tab,
                page_1 = page_1,
                page_2 = page_2
            })
        end)

        local Functions = {}

        function Functions:create_title()
            local title = game:GetObjects('rbxassetid://17084099039')[1]
            title.Parent = self.page == 'left' and page_1 or page_2
            title.Text = self.text
        end

        function Functions:create_toggle()
            local toggle = game:GetObjects('rbxassetid://17084571638')[1]
            toggle.Parent = self.page == 'left' and page_1 or page_2
            toggle.Title.Text = self.text

            Library.update_toggle({
                toggle = toggle,
                state = self.state
            })
        
            self.callback(self.state)
            Library.flags[self.flag] = self.state

            toggle.MouseButton1Click:Connect(function()
                self.state = not self.state
                Library.flags[self.flag] = self.state

                Library.update_toggle({
                    toggle = toggle,
                    state = self.state
                })
            
                self.callback(self.state)
            end)
        end

        return Functions
    end

    return TabFunctions
end


return Library
