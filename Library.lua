local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')

for _, object in CoreGui:GetChildren() do
    if object.Name == 'Antora' then
        object:Destroy()
    end
end

local Library = {}
Library.flags = {}


function Library:new()
    local screen_gui = Instance.new('ScreenGui', CoreGui)
    screen_gui.Name = 'Antora'

    local container = game:GetObjects('rbxassetid://17084588177')[1]
    container.Parent = screen_gui
    container.Draggable = true
    container.Active = true

    local tabs = game:GetObjects('rbxassetid://17084048806')[1]
    tabs.Parent = container.LeftContainer

    local TabFunctions = {}

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
            tab.BackgroundTransparency = 0
            tab.UIStroke.Color = Color3.fromRGB(50, 98, 58)
            tab.Icon.ImageTransparency = 0
            tab.Title.TextTransparency = 0
        end

        page_1.Parent = container
        page_2.Parent = container

        tab.MouseButton1Click:Connect(function()
            for _, object in container:GetChildren() do
                if object.Name:find('Page') then
                    object.Visible = false
                end
            end

            page_1.Visible = true
            page_2.Visible = true

            TweenService:Create(tab, TweenInfo.new(0.2), {
                BackgroundTransparency = 0
            }):Play()

            TweenService:Create(tab.UIStroke, TweenInfo.new(0.2), {
                Color = Color3.fromRGB(50, 98, 58)
            }):Play()

            TweenService:Create(tab.Icon, TweenInfo.new(0.2), {
                ImageTransparency = 0
            }):Play()

            TweenService:Create(tab.Title, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play()

            for _, object in tabs:GetChildren() do
                if object == tab then
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

            if self.state then
                toggle.Checkbox.BackgroundColor3 = Color3.fromRGB(81, 163, 94)
                toggle.Checkbox.Icon.ImageTransparency = 0
            else
                toggle.Checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                toggle.Checkbox.Icon.ImageTransparency = 1
            end
        
            self.callback(self.state)

            toggle.MouseButton1Click:Connect(function()
                self.state = not self.state

                if self.state then
                    TweenService:Create(toggle.Checkbox, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(81, 163, 94)
                    }):Play()
    
                    TweenService:Create(toggle.Checkbox.Icon, TweenInfo.new(0.2), {
                        ImageTransparency = 0
                    }):Play()
                else
                    TweenService:Create(toggle.Checkbox, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    }):Play()
    
                    TweenService:Create(toggle.Checkbox.Icon, TweenInfo.new(0.2), {
                        ImageTransparency = 1
                    }):Play()
                end
            
                self.callback(self.state)
            end)
        end

        return Functions
    end

    return TabFunctions
end


return Library
