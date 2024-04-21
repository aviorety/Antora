local LocalPlayer = game:GetService('Players').LocalPlayer
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')

local Character = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Antora/main/MainModules/Character.lua'))()
local 

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Antora/main/Library.lua'))()

if not Library then
    return
end

local loops = {}
local main = Library.new()


do
    local farm_tab = main.create_tab('Farm')

    local title = farm_tab.create_title({
        page = 'left',
        text = 'AutoFarm'
    })
    
    local enabled = farm_tab.create_toggle({
        page = 'left',
        text = 'Enabled',
        flag = 'auto_farm',
        state = false,
    
        callback = function(state: boolean)
            if state then
                loops['auto_farm'] = RunService.Heartbeat:Connect(function()
                    
                end)
            else
                if loops['auto_farm'] then
                    loops['auto_farm']:Disconnect()
                    loops['auto_farm'] = nil
                end
            end
        end
    })

    local best_entity = farm_tab.create_toggle({
        page = 'left',
        text = 'BestEntity',
        flag = 'best_entity',
        state = false,
    
        callback = function(state: boolean)
        end
    })
end