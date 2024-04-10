local Character = {}


function Character:alive()
    local character_model = self

    if self:IsA('Player') then
        if not self.Character then
            return
        end
    
        character_model = self.Character
    end
    
    if not character_model:FindFirstChild('HumanoidRootPart') then
        return
    end
    
    if not character_model:FindFirstChild('Humanoid') then
        return
    end
    
    if character_model.Humanoid.Health == 0 then
        return
    end
    
    return true
end


return Character