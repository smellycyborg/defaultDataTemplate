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

    local playerData = Sdk.playerDataStore:GetAsync(player.UserId)

    if not playerData then
        playerData = DEFAULT_SCHEMA
    end

    Sdk.playerData = playerData
end

local function playerRemoving()
    local playerData = Sdk.playerData[player]

	-- save player data
	self.playerDataStore:SetAsync(string.format("Player_%d", player.UserId), playerData)
end

function Sdk.init()

    Players.PlayerAdded:Connect(playerAdded)
    Players.PlayerRemoving:Connect(playerRemoving)

end

return Sdk