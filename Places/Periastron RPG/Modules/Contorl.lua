local Control = {}


function Control:get_weapon()
    local tool = self:FindFirstChildOfClass('Tool')

    if not tool then
        return
    end

    if tool.Name:lower():find('potion') then
        return
    end

    return tool
end


function Control:tool_state()
    if self.state then
        self.tool:Activate()
    else
        self.tool:Deactivate()
    end
end


return Control
