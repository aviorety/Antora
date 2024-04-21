local Farm = {}


function Farm:find_entity(name: string)
    local entity = workspace.Enemies:FindFirstChild(name)

    if not entity then
        return
    end

    return entity
end


function Farm:sort_by_health(list: table)
    local result = list

    table.sort(result, function(entity_1, entity_2)
        return entity_1.Humanoid.Health > entity_2.Humanoid.Health
    end)

    return result
end


return Farm