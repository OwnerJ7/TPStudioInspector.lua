
--[[ TP Studio Inspector | Client ]]
local v1 = game:GetService("Players");
local v2 = game:GetService("UserInputService");
local v3 = game:GetService("Workspace");
local v4 = v1.LocalPlayer;
local v5 = v4:WaitForChild("PlayerGui");
local v6 = v5:FindFirstChild("TPStudioInspector");
if v6 then v6:Destroy(); end;

local v7 = {
    Background = Color3.fromRGB(37,37,37),
    Header = Color3.fromRGB(47,47,47),
    Row = Color3.fromRGB(44,44,44),
    Alternate = Color3.fromRGB(39,39,39),
    Input = Color3.fromRGB(52,52,52),
    Selected = Color3.fromRGB(16,78,169),
    Text = Color3.fromRGB(230,230,230),
    Muted = Color3.fromRGB(165,165,165),
    Border = Color3.fromRGB(65,65,65)
};
local v8 = Instance.new("ScreenGui");
v8.Name = "TPStudioInspector";
v8.ResetOnSpawn = false;
v8.IgnoreGuiInset = false;
v8.DisplayOrder = 100;
v8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
v8.Parent = v5;

local v9 = v3;
local v10 = {[v3] = true};
local v11 = {};
local v12 = nil;
local v13 = nil;
local v14 = false;
local v15 = false;
local v16 = 0;

local function v17(v18,v19,v20) --[[ Name: Create ]]
    local v21 = Instance.new(v18);
    for v22,v23 in pairs(v20 or {}) do
        v21[v22] = v23;
    end;
    v21.Parent = v19;
    return v21;
end;

local function v24(v25,v26,v27,v28) --[[ Name: CreateLabel ]]
    return v17("TextLabel",v25,{
        Name = v26,
        Size = v27,
        BackgroundTransparency = 1,
        Text = v28,
        TextColor3 = v7.Text,
        TextSize = 14,
        Font = Enum.Font.SourceSans,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BorderSizePixel = 0
    });
end;

local function v29(v30,v31,v32,v33) --[[ Name: CreateButton ]]
    return v17("TextButton",v30,{
        Name = v31,
        Size = v32,
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        Text = v33,
        TextColor3 = v7.Text,
        TextSize = 14,
        Font = Enum.Font.SourceSans,
        AutoButtonColor = true
    });
end;

local function v34(v35) --[[ Name: GetObjectIcon ]]
    if v35:IsA("Folder") then
        return "▣",Color3.fromRGB(241,190,80);
    elseif v35:IsA("Model") then
        return "⬡",Color3.fromRGB(160,184,226);
    elseif v35:IsA("MeshPart") then
        return "◆",Color3.fromRGB(125,194,225);
    elseif v35:IsA("BasePart") then
        return "■",Color3.fromRGB(143,191,223);
    elseif v35:IsA("Sound") then
        return "♫",Color3.fromRGB(247,161,91);
    elseif v35:IsA("LocalScript") then
        return "▤",Color3.fromRGB(110,219,158);
    elseif v35:IsA("ModuleScript") then
        return "▤",Color3.fromRGB(190,145,240);
    elseif v35:IsA("Script") then
        return "▤",Color3.fromRGB(120,175,247);
    elseif v35:IsA("UIGradient") then
        return "◉",Color3.fromRGB(190,190,240);
    elseif v35:IsA("GuiObject") then
        return "▣",Color3.fromRGB(240,160,100);
    elseif v35:IsA("Light") then
        return "☼",Color3.fromRGB(255,219,105);
    elseif v35:IsA("Attachment") then
        return "◎",Color3.fromRGB(165,224,190);
    elseif v35:IsA("ValueBase") then
        return "◇",Color3.fromRGB(145,221,159);
    end;
    return "•",v7.Muted;
end;

local function v36(v37,v38,v39) --[[ Name: CreateWindow ]]
    local v40 = v17("Frame",v8,{
        Name = v37,
        Position = v38,
        Size = v39,
        BackgroundColor3 = v7.Background,
        BorderColor3 = v7.Border,
        BorderSizePixel = 1,
        Active = true,
        ClipsDescendants = true
    });
    local v41 = v17("Frame",v40,{
        Name = "TitleBar",
        Size = UDim2.new(1,0,0,30),
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        Active = true
    });
    local v42 = v24(v41,"Title",UDim2.new(1,-75,1,0),v37);
    v42.Position = UDim2.fromOffset(9,0);
    v42.Font = Enum.Font.SourceSansSemibold;
    v42.TextSize = 16;

    local v43 = v29(v41,"Minimize",UDim2.fromOffset(29,30),"−");
    v43.Position = UDim2.new(1,-59,0,0);
    local v44 = v29(v41,"Close",UDim2.fromOffset(29,30),"×");
    v44.Position = UDim2.new(1,-30,0,0);

    local v45 = v17("Frame",v40,{
        Name = "ResizeHandle",
        AnchorPoint = Vector2.new(1,1),
        Position = UDim2.fromScale(1,1),
        Size = UDim2.fromOffset(21,21),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 10
    });
    local v46 = v24(v45,"Grip",UDim2.fromScale(1,1),"◢");
    v46.TextXAlignment = Enum.TextXAlignment.Center;
    v46.TextColor3 = v7.Muted;

    local v47 = v17("Frame",v40,{
        Name = "Body",
        Position = UDim2.fromOffset(0,30),
        Size = UDim2.new(1,0,1,-30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    });

    v44.MouseButton1Click:Connect(function() --[[ Name: CloseWindow ]]
        v40.Visible = false;
    end);

    v43.MouseButton1Click:Connect(function() --[[ Name: MinimizeWindow ]]
        if v40:GetAttribute("Minimized") then
            v40:SetAttribute("Minimized",false);
            v40.Size = v40:GetAttribute("OriginalSize") or v39;
            v47.Visible = true;
            v45.Visible = true;
        else
            v40:SetAttribute("OriginalSize",v40.Size);
            v40:SetAttribute("Minimized",true);
            v40.Size = UDim2.new(v40.Size.X.Scale,v40.Size.X.Offset,0,30);
            v47.Visible = false;
            v45.Visible = false;
        end;
    end);

    local function v48(v49,v50) --[[ Name: StartDrag ]]
        if v49.UserInputType ~= Enum.UserInputType.MouseButton1 and v49.UserInputType ~= Enum.UserInputType.Touch then return; end;
        v12 = {
            Window = v40,
            Input = v49,
            Mode = v50,
            Start = v49.Position,
            Position = v40.Position,
            Size = v40.AbsoluteSize
        };
    end;

    v41.InputBegan:Connect(function(v51) --[[ Name: DragWindow ]]
        v48(v51,"Move");
    end);
    v45.InputBegan:Connect(function(v52) --[[ Name: ResizeWindow ]]
        v48(v52,"Resize");
    end);
    return v40,v47;
end;

local v53 = v17("Frame",v8,{
    Name = "Toolbar",
    Position = UDim2.fromOffset(8,8),
    Size = UDim2.fromOffset(302,27),
    BackgroundTransparency = 1
});
local v54 = v29(v53,"ExplorerToggle",UDim2.fromOffset(145,27),"Explorador");
local v55 = v29(v53,"PropertiesToggle",UDim2.fromOffset(150,27),"Propiedades");
v55.Position = UDim2.fromOffset(150,0);

local v56,v57 = v36("Explorador",UDim2.fromOffset(8,43),UDim2.fromOffset(300,470));
local v58,v59 = v36("Propiedades",UDim2.fromOffset(317,43),UDim2.fromOffset(360,470));

v54.MouseButton1Click:Connect(function() --[[ Name: ToggleExplorer ]]
    v56.Visible = not v56.Visible;
end);
v55.MouseButton1Click:Connect(function() --[[ Name: ToggleProperties ]]
    v58.Visible = not v58.Visible;
end);

local v60 = v17("TextBox",v57,{
    Name = "Search",
    Position = UDim2.fromOffset(7,7),
    Size = UDim2.new(1,-14,0,28),
    BackgroundColor3 = v7.Input,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Buscar en Workspace...",
    PlaceholderColor3 = v7.Muted,
    TextColor3 = v7.Text,
    TextSize = 14,
    Font = Enum.Font.SourceSans,
    ClearTextOnFocus = false,
    TextXAlignment = Enum.TextXAlignment.Left
});
v17("UIPadding",v60,{PaddingLeft = UDim.new(0,8)});

local v61 = v17("ScrollingFrame",v57,{
    Name = "ObjectTree",
    Position = UDim2.fromOffset(3,40),
    Size = UDim2.new(1,-6,1,-45),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = v7.Muted,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0,0,0,0)
});
v17("UIListLayout",v61,{
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0,1)
});

local v62 = v17("Frame",v59,{
    Name = "SelectedObject",
    Size = UDim2.new(1,0,0,34),
    BackgroundColor3 = v7.Row,
    BorderSizePixel = 0
});
local v63 = v24(v62,"ObjectName",UDim2.new(1,-15,1,0),"Workspace");
v63.Position = UDim2.fromOffset(8,0);
v63.TextSize = 15;

local v64 = v17("ScrollingFrame",v59,{
    Name = "PropertyList",
    Position = UDim2.fromOffset(3,38),
    Size = UDim2.new(1,-6,1,-43),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = v7.Muted,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
});
v17("UIListLayout",v64,{
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0,1)
});

local function v65(v66) --[[ Name: ClearRows ]]
    for _,v67 in ipairs(v66:GetChildren()) do
        if v67:IsA("GuiObject") then
            v67:Destroy();
        end;
    end;
end;

local function v68(v69) --[[ Name: FormatValue ]]
    local v70 = typeof(v69);
    if v70 == "Color3" then
        return string.format("%d, %d, %d",math.round(v69.R*255),math.round(v69.G*255),math.round(v69.B*255));
    elseif v70 == "Vector3" then
        return string.format("%.2f, %.2f, %.2f",v69.X,v69.Y,v69.Z);
    elseif v70 == "Vector2" then
        return string.format("%.2f, %.2f",v69.X,v69.Y);
    elseif v70 == "UDim2" then
        return string.format("%.3f, %d, %.3f, %d",v69.X.Scale,v69.X.Offset,v69.Y.Scale,v69.Y.Offset);
    elseif v70 == "UDim" then
        return string.format("%.3f, %d",v69.Scale,v69.Offset);
    elseif v70 == "Instance" then
        return v69:GetFullName();
    elseif v70 == "EnumItem" then
        return v69.Name;
    end;
    return tostring(v69);
end;

local function v71(v72,v73) --[[ Name: ParseValue ]]
    local v74 = typeof(v72);
    if v74 == "string" then return v73; end;
    if v74 == "number" then return tonumber(v73); end;
    if v74 == "boolean" then
        if string.lower(v73) == "true" then return true; end;
        if string.lower(v73) == "false" then return false; end;
        return nil;
    end;
    local v75 = {};
    for v76 in string.gmatch(v73,"[-+]?%d*%.?%d+") do
        table.insert(v75,tonumber(v76));
    end;
    if v74 == "Color3" and #v75 == 3 then
        return Color3.fromRGB(
            math.clamp(v75[1],0,255),
            math.clamp(v75[2],0,255),
            math.clamp(v75[3],0,255)
        );
    elseif v74 == "Vector3" and #v75 == 3 then
        return Vector3.new(v75[1],v75[2],v75[3]);
    elseif v74 == "Vector2" and #v75 == 2 then
        return Vector2.new(v75[1],v75[2]);
    elseif v74 == "UDim2" and #v75 == 4 then
        return UDim2.new(v75[1],v75[2],v75[3],v75[4]);
    elseif v74 == "UDim" and #v75 == 2 then
        return UDim.new(v75[1],v75[2]);
    end;
    return nil;
end;

local function v77(v78,v79) --[[ Name: PropertyCategory ]]
    local v80 = v17("Frame",v64,{
        Name = "Category_"..v78,
        Size = UDim2.new(1,-5,0,26),
        BackgroundColor3 = v7.Header,
        BorderSizePixel = 0,
        LayoutOrder = v79
    });
    local v81 = v24(v80,"Label",UDim2.new(1,-12,1,0),"⌄  "..v78);
    v81.Position = UDim2.fromOffset(8,0);
    v81.Font = Enum.Font.SourceSansSemibold;
end;

local function v82(v83,v84,v85,v86) --[[ Name: PropertyRow ]]
    local v87 = v17("Frame",v64,{
        Name = "Property_"..v83,
        Size = UDim2.new(1,-5,0,28),
        BackgroundColor3 = v84%2 == 0 and v7.Row or v7.Alternate,
        BorderSizePixel = 0,
        LayoutOrder = v84
    });
    local v88 = v24(v87,"PropertyName",UDim2.new(0.43,-8,1,0),v83);
    v88.Position = UDim2.fromOffset(8,0);

    if typeof(v85) == "boolean" and v86 then
        local v89 = v29(v87,"Boolean",UDim2.new(0.56,-7,1,-4),v85 and "☑ true" or "☐ false");
        v89.Position = UDim2.new(0.43,3,0,2);
        v89.TextXAlignment = Enum.TextXAlignment.Left;
        v89.BackgroundColor3 = v7.Input;
        v89.MouseButton1Click:Connect(function() --[[ Name: ToggleBoolean ]]
            if not v9 then return; end;
            local v90,v91 = pcall(function()
                v9[v83] = not v9[v83];
                return v9[v83];
            end);
            if v90 then
                v89.Text = v91 and "☑ true" or "☐ false";
            end;
        end);
        return;
    end;

    local v92 = v17("TextBox",v87,{
        Name = "Value",
        Position = UDim2.new(0.43,3,0,2),
        Size = UDim2.new(0.56,-7,1,-4),
        BackgroundColor3 = v7.Input,
        BackgroundTransparency = v86 and 0 or 0.5,
        BorderSizePixel = 0,
        Text = v68(v85),
        TextColor3 = v86 and v7.Text or v7.Muted,
        TextSize = 13,
        Font = Enum.Font.SourceSans,
        ClearTextOnFocus = false,
        TextEditable = v86,
        TextXAlignment = Enum.TextXAlignment.Left
    });
    v17("UIPadding",v92,{PaddingLeft = UDim.new(0,5)});

    if v86 then
        v92.FocusLost:Connect(function() --[[ Name: SaveProperty ]]
            if not v9 then return; end;
            local v93 = v71(v85,v92.Text);
            if v93 ~= nil then
                pcall(function()
                    v9[v83] = v93;
                end);
            end;
            local v94,v95 = pcall(function()
                return v9[v83];
            end);
            if v94 then v92.Text = v68(v95); end;
        end);
    end;
end;

local function v96() --[[ Name: UpdateProperties ]]
    if not v9 then return; end;
    v65(v64);
    local v97,v98 = v34(v9);
    v63.Text = v97.."  "..v9.Name.."  ("..v9.ClassName..")";

    local v99 = {};
    local function v100(v101,v102,v103) --[[ Name: RegisterProperty ]]
        table.insert(v99,{v101,v102,v103 == true});
    end;

    v100("Data","Name",true);
    v100("Data","ClassName",false);
    v100("Data","Parent",false);
    v100("Data","Archivable",true);

    if v9:IsA("BasePart") then
        v100("Appearance","Color",true);
        v100("Appearance","Material",false);
        v100("Appearance","Transparency",true);
        v100("Appearance","Reflectance",true);
        v100("Data","Size",true);
        v100("Data","Position",true);
        v100("Data","Orientation",true);
        v100("Behavior","Anchored",true);
        v100("Behavior","CanCollide",true);
        v100("Behavior","CanTouch",true);
        v100("Behavior","CanQuery",true);
        v100("Behavior","Massless",true);
    end;

    if v9:IsA("GuiObject") then
        v100("Appearance","BackgroundColor3",true);
        v100("Appearance","BackgroundTransparency",true);
        v100("Appearance","BorderSizePixel",true);
        v100("Data","Position",true);
        v100("Data","Size",true);
        v100("Data","AnchorPoint",true);
        v100("Data","Rotation",true);
        v100("Data","ZIndex",true);
        v100("Behavior","Visible",true);
        v100("Behavior","Active",true);
        if v9:IsA("TextLabel") or v9:IsA("TextButton") or v9:IsA("TextBox") then
            v100("Text","Text",true);
            v100("Text","TextColor3",true);
            v100("Text","TextTransparency",true);
            v100("Text","TextSize",true);
            v100("Text","TextScaled",true);
        end;
        if v9:IsA("ImageLabel") or v9:IsA("ImageButton") then
            v100("Image","Image",true);
            v100("Image","ImageColor3",true);
            v100("Image","ImageTransparency",true);
        end;
    end;

    if v9:IsA("Sound") then
        v100("Sound","SoundId",true);
        v100("Sound","Volume",true);
        v100("Sound","PlaybackSpeed",true);
        v100("Sound","Looped",true);
        v100("Sound","Playing",true);
        v100("Sound","TimePosition",true);
        v100("Sound","TimeLength",false);
        v100("Sound","PlaybackLoudness",false);
    end;

    if v9:IsA("Light") then
        v100("Appearance","Color",true);
        v100("Appearance","Brightness",true);
        v100("Appearance","Enabled",true);
        v100("Appearance","Shadows",true);
        v100("Appearance","Range",true);
    end;

    if v9:IsA("UIGradient") then
        v100("Appearance","Color",false);
        v100("Appearance","Transparency",false);
        v100("Appearance","Enabled",true);
        v100("Appearance","Offset",true);
        v100("Appearance","Rotation",true);
    end;

    if v9:IsA("Model") then
        v100("Data","PrimaryPart",false);
        v100("Behavior","LevelOfDetail",false);
    end;

    if v9:IsA("ValueBase") then
        v100("Data","Value",true);
    end;

    if v9:IsA("Script") or v9:IsA("LocalScript") then
        v100("Behavior","Enabled",false);
        v100("Data","RunContext",false);
    end;

    local v104 = {"Appearance","Data","Behavior","Text","Image","Sound"};
    local v105 = 0;
    for _,v106 in ipairs(v104) do
        local v107 = false;
        for _,v108 in ipairs(v99) do
            if v108[1] == v106 then
                local v109,v110 = pcall(function()
                    return v9[v108[2]];
                end);
                if v109 then
                    if not v107 then
                        v105 = v105+1;
                        v77(v106,v105);
                        v107 = true;
                    end;
                    v105 = v105+1;
                    v82(v108[2],v105,v110,v108[3]);
                end;
            end;
        end;
    end;
end;

local function v111(v112,v113,v114) --[[ Name: ObjectRow ]]
    local v115 = v17("Frame",v61,{
        Name = "ObjectRow",
        LayoutOrder = v114,
        Size = UDim2.new(1,-7,0,23),
        BackgroundColor3 = v112 == v9 and v7.Selected or v7.Background,
        BorderSizePixel = 0
    });
    local v116 = math.min(v113*15,135);
    local v117 = #v112:GetChildren() > 0;
    local v118 = v29(v115,"Expand",UDim2.fromOffset(18,23),v117 and (v10[v112] and "⌄" or "›") or "");
    v118.Position = UDim2.fromOffset(v116,0);
    v118.BackgroundTransparency = 1;

    local v119,v120 = v34(v112);
    local v121 = v24(v115,"Icon",UDim2.fromOffset(21,23),v119);
    v121.Position = UDim2.fromOffset(v116+19,0);
    v121.TextColor3 = v120;
    v121.TextXAlignment = Enum.TextXAlignment.Center;
    v121.TextSize = 16;

    local v122 = v29(v115,"Name",UDim2.new(1,-v116-43,1,0),v112.Name);
    v122.Position = UDim2.fromOffset(v116+42,0);
    v122.TextXAlignment = Enum.TextXAlignment.Left;
    v122.TextTruncate = Enum.TextTruncate.AtEnd;
    v122.BackgroundTransparency = 1;

    v122.MouseButton1Click:Connect(function() --[[ Name: SelectObject ]]
        v9 = v112;
        v96();
        v14 = true;
    end);
    v118.MouseButton1Click:Connect(function() --[[ Name: ExpandObject ]]
        v10[v112] = not v10[v112];
        v14 = true;
    end);
end;

local function v123() --[[ Name: UpdateExplorer ]]
    if v15 then return; end;
    v15 = true;
    v65(v61);

    local v124 = string.lower(v60.Text);
    local v125 = 0;
    local v126 = 0;

    local function v127(v128,v129) --[[ Name: DrawTree ]]
        if v125 >= 350 or v129 > 20 then return; end;
        v125 = v125+1;
        v111(v128,v129,v125);
        if not v10[v128] then return; end;
        local v130 = v128:GetChildren();
        table.sort(v130,function(v131,v132)
            return string.lower(v131.Name) < string.lower(v132.Name);
        end);
        for _,v133 in ipairs(v130) do
            if v125 >= 350 then break; end;
            v127(v133,v129+1);
        end;
    end;

    local function v134(v135) --[[ Name: SearchObjects ]]
        if v125 >= 350 or v126 >= 5000 then return; end;
        v126 = v126+1;
        if string.find(string.lower(v135.Name),v124,1,true) then
            v125 = v125+1;
            v111(v135,0,v125);
        end;
        for _,v136 in ipairs(v135:GetChildren()) do
            if v125 >= 350 or v126 >= 5000 then break; end;
            v134(v136);
        end;
    end;

    if v124 == "" then
        v127(v3,0);
    else
        v134(v3);
    end;
    v15 = false;
end;

v60:GetPropertyChangedSignal("Text"):Connect(function() --[[ Name: SearchChanged ]]
    v14 = true;
end);

v2.InputChanged:Connect(function(v137) --[[ Name: WindowInputChanged ]]
    if not v12 then return; end;
    if v137.UserInputType ~= Enum.UserInputType.MouseMovement and v137.UserInputType ~= Enum.UserInputType.Touch then return; end;
    if v12.Input.UserInputType == Enum.UserInputType.Touch and v137 ~= v12.Input then return; end;

    local v138 = v137.Position-v12.Start;
    local v139 = v12.Window;
    if v12.Mode == "Move" then
        local v140 = v12.Position;
        v139.Position = UDim2.new(
            v140.X.Scale,v140.X.Offset+v138.X,
            v140.Y.Scale,v140.Y.Offset+v138.Y
        );
    else
        v139.Size = UDim2.fromOffset(
            math.max(230,v12.Size.X+v138.X),
            math.max(180,v12.Size.Y+v138.Y)
        );
    end;
end);

v2.InputEnded:Connect(function(v141) --[[ Name: WindowInputEnded ]]
    if not v12 then return; end;
    if v141 == v12.Input or (v141.UserInputType == Enum.UserInputType.MouseButton1 and v12.Input.UserInputType == Enum.UserInputType.MouseButton1) then
        v12 = nil;
    end;
end);

local function v142() --[[ Name: QueueRefresh ]]
    v16 = v16+1;
    local v143 = v16;
    task.delay(0.4,function()
        if v143 == v16 and v8.Parent then
            v14 = true;
        end;
    end);
end;

v3.DescendantAdded:Connect(v142);
v3.DescendantRemoving:Connect(function(v144) --[[ Name: ObjectRemoving ]]
    if v144 == v9 or (v9 ~= v3 and v9:IsDescendantOf(v144)) then
        v9 = v3;
        v96();
    end;
    v142();
end);

task.spawn(function() --[[ Name: ExplorerRefresh ]]
    while v8.Parent do
        if v14 then
            v14 = false;
            v123();
        end;
        task.wait(0.15);
    end;
end);

v96();
v123();
