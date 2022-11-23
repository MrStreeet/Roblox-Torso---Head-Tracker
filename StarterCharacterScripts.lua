----------------------------------------------------------------------------------------------
-- 						  __  __      _____ _                      _              			--
-- 						 |  \/  |    / ____| |                    | |             			--
-- 						 | \  / |_ _| (___ | |_ _ __ ___  ___  ___| |_            			--
-- 						 | |\/| | '__\___ \| __| '__/ _ \/ _ \/ _ \ __|           			--
-- 						 | |  | | |  ____) | |_| | |  __/  __/  __/ |_            			--
-- 						 |_|  |_|_| |_____/ \__|_|  \___|\___|\___|\__|           			--
--																				  			--
--								Made By MrStreeet (@StreeetYT)					  			--
--					 Leaking or re-selling this product it's illegal and          			--
--      				you'll get reported on Roblox. --Att MrStreeet						--
--							 Any Doubt? Discord: ?rStreeet#1037								--
----------------------------------------------------------------------------------------------


--Cámara // Camera
local camera = workspace.CurrentCamera

--Variable personaje y jugador // Character and player variable
local character = game.Players.LocalPlayer.Character
local Humanoid = character:WaitForChild("Humanoid")
local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")

--Cuello y cabeza // Neck and head
local Head = character:WaitForChild("Head")
local Neck = Head:WaitForChild("Neck")

--Cadera y pecho // Waist and torso
local Torso = character:WaitForChild("UpperTorso")
local Waist = Torso:WaitForChild("Waist")

--Posición del cuello y la cadera // Neck and waist position
local NeckOriginC0 = Neck.C0.Y
local WaistOriginC0 = Waist.C0.Y

--Variable del almacenamiento de réplica // Replicated Storage variable
local RE = game.ReplicatedStorage
wait()
local tweenService = game:GetService("TweenService")

local CFNew, CFAng, asin = CFrame.new, CFrame.Angles, math.asin

--Vinculación cámara al personaje // Link camera to character
game:GetService("RunService").RenderStepped:Connect(function()
	local cameraDirection = HumanoidRootPart.CFrame:toObjectSpace(camera.CFrame).lookVector
	
	-- No tocar (Solo en caso de fallo debido a los RTHRO) // Do not touch (Just in case of bug cause RTHRO models)
	if Neck and Waist then
		-- Cuello // Neck
		Neck.C0 = CFNew(0, NeckOriginC0, 0) * CFAng(0, -asin(cameraDirection.x / 1.25), 0) * CFAng(asin(cameraDirection.y / 1.5), 0, 0)
		-- Cadera // Waist
		Waist.C0 = CFNew(0, WaistOriginC0, 0) * CFAng(0, -asin(cameraDirection.x / 2), 0) * CFAng(asin(cameraDirection.y / 2), 0, 0)
	end
end)

--Hacer visible el movimiento a los demás usuarios
	--Cuello
RE.Look.OnClientEvent:Connect(function(otherPlayer, neckCFrame)
	local Neck = otherPlayer.character:FindFirstChild("Neck", true)

	if Neck then
		tweenService:Create(Neck, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = neckCFrame + Vector3.new(0,0,0)}):Play()
	end
end)

	--Cadera // Waist
RE.Look.OnClientEvent:Connect(function(otherPlayer, waistCFrame)
	local Waist = otherPlayer.Character:FindFirstChild("Waist", true)
	
	if Waist then
		tweenService:Create(Waist, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {C0 = waistCFrame - Vector3.new(0, 0.8, 0)}):Play()
	end
end)

-- Conectividad y tiempo [NO TOCAR] // Conectivity and delay [DO NOT TOUCH]
local enabled = true
camera.Changed:Connect(function()
	if enabled == true then
		RE.Look:FireServer(Neck.C0)
		enabled = false
		if enabled == false then
			wait(0.3) -- Tiempo de espera // Delay (Cambiarlo puede causar problemas de conectividad // High time may cause connectivity problems)
			RE.Look:FireServer(Neck.C0)
			enabled = true
		end
	end
end)