
--[[ Owen Dexv | Client ]]
local v1 = game:GetService("Players");
local v2 = game:GetService("UserInputService");
local v3 = game:GetService("RunService");
local v4 = v1.LocalPlayer;
local v5 = v4:WaitForChild("PlayerGui");
local v6 = v5:FindFirstChild("OwenDexv");
if v6 then v6:Destroy(); end;

local v7 = {
	Background = Color3.fromRGB(12,12,14),
	Header = Color3.fromRGB(20,20,23),
	Row = Color3.fromRGB(24,24,27),
	Alternate = Color3.fromRGB(17,17,20),
	Input = Color3.fromRGB(30,30,34),
	Selected = Color3.fromRGB(64,64,75),
	Text = Color3.fromRGB(250,250,250),
	Muted = Color3.fromRGB(180,180,185),
	Border = Color3.fromRGB(208,208,213)
};
local v8 = Instance.new("ScreenGui");
v8.Name = "OwenDexv";
v8.ResetOnSpawn = false;
v8.DisplayOrder = 100;
v8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
v8.Parent = v5;

local v9 = {
	"Workspace","Players","Lighting","MaterialService",
	"NetworkClient","ReplicatedFirst","ReplicatedStorage",
	"ServerScriptService","ServerStorage","StarterGui",
	"StarterPack","StarterPlayer","SoundService",
	"TextChatService","Teams","Chat"
};
local v10 = {};
for _,v11 in ipairs(v9) do
	local v12,v13 = pcall(function()
		return game:GetService(v11);
	end);
	if v12 and v13 then table.insert(v10,v13); end;
end;

local v14 = game;
local v15 = {[game] = true};
local v16 = nil;
local v17 = false;
local v18 = {};
local v19 = 0;
local v20 = false;

local function v21(v22,v23,v24) --[[ Name: Create ]]
	local v25 = Instance.new(v22);
	for v26,v27 in pairs(v24 or {}) do
		v25[v26] = v27;
	end;
	v25.Parent = v23;
	return v25;
end;

local function v28(v29,v30,v31,v32) --[[ Name: Label ]]
	return v21("TextLabel",v29,{
		Name = v30,
		Size = v31,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = v32,
		TextColor3 = v7.Text,
		TextSize = 14,
		Font = Enum.Font.SourceSans,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd
	});
end;

local function v33(v34,v35,v36,v37) --[[ Name: Button ]]
	return v21("TextButton",v34,{
		Name = v35,
		Size = v36,
		Text = v37,
		BackgroundColor3 = v7.Header,
		BorderSizePixel = 0,
		TextColor3 = v7.Text,
		TextSize = 14,
		Font = Enum.Font.SourceSans,
		AutoButtonColor = true
	});
end;

local function v38(v39) --[[ Name: ObjectIcon ]]
	if v39:IsA("Players") or v39:IsA("Player") then return "♙",Color3.fromRGB(110,190,245); end;
	if v39:IsA("Workspace") then return "◉",Color3.fromRGB(120,180,250); end;
	if v39:IsA("Folder") then return "▣",Color3.fromRGB(230,184,75); end;
	if v39:IsA("Model") then return "⬡",Color3.fromRGB(165,190,230); end;
	if v39:IsA("MeshPart") then return "◆",Color3.fromRGB(130,200,235); end;
	if v39:IsA("BasePart") then return "■",Color3.fromRGB(150,190,230); end;
	if v39:IsA("Sound") then return "♫",Color3.fromRGB(245,160,80); end;
	if v39:IsA("LocalScript") then return "▤",Color3.fromRGB(100,220,160); end;
	if v39:IsA("ModuleScript") then return "▤",Color3.fromRGB(185,140,235); end;
	if v39:IsA("Script") then return "▤",Color3.fromRGB(120,180,245); end;
	if v39:IsA("GuiObject") then return "▣",Color3.fromRGB(240,160,110); end;
	if v39:IsA("LayerCollector") then return "▣",Color3.fromRGB(240,160,110); end;
	if v39:IsA("UIGradient") then return "◉",Color3.fromRGB(195,195,240); end;
	if v39:IsA("Light") then return "☼",Color3.fromRGB(255,215,110); end;
	if v39:IsA("ValueBase") then return "◇",Color3.fromRGB(125,220,155); end;
	if v39:IsA("Backpack") then return "▣",Color3.fromRGB(225,175,90); end;
	return "◈",v7.Muted;
end;

local function v40(v41,v42,v43) --[[ Name: Window ]]
	local v44 = v21("Frame",v8,{
		Name = v41,
		Size = v43,
		Position = v42,
		BackgroundColor3 = v7.Background,
		BorderColor3 = v7.Border,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Active = true
	});
	v21("UICorner",v44,{CornerRadius=UDim.new(0,8)});
	v21("UIStroke",v44,{Color=v7.Border,Transparency=0.32,Thickness=1});
	local v45 = v21("Frame",v44,{
		Name = "TitleBar",
		Size = UDim2.new(1,0,0,30),
		BackgroundColor3 = v7.Header,
		BorderSizePixel = 0,
		Active = true
	});
	local v46 = v28(v45,"Title",UDim2.new(1,-70,1,0),v41);
	v46.Position = UDim2.fromOffset(9,0);
	v46.TextSize = 16;
	v46.Font = Enum.Font.SourceSansSemibold;

	local v47 = v33(v45,"Minimize",UDim2.fromOffset(28,30),"−");
	v47.Position = UDim2.new(1,-58,0,0);
	local v48 = v33(v45,"Close",UDim2.fromOffset(28,30),"×");
	v48.Position = UDim2.new(1,-29,0,0);

	local v49 = v21("Frame",v44,{
		Name = "Body",
		Position = UDim2.fromOffset(0,30),
		Size = UDim2.new(1,0,1,-30),
		BackgroundTransparency = 1
	});
	local v50 = v21("TextButton",v44,{
		Name = "Resize",
		AnchorPoint = Vector2.new(1,1),
		Position = UDim2.fromScale(1,1),
		Size = UDim2.fromOffset(22,22),
		BackgroundTransparency = 1,
		Text = "◢",
		TextColor3 = v7.Muted,
		TextSize = 15,
		ZIndex = 10
	});

	v48.MouseButton1Click:Connect(function() --[[ Name: Close ]]
		v44.Visible = false;
	end);

	local v201 = nil;
	v47.MouseButton1Click:Connect(function() --[[ Name: Minimize ]]
		if v44:GetAttribute("Minimized") then
			v44:SetAttribute("Minimized",false);
			v44.Size = v201 or v43;
			v49.Visible = true;
			v50.Visible = true;
		else
			v201 = v44.Size;
			v44:SetAttribute("Minimized",true);
			v44.Size = UDim2.new(v44.Size.X.Scale,v44.Size.X.Offset,0,30);
			v49.Visible = false;
			v50.Visible = false;
		end;
	end);

	local function v51(v52,v53) --[[ Name: BeginDrag ]]
		if v52.UserInputType ~= Enum.UserInputType.MouseButton1 and v52.UserInputType ~= Enum.UserInputType.Touch then return; end;
		v16 = {
			Window = v44,
			Input = v52,
			Mode = v53,
			Start = v52.Position,
			Position = v44.Position,
			Size = v44.AbsoluteSize
		};
	end;

	v45.InputBegan:Connect(function(v54) --[[ Name: Move ]]
		v51(v54,"Move");
	end);
	v50.InputBegan:Connect(function(v55) --[[ Name: Resize ]]
		v51(v55,"Resize");
	end);
	return v44,v49;
end;

local v56 = v21("Frame",v8,{
	Name = "Toolbar",
	Position = UDim2.fromOffset(8,8),
	Size = UDim2.fromOffset(308,28),
	BackgroundTransparency = 1
});
local v57 = v33(v56,"Explorer",UDim2.fromOffset(148,28),"Explorador");
local v58 = v33(v56,"Properties",UDim2.fromOffset(150,28),"Propiedades");
v58.Position = UDim2.fromOffset(154,0);
v21("UICorner",v57,{CornerRadius=UDim.new(0,6)});
v21("UICorner",v58,{CornerRadius=UDim.new(0,6)});

local v59,v60 = v40("Explorador",UDim2.fromOffset(8,44),UDim2.fromOffset(305,490));
local v61,v62 = v40("Propiedades",UDim2.fromOffset(322,44),UDim2.fromOffset(365,490));

v57.MouseButton1Click:Connect(function() --[[ Name: ToggleExplorer ]]
	v59.Visible = not v59.Visible;
end);
v58.MouseButton1Click:Connect(function() --[[ Name: ToggleProperties ]]
	v61.Visible = not v61.Visible;
end);

local v63 = v21("TextBox",v60,{
	Name = "Search",
	Position = UDim2.fromOffset(6,7),
	Size = UDim2.new(1,-12,0,28),
	BackgroundColor3 = v7.Input,
	BorderSizePixel = 0,
	Text = "",
	PlaceholderText = "Buscar objetos...",
	PlaceholderColor3 = v7.Muted,
	TextColor3 = v7.Text,
	TextSize = 14,
	Font = Enum.Font.SourceSans,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false
});
v21("UIPadding",v63,{PaddingLeft = UDim.new(0,8)});

local v64 = v21("ScrollingFrame",v60,{
	Name = "Tree",
	Position = UDim2.fromOffset(3,40),
	Size = UDim2.new(1,-6,1,-46),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 5,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new()
});
v21("UIListLayout",v64,{
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0,1)
});

local v65 = v21("Frame",v62,{
	Name = "Selected",
	Size = UDim2.new(1,0,0,34),
	BackgroundColor3 = v7.Row,
	BorderSizePixel = 0
});
local v66 = v28(v65,"SelectedName",UDim2.new(1,-15,1,0),"DataModel");
v66.Position = UDim2.fromOffset(8,0);
local v67 = v21("ScrollingFrame",v62,{
	Name = "Properties",
	Position = UDim2.fromOffset(3,38),
	Size = UDim2.new(1,-6,1,-44),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 5,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new()
});
v21("UIListLayout",v67,{
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0,1)
});

local function v68(v69) --[[ Name: ClearRows ]]
	for _,v70 in ipairs(v69:GetChildren()) do
		if v70:IsA("GuiObject") then v70:Destroy(); end;
	end;
end;

local function v71(v72) --[[ Name: FormatValue ]]
	local v73 = typeof(v72);
	if v73 == "Color3" then
		return string.format("%d, %d, %d",math.round(v72.R*255),math.round(v72.G*255),math.round(v72.B*255));
	elseif v73 == "Vector3" then
		return string.format("%.2f, %.2f, %.2f",v72.X,v72.Y,v72.Z);
	elseif v73 == "Vector2" then
		return string.format("%.2f, %.2f",v72.X,v72.Y);
	elseif v73 == "UDim2" then
		return string.format("%.3f, %d, %.3f, %d",v72.X.Scale,v72.X.Offset,v72.Y.Scale,v72.Y.Offset);
	elseif v73 == "Instance" then
		return v72:GetFullName();
	elseif v73 == "EnumItem" then
		return v72.Name;
	end;
	return tostring(v72);
end;

local function v74(v75,v76) --[[ Name: ParseValue ]]
	local v77 = typeof(v75);
	if v77 == "string" then return v76; end;
	if v77 == "number" then return tonumber(v76); end;
	if v77 == "boolean" then
		if string.lower(v76) == "true" then return true; end;
		if string.lower(v76) == "false" then return false; end;
		return nil;
	end;
	local v78 = {};
	for v79 in string.gmatch(v76,"[-+]?%d*%.?%d+") do
		table.insert(v78,tonumber(v79));
	end;
	if v77 == "Color3" and #v78 == 3 then
		return Color3.fromRGB(math.clamp(v78[1],0,255),math.clamp(v78[2],0,255),math.clamp(v78[3],0,255));
	elseif v77 == "Vector3" and #v78 == 3 then
		return Vector3.new(v78[1],v78[2],v78[3]);
	elseif v77 == "Vector2" and #v78 == 2 then
		return Vector2.new(v78[1],v78[2]);
	elseif v77 == "UDim2" and #v78 == 4 then
		return UDim2.new(v78[1],v78[2],v78[3],v78[4]);
	end;
	return nil;
end;

local function v80(v81,v82) --[[ Name: AddCategory ]]
	local v83 = v21("Frame",v67,{
		Name = "Category_"..v81,
		LayoutOrder = v82,
		Size = UDim2.new(1,-5,0,26),
		BackgroundColor3 = v7.Header,
		BorderSizePixel = 0
	});
	local v84 = v28(v83,"Label",UDim2.new(1,-12,1,0),"⌄  "..v81);
	v84.Position = UDim2.fromOffset(8,0);
	v84.Font = Enum.Font.SourceSansSemibold;
end;

local v223 = {};
local function v85(v86,v87,v88,v89,v90) --[[ Name: AddProperty ]]
	local v91 = v21("Frame",v67,{
		Name = "Property_"..v86,
		LayoutOrder = v87,
		Size = UDim2.new(1,-5,0,28),
		BackgroundColor3 = v87%2 == 0 and v7.Row or v7.Alternate,
		BorderSizePixel = 0
	});
	local v92 = v28(v91,"Name",UDim2.new(0.43,-7,1,0),v86);
	v92.Position = UDim2.fromOffset(7,0);
	local v93 = v21("TextBox",v91,{
		Name = "Value",
		Position = UDim2.new(0.43,2,0,2),
		Size = UDim2.new(0.57,-7,1,-4),
		BackgroundColor3 = v7.Input,
		BackgroundTransparency = v89 and 0 or 0.55,
		BorderSizePixel = 0,
		Text = v71(v88),
		TextColor3 = v89 and v7.Text or v7.Muted,
		TextSize = 13,
		Font = Enum.Font.SourceSans,
		ClearTextOnFocus = false,
		TextEditable = v89,
		TextXAlignment = Enum.TextXAlignment.Left
	});
	v21("UIPadding",v93,{PaddingLeft = UDim.new(0,5)});
	local v224 = pcall(function()
		table.insert(v223,v90:GetPropertyChangedSignal(v86):Connect(function() --[[ Name: LiveProperty ]]
			if v14 ~= v90 or not v93.Parent or v93:IsFocused() then return; end;
			local v225,v226 = pcall(function() return v90[v86]; end);
			if v225 then v93.Text = v71(v226); end;
		end));
	end);
	if v89 then
		v93.FocusLost:Connect(function() --[[ Name: SaveProperty ]]
			if v14 ~= v90 then return; end;
			local v94 = v74(v88,v93.Text);
			if v94 ~= nil then
				pcall(function() v90[v86] = v94; end);
			end;
			local v95,v96 = pcall(function() return v90[v86]; end);
			if v95 then v93.Text = v71(v96); end;
			if v86 == "Name" then v17 = true; end;
		end);
	end;
end;

local function v97() --[[ Name: UpdateProperties ]]
	for _,v224 in ipairs(v223) do v224:Disconnect(); end;
	table.clear(v223);
	v68(v67);
	if not v14 then return; end;
	local v98,v99 = v38(v14);
	v66.Text = v98.."  "..v14.Name.." ("..v14.ClassName..")";
	local v100 = {};

	local function v101(v102,v103,v104) --[[ Name: RegisterProperty ]]
		table.insert(v100,{v102,v103,v104 == true});
	end;

	v101("Data","Name",true);
	v101("Data","ClassName",false);
	v101("Data","Parent",false);
	v101("Data","Archivable",true);

	if v14:IsA("Player") then
		v101("Player","UserId",false);
		v101("Player","DisplayName",false);
		v101("Player","AccountAge",false);
		v101("Player","Team",false);
		v101("Player","Character",false);
	end;
	if v14:IsA("BasePart") then
		v101("Appearance","Color",true);
		v101("Appearance","Material",false);
		v101("Appearance","Transparency",true);
		v101("Appearance","Reflectance",true);
		v101("Data","Size",true);
		v101("Data","Position",true);
		v101("Data","Orientation",true);
		v101("Behavior","Anchored",true);
		v101("Behavior","CanCollide",true);
		v101("Behavior","CanTouch",true);
		v101("Behavior","CanQuery",true);
	end;
	if v14:IsA("GuiObject") then
		v101("Appearance","BackgroundColor3",true);
		v101("Appearance","BackgroundTransparency",true);
		v101("Appearance","BorderSizePixel",true);
		v101("Data","Position",true);
		v101("Data","Size",true);
		v101("Data","Rotation",true);
		v101("Data","ZIndex",true);
		v101("Behavior","Visible",true);
		v101("Behavior","Active",true);
		if v14:IsA("TextLabel") or v14:IsA("TextButton") or v14:IsA("TextBox") then
			v101("Text","Text",true);
			v101("Text","TextColor3",true);
			v101("Text","TextSize",true);
			v101("Text","TextScaled",true);
		end;
		if v14:IsA("ImageLabel") or v14:IsA("ImageButton") then
			v101("Image","Image",true);
			v101("Image","ImageColor3",true);
			v101("Image","ImageTransparency",true);
		end;
	end;
	if v14:IsA("Sound") then
		v101("Sound","SoundId",true);
		v101("Sound","Volume",true);
		v101("Sound","PlaybackSpeed",true);
		v101("Sound","Looped",true);
		v101("Sound","Playing",true);
		v101("Sound","TimePosition",true);
		v101("Sound","TimeLength",false);
		v101("Sound","PlaybackLoudness",false);
	end;
	if v14:IsA("Light") then
		v101("Appearance","Color",true);
		v101("Appearance","Brightness",true);
		v101("Appearance","Enabled",true);
		v101("Appearance","Range",true);
		v101("Appearance","Shadows",true);
	end;
	if v14:IsA("UIGradient") then
		v101("Appearance","Color",false);
		v101("Appearance","Transparency",false);
		v101("Appearance","Rotation",true);
		v101("Appearance","Offset",true);
		v101("Appearance","Enabled",true);
	end;
	if v14:IsA("ValueBase") then
		v101("Data","Value",true);
	end;
	if v14:IsA("Model") then
		v101("Data","PrimaryPart",false);
		v101("Behavior","LevelOfDetail",false);
	end;
	if v14:IsA("Script") or v14:IsA("LocalScript") then
		v101("Behavior","Enabled",false);
		v101("Data","RunContext",false);
	end;

	local v105 = {"Appearance","Data","Player","Behavior","Text","Image","Sound"};
	local v106 = 0;
	for _,v107 in ipairs(v105) do
		local v108 = false;
		for _,v109 in ipairs(v100) do
			if v109[1] == v107 then
				local v110,v111 = pcall(function() return v14[v109[2]]; end);
				if v110 then
					if not v108 then
						v106 = v106+1;
						v80(v107,v106);
						v108 = true;
					end;
					v106 = v106+1;
					v85(v109[2],v106,v111,v109[3],v14);
				end;
			end;
		end;
	end;
end;

local function v112(v113) --[[ Name: GetChildren ]]
	if v113 == game then return v10; end;
	local v114 = v113:GetChildren();
	table.sort(v114,function(v115,v116)
		return string.lower(v115.Name) < string.lower(v116.Name);
	end);
	return v114;
end;


--[[ Direct exporter | Client-visible instances only ]]
local v154 = v21("Frame",v8,{
 Name="ContextMenu",Size=UDim2.fromOffset(155,36),BackgroundColor3=v7.Header,
 BorderSizePixel=0,Visible=false,ZIndex=150
});
v21("UICorner",v154,{CornerRadius=UDim.new(0,7)});
v21("UIStroke",v154,{Color=v7.Border,Transparency=0.2,Thickness=1});
local v155 = v33(v154,"Save",UDim2.new(1,-6,1,-6),"Save");
v155.Position=UDim2.fromOffset(3,3);v155.ZIndex=151;
v21("UICorner",v155,{CornerRadius=UDim.new(0,5)});
local v156 = nil;
local v157 = v28(v8,"SaveStatus",UDim2.fromOffset(440,32),"");
v157.Position=UDim2.new(0,9,1,-42);v157.BackgroundTransparency=0;
v157.BackgroundColor3=v7.Header;v157.TextXAlignment=Enum.TextXAlignment.Center;
v157.Visible=false;v157.ZIndex=200;
v21("UICorner",v157,{CornerRadius=UDim.new(0,7)});
v21("UIStroke",v157,{Color=v7.Border,Transparency=0.35});
local v158 = 0;
local function v159(v160) --[[ Name: ShowStatus ]]
 v158+=1;local v161=v158;
 v157.Text=v160;v157.Visible=true;
 task.delay(4,function() --[[ Name: HideStatus ]]
  if v157.Parent and v158==v161 then v157.Visible=false;end;
 end);
end;
local v164 = {
 "Name","Archivable","Enabled","ResetOnSpawn","DisplayOrder","IgnoreGuiInset","ZIndexBehavior","ScreenInsets","SafeAreaCompatibility","ClipToDeviceSafeArea",
 "Position","Size","AnchorPoint","Rotation","Visible","Active","Selectable","ClipsDescendants","ZIndex","LayoutOrder","AutomaticSize",
 "BackgroundColor3","BackgroundTransparency","BorderColor3","BorderSizePixel","BorderMode",
 "Text","TextColor3","TextTransparency","TextSize","TextScaled","TextWrapped","TextXAlignment","TextYAlignment","TextTruncate","RichText","MaxVisibleGraphemes","LineHeight","Font","FontFace","TextStrokeColor3","TextStrokeTransparency","TextDirection","PlaceholderText","PlaceholderColor3","ClearTextOnFocus","MultiLine","TextEditable",
 "Image","ImageColor3","ImageTransparency","ImageRectOffset","ImageRectSize","ScaleType","SliceCenter","SliceScale","TileSize","ResampleMode",
 "AutoButtonColor","Modal","Style","Selected","Interactable","ScrollingEnabled","ScrollingDirection","CanvasSize","AutomaticCanvasSize","ScrollBarThickness","ScrollBarImageColor3","ScrollBarImageTransparency","VerticalScrollBarInset","HorizontalScrollBarInset","ElasticBehavior",
 "CornerRadius","Thickness","ApplyStrokeMode","LineJoinMode","Transparency","Color","Offset","FillDirection","HorizontalAlignment","VerticalAlignment","Padding","SortOrder","CellSize","CellPadding","FillDirectionMaxCells","StartCorner","AspectRatio","AspectType","DominantAxis","MinSize","MaxSize","MinTextSize","PaddingLeft","PaddingRight","PaddingTop","PaddingBottom","Scale","Value","MaxValue","MinValue","MaxCount","Key","Animated","EasingDirection","EasingStyle","TweenTime","Circular",
 "CFrame","PivotOffset","PrimaryPart","Orientation","Reflectance","Material","MaterialVariant","CastShadow","Anchored","CanCollide","CanTouch","CanQuery","CollisionGroup","Massless","Locked","Shape","TopSurface","BottomSurface","LeftSurface","RightSurface","FrontSurface","BackSurface",
 "MeshId","TextureID","TextureId","DoubleSided","RenderFidelity","Size","Color","Transparency","LocalTransparencyModifier","UsePartColor","Texture","StudsPerTileU","StudsPerTileV","Face","LightEmission","LightInfluence",
 "Brightness","Range","Shadows","Angle","InnerAngle","OuterAngle","Width","Height","LightColor","SoundId","Volume","PlaybackSpeed","Looped","RollOffMaxDistance","RollOffMinDistance","RollOffMode","EmitterSize","PlayOnRemove",
 "PrimaryAxis","SecondaryAxis","Axis","SecondaryAxis","Attachment0","Attachment1","Part0","Part1","Enabled","MaxForce","MaxTorque","Responsiveness","RigidityEnabled","WorldPosition","WorldCFrame","WorldAxis","WorldSecondaryAxis",
 "StudsOffset","StudsOffsetWorldSpace","Adornee","AlwaysOnTop","MaxDistance","LightInfluence","PixelsPerStud","Face","ExtentsOffset","ExtentsOffsetWorldSpace","SizeOffset",
 "MeshType","Scale","Offset","VertexColor","MeshId","TextureId","TextureID","AnimationId","Value","MaxValue","MinValue"
};
local function v165(v166) --[[ Name: SerializeValue ]]
 local v167=typeof(v166);
 if v167=="string" then return string.format("%q",v166);end;
 if v167=="boolean" then return tostring(v166);end;
 if v167=="number" then
  if v166~=v166 or v166==math.huge or v166==-math.huge then return nil;end;
  return string.format("%.17g",v166);
 end;
 if v167=="Color3" then return string.format("Color3.new(%.17g,%.17g,%.17g)",v166.R,v166.G,v166.B);end;
 if v167=="Vector2" then return string.format("Vector2.new(%.17g,%.17g)",v166.X,v166.Y);end;
 if v167=="Vector3" then return string.format("Vector3.new(%.17g,%.17g,%.17g)",v166.X,v166.Y,v166.Z);end;
 if v167=="CFrame" then
  local v168={v166:GetComponents()};
  for v169,v170 in ipairs(v168) do v168[v169]=string.format("%.17g",v170);end;
  return "CFrame.new("..table.concat(v168,",")..")";
 end;
 if v167=="UDim" then return string.format("UDim.new(%.17g,%d)",v166.Scale,v166.Offset);end;
 if v167=="UDim2" then return string.format("UDim2.new(%.17g,%d,%.17g,%d)",v166.X.Scale,v166.X.Offset,v166.Y.Scale,v166.Y.Offset);end;
 if v167=="Rect" then return string.format("Rect.new(%.17g,%.17g,%.17g,%.17g)",v166.Min.X,v166.Min.Y,v166.Max.X,v166.Max.Y);end;
 if v167=="EnumItem" then return tostring(v166);end;
 if v167=="NumberRange" then return string.format("NumberRange.new(%.17g,%.17g)",v166.Min,v166.Max);end;
 if v167=="ColorSequence" then
  local v168={};
  for _,v169 in ipairs(v166.Keypoints) do table.insert(v168,string.format("ColorSequenceKeypoint.new(%.17g,%s)",v169.Time,v165(v169.Value)));end;
  return "ColorSequence.new({"..table.concat(v168,",").."})";
 end;
 if v167=="NumberSequence" then
  local v168={};
  for _,v169 in ipairs(v166.Keypoints) do table.insert(v168,string.format("NumberSequenceKeypoint.new(%.17g,%.17g,%.17g)",v169.Time,v169.Value,v169.Envelope));end;
  return "NumberSequence.new({"..table.concat(v168,",").."})";
 end;
 if v167=="Font" then return string.format("Font.new(%q,%s,%s)",v166.Family,tostring(v166.Weight),tostring(v166.Style));end;
 if v167=="BrickColor" then return "BrickColor.new("..string.format("%q",v166.Name)..")";end;
 if v167=="PhysicalProperties" then return string.format("PhysicalProperties.new(%.17g,%.17g,%.17g,%.17g,%.17g)",v166.Density,v166.Friction,v166.Elasticity,v166.FrictionWeight,v166.ElasticityWeight);end;
 return nil;
end;
local function v172(v173) --[[ Name: IsExportable ]]
 return v173:IsA("LayerCollector") or v173:IsA("GuiObject") or v173:IsA("UIComponent") or v173:IsA("UIConstraint") or v173:IsA("UILayout") or v173:IsA("Folder") or v173:IsA("Model") or v173:IsA("BasePart") or v173:IsA("Attachment") or v173:IsA("Constraint") or v173:IsA("JointInstance") or v173:IsA("SpecialMesh") or v173:IsA("DataModelMesh") or v173:IsA("Decal") or v173:IsA("Texture") or v173:IsA("Light") or v173:IsA("ParticleEmitter") or v173:IsA("Trail") or v173:IsA("Beam") or v173:IsA("Sound") or v173:IsA("Animation") or v173:IsA("ValueBase") or v173:IsA("Configuration") or v173:IsA("WrapLayer") or v173:IsA("WrapTarget") or v173:IsA("Script") or v173:IsA("LocalScript") or v173:IsA("ModuleScript");
end;
local function v174(v175) --[[ Name: ExportObject ]]
 if not v175 or not v172(v175) then return nil;end;
 local v176={"--[[ Owen Dexv | Exported client-visible object | Luau ]]","-- Place this as a LocalScript in StarterPlayerScripts for GUI exports.","-- For world models use a Script in ServerScriptService and review physics/ownership.","-- Exported object reconstruction."};
 local v177={};local v178={};local v179=1;
 local function v180(v181,v182) --[[ Name: ExportNode ]]
  if not v172(v181) then return;end;
  v179+=1;local v183="v"..v179;
  table.insert(v176,"local "..v183.."=Instance.new("..string.format("%q",v181.ClassName)..");");
  v177[v181]=v183;
  local v184={};
  for _,v185 in ipairs(v164) do
   if not v184[v185] and (not v181:IsA("BasePart") or (v185~="Position" and v185~="Orientation")) and v185~="Parent" and v185~="WorldPosition" and v185~="WorldCFrame" and v185~="WorldAxis" and v185~="WorldSecondaryAxis" and v185~="LocalTransparencyModifier" then
    v184[v185]=true;
    local v186,v187=pcall(function() return v181[v185];end);
    if v186 then
     if typeof(v187)=="Instance" then
      table.insert(v178,{v183,v185,v187});
     else
      local v188=v165(v187);
      if v188 then table.insert(v176,"pcall(function() "..v183.."."..v185.."="..v188..";end);");end;
     end;
    end;
   end;
  end;
  for v189,v190 in pairs(v181:GetAttributes()) do
   local v191=v165(v190);
   if v191 then table.insert(v176,"pcall(function() "..v183..":SetAttribute("..string.format("%q",v189)..","..v191..");end);");end;
  end;
  if v181:IsA("BaseScript") then table.insert(v176,"pcall(function() "..v183..".Enabled=false;end);");end;
  table.insert(v176,v183..".Parent="..v182..";");
  for _,v192 in ipairs(v181:GetChildren()) do v180(v192,v183);end;
 end;
 local v193=(v175:IsA("LayerCollector") or v175:IsA("GuiObject")) and 'game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")' or 'workspace';
 -- A Frame or any other GUI child needs a ScreenGui host to display on its own.
 if v175:IsA("GuiObject") then
  table.insert(v176,'local vHost=Instance.new("ScreenGui");vHost.Name="OwenDexv_ExportHost";vHost.ResetOnSpawn=false;vHost.Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");');
  v193="vHost";
 end;
 v180(v175,v193);
 for _,v194 in ipairs(v178) do
  local v195=v177[v194[3]];
  if v195 then table.insert(v176,"pcall(function() "..v194[1].."."..v194[2].."="..v195..";end);");end;
 end;
 table.insert(v176,"-- Script Source, runtime connections and server-only objects cannot be recovered by a client.");
 return table.concat(v176,"\n");
end;
local function v192(v193) --[[ Name: SaveObject ]]
 local v194=v174(v193);
 if not v194 then v159("Objeto no compatible con exportación.");return;end;
 if type(writefile)~="function" then
  v159("No guardado: este entorno no dispone de writefile().");return;
 end;
 local v195=v193:IsA("LayerCollector") or v193:IsA("GuiObject");
 local v196=v195 and "ExportedGUIs" or "ExportedModels";
 local v197=v193.Name:gsub("[^%w_%-]","_");
 if v197=="" then v197=v193.ClassName;end;
 local v198="OwenDexv/"..v196.."/"..v197..".lua";
 local v199,v200=pcall(function() --[[ Name: WriteExport ]]
  if type(isfolder)=="function" and type(makefolder)=="function" then
   if not isfolder("OwenDexv") then makefolder("OwenDexv");end;
   if not isfolder("OwenDexv/"..v196) then makefolder("OwenDexv/"..v196);end;
  end;
  writefile(v198,v194);
 end);
 if v199 then v159("Guardado: "..v198);else v159("Error al guardar: "..tostring(v200));end;
end;
v155.MouseButton1Click:Connect(function() --[[ Name: SaveContextObject ]]
 v154.Visible=false;
 if v156 and v156.Parent then v192(v156);end;
end);
local function v117(v118,v119,v120) --[[ Name: AddObjectRow ]]
	local v121 = v21("Frame",v64,{
		Name = "ObjectRow",
		LayoutOrder = v120,
		Size = UDim2.new(1,-7,0,23),
		BackgroundColor3 = v118 == v14 and v7.Selected or v7.Background,
		BorderSizePixel = 0
	});
	local v122 = math.min(v119*15,135);
	local v123 = v118 == game or #v118:GetChildren() > 0;
	local v124 = v33(v121,"Expand",UDim2.fromOffset(18,23),v123 and (v15[v118] and "⌄" or "›") or "");
	v124.Position = UDim2.fromOffset(v122,0);
	v124.BackgroundTransparency = 1;
	local v125,v126 = v38(v118);
	local v127 = v28(v121,"Icon",UDim2.fromOffset(20,23),v125);
	v127.Position = UDim2.fromOffset(v122+19,0);
	v127.TextColor3 = v126;
	v127.TextXAlignment = Enum.TextXAlignment.Center;
	local v128 = v33(v121,"ObjectName",UDim2.new(1,-v122-43,1,0),v118 == game and "game" or v118.Name);
	v128.Position = UDim2.fromOffset(v122+42,0);
	v128.TextXAlignment = Enum.TextXAlignment.Left;
	v128.TextTruncate = Enum.TextTruncate.AtEnd;
	v128.BackgroundTransparency = 1;
	v128.MouseButton2Click:Connect(function() --[[ Name: ContextMenu ]]
		if v118 ~= v8 and not v118:IsDescendantOf(v8) and v172(v118) then
			v156 = v118;
			local v200 = v2:GetMouseLocation();
			local v201 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1600,900);
			v154.Position = UDim2.fromOffset(math.clamp(v200.X,0,math.max(0,v201.X-155)),math.clamp(v200.Y,0,math.max(0,v201.Y-36)));
			v154.Visible = true;
		else
			v154.Visible = false;
		end;
	end);
	v128.MouseButton1Click:Connect(function() --[[ Name: SelectObject ]]
		v14 = v118;
		v97();
		v17 = true;
	end);
	v124.MouseButton1Click:Connect(function() --[[ Name: ExpandNode ]]
		v15[v118] = not v15[v118];
		v17 = true;
	end);
end;

local function v129() --[[ Name: UpdateExplorer ]]
	if v20 then return; end;
	v20 = true;
	local v130 = v64.CanvasPosition;
	v68(v64);
	local v131 = string.lower(v63.Text);
	local v132 = 0;
	local v133 = 0;

	local function v134(v135,v136) --[[ Name: DrawTree ]]
		if v132 >= 350 or v136 > 20 then return; end;
		v132 = v132+1;
		v117(v135,v136,v132);
		if not v15[v135] then return; end;
		for _,v137 in ipairs(v112(v135)) do
			if v132 >= 350 then break; end;
			v134(v137,v136+1);
		end;
	end;

	local function v138(v139) --[[ Name: SearchTree ]]
		if v132 >= 350 or v133 >= 5000 then return; end;
		v133 = v133+1;
		if string.find(string.lower(v139.Name),v131,1,true) then
			v132 = v132+1;
			v117(v139,0,v132);
		end;
		for _,v140 in ipairs(v112(v139)) do
			if v132 >= 350 or v133 >= 5000 then break; end;
			v138(v140);
		end;
	end;

	if v131 == "" then
		v134(game,0);
	else
		for _,v141 in ipairs(v10) do
			if v132 >= 350 or v133 >= 5000 then break; end;
			v138(v141);
		end;
	end;
	v64.CanvasPosition = v130;
	v20 = false;
end;

v63:GetPropertyChangedSignal("Text"):Connect(function() --[[ Name: SearchChanged ]]
	v17 = true;
end);

local v142 = v2.InputChanged:Connect(function(v143) --[[ Name: DragChanged ]]
	if not v16 or not v8.Parent then return; end;
	if v143.UserInputType ~= Enum.UserInputType.MouseMovement and v143.UserInputType ~= Enum.UserInputType.Touch then return; end;
	if v16.Input.UserInputType == Enum.UserInputType.Touch and v143 ~= v16.Input then return; end;
	local v144 = v143.Position-v16.Start;
	if v16.Mode == "Move" then
		local v145 = v16.Position;
		v16.Window.Position = UDim2.new(v145.X.Scale,v145.X.Offset+v144.X,v145.Y.Scale,v145.Y.Offset+v144.Y);
	else
		v16.Window.Size = UDim2.fromOffset(math.max(230,v16.Size.X+v144.X),math.max(180,v16.Size.Y+v144.Y));
	end;
end);
local v146 = v2.InputEnded:Connect(function(v147) --[[ Name: DragEnded ]]
	if v16 and (v147 == v16.Input or (v147.UserInputType == Enum.UserInputType.MouseButton1 and v16.Input.UserInputType == Enum.UserInputType.MouseButton1)) then
		v16 = nil;
	end;
end);

local function v148() --[[ Name: QueueRefresh ]]
	if not v8.Parent then return; end;
	v19 = v19+1;
	local v149 = v19;
	task.delay(0.3,function()
		if v8.Parent and v149 == v19 then v17 = true; end;
	end);
end;

local v150 = {};
for _,v151 in ipairs(v10) do
	table.insert(v150,v151.DescendantAdded:Connect(v148));
	table.insert(v150,v151.DescendantRemoving:Connect(function(v152) --[[ Name: ObjectRemoved ]]
		if v14 == v152 or (v14 ~= game and v14:IsDescendantOf(v152)) then
			v14 = game;
			v97();
		end;
		v148();
	end));
end;

v8.Destroying:Connect(function() --[[ Name: Cleanup ]]
	for _,v224 in ipairs(v223) do v224:Disconnect();end;
	v142:Disconnect();
	v146:Disconnect();
	for _,v153 in ipairs(v150) do v153:Disconnect(); end;
end);

v14 = game;
v97();
v129();

task.spawn(function() --[[ Name: RefreshLoop ]]
	while v8.Parent do
		if v17 and v59.Visible then
			v17 = false;
			v129();
		end;
		task.wait(0.2);
	end;
end);
