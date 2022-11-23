-- Cuello // Neck
game.ReplicatedStorage.Look.OnServerEvent:Connect(function(player, neckCFrame)
	for key, value in pairs(game.Players:GetChildren()) do
		if value ~= player and (value.Character.Head.Position - player.Character.Head.Position).Magnitude < 10 then
			game.ReplicatedStorage.Look:FireClient(value, player, neckCFrame)
		end
	end
end)

-- Pecho // Torso
game.ReplicatedStorage.Look.OnServerEvent:Connect(function(player, waistCFrame)
	for key, value in pairs(game.Players:GetChildren()) do
		if value ~= player then
			game.ReplicatedStorage.Look:FireClient(value, player, waistCFrame)
		end
	end
end)
