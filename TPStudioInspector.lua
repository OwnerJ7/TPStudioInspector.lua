
--[[ Name: TP Studio Inspector | Client ]]
local v1 = game:GetService("Players");
local v2 = game:GetService("UserInputService");
local v3 = game:GetService("Workspace");
local v4 = v1.LocalPlayer;
local v5 = v4:WaitForChild("PlayerGui");
local v6 = v5:FindFirstChild("TPStudioInspector");
if v6 then v6:Destroy(); end;
v6 = Instance.new("ScreenGui");
v6.Name = "TPStudioInspector";
v6.ResetOnSpawn = false;
v6.IgnoreGuiInset = false;
v6.DisplayOrder = 100;
v6.Parent = v5;

local v7 = {
    Background = Color3.fromRGB(38,38,38),
    Header = Color3.fromRGB(45,45,45),
    Row = Color3.fromRGB(48,48,48),
    Alternate = Color3.fromRGB(43,43,43),
    Selected = Color3.fromRGB(12,74,170),
    Text = Color3.fromRGB(225,225,225),
    Muted = Color3.fromRGB(165,165,165),
    Border = Color3.fromRGB(65,65,65)
};
local v8 = {};
local v9 = v3;
local v10 = {[v3] = true};
local v11 = nil;
local v12 = nil;
local v13 = nil;
local v14 = false;
local v15 = false;
local v16 = nil;

local function v17(v18,v19,v20) --[[ Name: Create ]]
    local v21 = Instance.new(v18);
    for v22,v23 in pairs(v20 or {}) do
        v21[v22] = v23;
    end;
    v21.Parent = v19;
    return v21;
end;

local function v24(v25,v26,v27,v28,v29) --[[ Name: Label ]]
    return v17("TextLabel",v25,{
        Name = v26,
        Size = v27,
        BackgroundTransparency = 1,
        Text = v28,
        TextColor3 = v7.Text,
        TextSize = v29 or 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Font = Enum.Font.SourceSans
    });
end;

local function v30(v31,v32,v33,v34) --[[ Name: Button ]]
    return v17("TextButton",v31,{
        Name = v32,
        Size = v33,
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        Text = v34,
        TextColor3 = v7.Text,
        TextSize = 14,
        Font = Enum.Font.SourceSans
    });
end;

local function v35(v36,v37,v38) --[[ Name: GetIcon ]]
    if v36:IsA("Folder") then return "▣",Color3.fromRGB(232,184,78); end;
    if v36:IsA("Model") then return "⬡",Color3.fromRGB(170,190,235); end;
    if v36:IsA("MeshPart") then return "◆",Color3.fromRGB(120,190,230); end;
    if v36:IsA("BasePart") then return "■",Color3.fromRGB(150,190,220); end;
    if v36:IsA("Sound") then return "♫",Color3.fromRGB(245,160,75); end;
    if v36:IsA("LocalScript") then return "▤",Color3.fromRGB(95,210,160); end;
    if v36:IsA("ModuleScript") then return "▤",Color3.fromRGB(180,140,225); end;
    if v36:IsA("Script") then return "▤",Color3.fromRGB(110,175,240); end;
    if v36:IsA("UIGradient") then return "◉",Color3.fromRGB(195,195,225); end;
    if v36:IsA("GuiObject") then return "▣",Color3.fromRGB(235,145,100); end;
    if v36:IsA("Light") then return "☼",Color3.fromRGB(245,220,110); end;
    if v36:IsA("Attachment") then return "◎",Color3.fromRGB(170,220,190); end;
    if v36:IsA("ValueBase") then return "◇",Color3.fromRGB(120,220,160); end;
    return "•",v7.Muted;
end;

local function v39(v40,v41,v42,v43,v44,v45) --[[ Name: MakeWindow ]]
    local v46 = v17("Frame",v6,{
        Name = v40,
        Position = v41,
        Size = v42,
        BackgroundColor3 = v7.Background,
        BorderColor3 = v7.Border,
        BorderSizePixel = 1,
        ClipsDescendants = true,
        Active = true
    });
    local v47 = v17("Frame",v46,{
        Name = "TitleBar",
        Size = UDim2.new(1,0,0,29),
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        Active = true
    });
    local v48 = v24(v47,"Title",UDim2.new(1,-40,1,0),v40,15);
    v48.Position = UDim2.fromOffset(9,0);
    v48.Font = Enum.Font.SourceSansSemibold;
    local v49 = v30(v47,"Close",UDim2.fromOffset(29,29),"×");
    v49.AnchorPoint = Vector2.new(1,0);
    v49.Position = UDim2.fromScale(1,0);
    local v50 = v17("Frame",v46,{
        Name = "ResizeHandle",
        AnchorPoint = Vector2.new(1,1),
        Position = UDim2.fromScale(1,1),
        Size = UDim2.fromOffset(20,20),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 8
    });
    local v51 = v24(v50,"Grip",UDim2.fromScale(1,1),"◢",17);
    v51.TextXAlignment = Enum.TextXAlignment.Center;
    v51.TextColor3 = v7.Muted;

    v49.MouseButton1Click:Connect(function() --[[ Name: CloseWindow ]]
        v46.Visible = false;
        v45.Text = "Mostrar "..v40;
    end);

    local function v52(v53,v54) --[[ Name: BeginMove ]]
        if v53.UserInputType ~= Enum.UserInputType.MouseButton1 and v53.UserInputType ~= Enum.UserInputType.Touch then return; end;
        v11 = {
            Target = v46,
            Input = v53,
            Mode = v54,
            Start = v53.Position,
            Position = v46.Position,
            Size = v46.AbsoluteSize
        };
    end;

    v47.InputBegan:Connect(function(v55) --[[ Name: DragWindow ]]
        v52(v55,"Move");
    end);
    v50.InputBegan:Connect(function(v56) --[[ Name: ResizeWindow ]]
        v52(v56,"Resize");
    end);
    v45.MouseButton1Click:Connect(function() --[[ Name: ToggleWindow ]]
        v46.Visible = not v46.Visible;
        v45.Text = (v46.Visible and "Ocultar " or "Mostrar ")..v40;
    end);
    return v46;
end;

local v57 = v17("Frame",v6,{
    Name = "Toolbar",
    Position = UDim2.fromOffset(8,8),
    Size = UDim2.fromOffset(300,27),
    BackgroundTransparency = 1
});
local v58 = v30(v57,"ExplorerToggle",UDim2.fromOffset(144,27),"Ocultar Explorador");
local v59 = v30(v57,"PropertiesToggle",UDim2.fromOffset(150,27),"Ocultar Propiedades");
v59.Position = UDim2.fromOffset(150,0);

local v60 = v39("Explorador",UDim2.new(0,8,0,43),UDim2.fromOffset(310,490),nil,v58);
local v61 = v39("Propiedades",UDim2.new(0,327,0,43),UDim2.fromOffset(365,490),nil,v59);

local v62 = v17("TextBox",v60,{
    Name = "Search",
    Position = UDim2.fromOffset(7,35),
    Size = UDim2.new(1,-14,0,27),
    BackgroundColor3 = v7.Row,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Buscar en Workspace...",
    PlaceholderColor3 = v7.Muted,
    TextColor3 = v7.Text,
    TextSize = 13,
    ClearTextOnFocus = false,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.SourceSans
});
v17("UIPadding",v62,{PaddingLeft = UDim.new(0,8)});

local v63 = v17("ScrollingFrame",v60,{
    Name = "Tree",
    Position = UDim2.fromOffset(3,68),
    Size = UDim2.new(1,-6,1,-74),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
    ScrollingDirection = Enum.ScrollingDirection.Y
});
v17("UIListLayout",v63,{
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0,1)
});

local v64 = v17("Frame",v61,{
    Name = "SelectedObject",
    Position = UDim2.fromOffset(0,29),
    Size = UDim2.new(1,0,0,32),
    BackgroundColor3 = v7.Row,
    BorderSizePixel = 0
});
local v65 = v24(v64,"SelectedName",UDim2.new(1,-12,1,0),"Workspace",15);
v65.Position = UDim2.fromOffset(8,0);
local v66 = v17("ScrollingFrame",v61,{
    Name = "PropertyList",
    Position = UDim2.fromOffset(3,65),
    Size = UDim2.new(1,-6,1,-71),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
    ScrollingDirection = Enum.ScrollingDirection.Y
});
v17("UIListLayout",v66,{
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0,1)
});

local v67 = {};
local function v68(v69,v70,v71,v72) --[[ Name: AddProperty ]]
    table.insert(v67,{v69,v70,v71,v72});
end;

local function v73(v74) --[[ Name: FormatValue ]]
    if typeof(v74) == "Color3" then
        return string.format("%d, %d, %d",math.round(v74.R*255),math.round(v74.G*255),math.round(v74.B*255));
    elseif typeof(v74) == "Vector3" then
        return string.format("%.3f, %.3f, %.3f",v74.X,v74.Y,v74.Z);
    elseif typeof(v74) == "UDim2" then
        return string.format("%.3f, %d, %.3f, %d",v74.X.Scale,v74.X.Offset,v74.Y.Scale,v74.Y.Offset);
    elseif typeof(v74) == "Instance" then
        return v74.Name;
    end;
    return tostring(v74);
end;

local function v75(v76,v77) --[[ Name: ParseValue ]]
    local v78 = typeof(v76);
    if v78 == "boolean" then
        if v77 == "true" then return true; end;
        if v77 == "false" then return false; end;
    elseif v78 == "number" then
        return tonumber(v77);
    elseif v78 == "string" then
        return v77;
    elseif v78 == "Color3" then
        local v79 = {};
        for v80 in string.gmatch(v77,"[-%d%.]+") do
            table.insert(v79,tonumber(v80));
        end;
        if #v79 == 3 then
            return Color3.fromRGB(math.clamp(v79[1],0,255),math.clamp(v79[2],0,255),math.clamp(v79[3],0,255));
        end;
    elseif v78 == "Vector3" then
        local v81 = {};
        for v82 in string.gmatch(v77,"[-%d%.]+") do
            table.insert(v81,tonumber(v82));
        end;
        if #v81 == 3 then return Vector3.new(v81[1],v81[2],v81[3]); end;
    elseif v78 == "UDim2" then
        local v83 = {};
        for v84 in string.gmatch(v77,"[-%d%.]+") do
            table.insert(v83,tonumber(v84));
        end;
        if #v83 == 4 then return UDim2.new(v83[1],v83[2],v83[3],v83[4]); end;
    end;
    return nil;
end;

local function v85(v86) --[[ Name: ClearList ]]
    for _,v87 in ipairs(v86:GetChildren()) do
        if v87:IsA("GuiObject") then v87:Destroy(); end;
    end;
end;

local function v88(v89,v90) --[[ Name: PropertyCategory ]]
    local v91 = v17("Frame",v66,{
        Name = v89,
        Size = UDim2.new(1,-5,0,25),
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        LayoutOrder = v90
    });
    local v92 = v24(v91,"Category",UDim2.new(1,-12,1,0),"⌄  "..v89,14);
    v92.Position = UDim2.fromOffset(7,0);
    v92.Font = Enum.Font.SourceSansSemibold;
end;

local function v93(v94,v95,v96,v97) --[[ Name: PropertyRow ]]
    local v98 = v17("Frame",v66,{
        Name = v94,
        Size = UDim2.new(1,-5,0,27),
        BackgroundColor3 = v95%2 == 0 and v7.Row or v7.Alternate,
        BorderSizePixel = 0,
        LayoutOrder = v95
    });
    local v99 = v24(v98,"PropertyName",UDim2.new(0.43,-8,1,0),v94,13);
    v99.Position = UDim2.fromOffset(8,0);
    local v100 = v17("Frame",v98,{
        Position = UDim2.new(0.43,0,0,0),
        Size = UDim2.new(0.57,0,1,0),
        BackgroundTransparency = 1
    });
    local v101 = v17("TextBox",v100,{
        Size = UDim2.new(1,-5,1,-3),
        Position = UDim2.fromOffset(2,1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = v73(v96),
        TextColor3 = v97 and Color3.fromRGB(235,235,235) or v7.Muted,
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        TextEditable = v97
    });
    if v97 then
        v101.FocusLost:Connect(function() --[[ Name: EditProperty ]]
            if not v9 or not v9.Parent then return; end;
            local v102 = v75(v96,v101.Text);
            if v102 ~= nil then
                pcall(function()
                    v9[v94] = v102;
                end);
            end;
            local v103,v104 = pcall(function()
                return v9[v94];
            end);
            if v103 then v101.Text = v73(v104); end;
        end);
    end;
end;

local function v105() --[[ Name: UpdateProperties ]]
    if not v9 then return; end;
    v85(v66);
    v65.Text = v35(v9).."  "..v9.Name.."  ("..v9.ClassName..")";
    table.clear(v67);

    v68("Appearance","Name",true);
    v68("Data","ClassName",false);
    v68("Data","Parent",false);
    v68("Data","Archivable",true);

    if v9:IsA("BasePart") then
        v68("Appearance","Color",true);
        v68("Appearance","Material",false);
        v68("Appearance","Transparency",true);
        v68("Appearance","Reflectance",true);
        v68("Data","Size",true);
        v68("Data","Position",true);
        v68("Data","Orientation",true);
        v68("Behavior","Anchored",true);
        v68("Behavior","CanCollide",true);
        v68("Behavior","CanTouch",true);
        v68("Behavior","CanQuery",true);
        v68("Behavior","Massless",true);
    elseif v9:IsA("GuiObject") then
        v68("Appearance","BackgroundColor3",true);
        v68("Appearance","BackgroundTransparency",true);
        v68("Appearance","BorderSizePixel",true);
        v68("Data","Position",true);
        v68("Data","Size",true);
        v68("Data","AnchorPoint",false);
        v68("Data","Rotation",true);
        v68("Data","ZIndex",true);
        v68("Behavior","Visible",true);
        v68("Behavior","Active",true);
        if v9:IsA("TextLabel") or v9:IsA("TextButton") or v9:IsA("TextBox") then
            v68("Text","Text",true);
            v68("Text","TextColor3",true);
            v68("Text","TextTransparency",true);
            v68("Text","TextSize",true);
            v68("Text","TextScaled",true);
        end;
    elseif v9:IsA("Sound") then
        v68("Sound","SoundId",true);
        v68("Sound","Volume",true);
        v68("Sound","PlaybackSpeed",true);
        v68("Sound","Looped",true);
        v68("Sound","Playing",true);
        v68("Sound","TimePosition",true);
        v68("Sound","TimeLength",false);
        v68("Sound","PlaybackLoudness",false);
    elseif v9:IsA("Light") then
        v68("Appearance","Color",true);
        v68("Appearance","Brightness",true);
        v68("Appearance","Enabled",true);
        v68("Appearance","Shadows",true);
        v68("Appearance","Range",true);
    elseif v9:IsA("UIGradient") then
        v68("Appearance","Enabled",true);
        v68("Appearance","Rotation",true);
        v68("Appearance","Offset",false);
        v68("Appearance","Color",false);
        v68("Appearance","Transparency",false);
    elseif v9:IsA("Model") then
        v68("Data","PrimaryPart",false);
        v68("Behavior","LevelOfDetail",false);
    elseif v9:IsA("ValueBase") then
        v68("Data","Value",true);
    elseif v9:IsA("Script") or v9:IsA("LocalScript") then
        v68("Behavior","Enabled",false);
        v68("Data","RunContext",false);
    end;

    local v106 = {"Appearance","Data","Behavior","Text","Sound"};
    local v107 = 0;
    for _,v108 in ipairs(v106) do
        local v109 = false;
        for _,v110 in ipairs(v67) do
            if v110[1] == v108 then
                if not v109 then
                    v107 = v107+1;
                    v88(v108,v107);
                    v109 = true;
                end;
                local v111,v112 = pcall(function()
                    return v9[v110[2]];
                end);
                if v111 then
                    v107 = v107+1;
                    v93(v110[2],v107,v112,v110[3]);
                end;
            end;
        end;
    end;
end;

local function v113(v114) --[[ Name: HasChildren ]]
    return #v114:GetChildren() > 0;
end;

local function v115(v116,v117,v118) --[[ Name: TreeRow ]]
    local v119 = v17("Frame",v63,{
        Name = "ObjectRow",
        LayoutOrder = v118,
        Size = UDim2.new(1,-7,0,23),
        BackgroundColor3 = v116 == v9 and v7.Selected or v7.Background,
        BorderSizePixel = 0
    });
    local v120 = math.min(v117*16,140);
    local v121 = v30(v119,"Expand",UDim2.fromOffset(18,23),v113(v116) and (v10[v116] and "⌄" or "›") or "");
    v121.Position = UDim2.fromOffset(v120,0);
    v121.BackgroundTransparency = 1;
    local v122,v123 = v35(v116);
    local v124 = v24(v119,"Icon",UDim2.fromOffset(21,23),v122,16);
    v124.Position = UDim2.fromOffset(v120+19,0);
    v124.TextColor3 = v123;
    v124.TextXAlignment = Enum.TextXAlignment.Center;
    local v125 = v30(v119,"Object",UDim2.new(1,-v120-43,1,0),v116.Name);
    v125.Position = UDim2.fromOffset(v120+42,0);
    v125.BackgroundTransparency = 1;
    v125.TextXAlignment = Enum.TextXAlignment.Left;
    v125.TextSize = 14;
    v125.TextTruncate = Enum.TextTruncate.AtEnd;
    v125.MouseButton1Click:Connect(function() --[[ Name: SelectObject ]]
        v9 = v116;
        v105();
        v14 = true;
    end);
    v121.MouseButton1Click:Connect(function() --[[ Name: ToggleNode ]]
        v10[v116] = not v10[v116];
        v14 = true;
    end);
end;

local function v126() --[[ Name: UpdateExplorer ]]
    if v15 then return; end;
    v15 = true;
    v85(v63);
    local v127 = string.lower(v62.Text);
    local v128 = 0;
    local v129 = 0;
    local v130 = {};
    local function v131(v132,v133) --[[ Name: AddTree ]]
        if v128 >= 450 or v133 > 25 then return; end;
        if v127 ~= "" then
            local v134 = string.find(string.lower(v132.Name),v127,1,true);
            if v134 then
                v128 = v128+1;
                v115(v132,v133,v128);
            end;
        else
            v128 = v128+1;
            v115(v132,v133,v128);
            if v10[v132] then
                local v135 = v132:GetChildren();
                table.sort(v135,function(v136,v137)
                    return string.lower(v136.Name) < string.lower(v137.Name);
                end);
                for _,v138 in ipairs(v135) do
                    v131(v138,v133+1);
                    if v128 >= 450 then break; end;
                end;
            end;
        end;
    end;
    if v127 ~= "" then
        local function v139(v140) --[[ Name: SearchTree ]]
            if v129 >= 3000 or v128 >= 450 then return; end;
            v129 = v129+1;
            if string.find(string.lower(v140.Name),v127,1,true) then
                v128 = v128+1;
                v115(v140,0,v128);
            end;
            for _,v141 in ipairs(v140:GetChildren()) do
                v139(v141);
                if v129 >= 3000 or v128 >= 450 then break; end;
            end;
        end;
        v139(v3);
    else
        v131(v3,0);
    end;
    v15 = false;
end;

v62:GetPropertyChangedSignal("Text"):Connect(function() --[[ Name: SearchChanged ]]
    v14 = true;
end);

v2.InputChanged:Connect(function(v142) --[[ Name: WindowInputChanged ]]
    if not v11 then return; end;
    if v142.UserInputType ~= Enum.UserInputType.MouseMovement and v142.UserInputType ~= Enum.UserInputType.Touch then return; end;
    if v11.Input.UserInputType == Enum.UserInputType.Touch and v142 ~= v11.Input then return; end;
    local v143 = v142.Position-v11.Start;
    if v11.Mode == "Move" then
        local v144 = v11.Position;
        v11.Target.Position = UDim2.new(
            v144.X.Scale,v144.X.Offset+v143.X,
            v144.Y.Scale,v144.Y.Offset+v143.Y
        );
    else
        v11.Target.Size = UDim2.fromOffset(
            math.max(230,v11.Size.X+v143.X),
            math.max(180,v11.Size.Y+v143.Y)
        );
    end;
end);

v2.InputEnded:Connect(function(v145) --[[ Name: WindowInputEnded ]]
    if v11 and (v145 == v11.Input or (v11.Input.UserInputType == Enum.UserInputType.MouseButton1 and v145.UserInputType == Enum.UserInputType.MouseButton1)) then
        v11 = nil;
    end;
end);

local function v146() --[[ Name: QueueExplorerRefresh ]]
    if v16 then return; end;
    v16 = true;
    task.delay(0.35,function()
        v16 = nil;
        v14 = true;
    end);
end;

v3.DescendantAdded:Connect(v146);
v3.DescendantRemoving:Connect(function(v147) --[[ Name: ObjectRemoving ]]
    if v147 == v9 or v9:IsDescendantOf(v147) then
        v9 = v3;
        v105();
    end;
    v146();
end);

task.spawn(function() --[[ Name: ExplorerRefresh ]]
    while v6.Parent do
        if v14 then
            v14 = false;
            v126();
        end;
        task.wait(0.15);
    end;
end);

v105();
v126();
