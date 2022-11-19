local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local Sdk = {
    playerData = {},
    playerDataStore = DataStoreService:GetDataStore("PlayerData"),
}

local function characterAdded(character)
    
end

local function playerAdded(player)
    local DEFAULT_SCHEMA = {}

    local playerData
    local success, data = pcall(function()
        return Sdk.playerDataStore:GetAsync(player.UserId)
    end)

    if success then
        playerData = data
    end

    if not playerData then
        playerData = DEFAULT_SCHEMA
    end

    Sdk.playerData[player] = playerData
end

local function playerRemoving()
    local playerData = Sdk.playerData[player]

	local success, err = pcall(function()
        -- save player data
        self.playerDataStore:SetAsync(string.format("Player_%d", player.UserId), playerData)
    end)

    if (err) then
        warn(err)
    end

    repeat
        task.wait()
    until success

    Sdk.playerData[player] = nil
end

function Sdk.init()

    Players.PlayerAdded:Connect(playerAdded)
    Players.PlayerRemoving:Connect(playerRemoving)

end

return Sdk
