-- H4, I dont support racism at all but juts wanted to make it fun :)
local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local centerx = Camera.ViewportSize.X / 2
local centery = Camera.ViewportSize.Y / 2

-- Settings
local crosshair = true
local Length = 20
local thickness = 2.5
local color = Color3.new(1, 0, 0)

local function Create(type, table)
    local drawing = Drawing.new(type)
    for i,v in next, table do
        drawing[i] = v
    end

    return drawing
end

local lineProps = {
    Thickness = thickness,
    Color = color,
    Visible = true,   
    ZIndex = 999
}

local lineProps2 = table.clone(lineProps)
lineProps2.ZIndex = 1

local lines = {
    line1 = Create("Line", lineProps),
    line2 = Create("Line", lineProps),
    line3 = Create("Line", lineProps),
    line4 = Create("Line", lineProps),
    line5 = Create("Line", lineProps),
    line6 = Create("Line", lineProps),

    outlines = {
        o1 = Create("Line", lineProps2),
        o2 = Create("Line", lineProps2),
        o3 = Create("Line", lineProps2),
        o4 = Create("Line", lineProps2),
        o5 = Create("Line", lineProps2),
        o6 = Create("Line", lineProps2)
    }
}

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)    
    local MousePos = Vector2.new(centerx, centery)
    if crosshair then
        for i,v in next, lines do
            if table.find(v, "Visible") then
                v.Visible = true
            end
        end
        for i,v in next, lines.outlines do
            v.Visible = true
        end

        local t = 1
        local starty1 = Vector2.new(MousePos.X, MousePos.Y - Length)
        local endy1 = Vector2.new(MousePos.X, MousePos.Y + Length)

        local starty12 = starty1 + Vector2.new(Length,0)
        local endy12 = endy1 - Vector2.new(Length,0)        

        local startx1 = Vector2.new(MousePos.X - Length, MousePos.Y)        
        local endx1 = Vector2.new(MousePos.X + Length, MousePos.Y)

        local startx12 = startx1 - Vector2.new(0, Length)
        local endx12 = endx1 + Vector2.new(0, Length)
        
        lines.line1.From = endy1 lines.line1.To = starty1
        lines.line2.From = endx1 lines.line2.To = startx1

        lines.line3.From = starty1 - Vector2.new(t, 0) lines.line3.To = starty12
        lines.line4.From = endy1 + Vector2.new(t+0.1, 0) lines.line4.To = endy12
        lines.line5.From = startx1 + Vector2.new(0, t) lines.line5.To = startx12
        lines.line6.From = endx1 - Vector2.new(0, t) lines.line6.To = endx12

        for i,v in next, lines.outlines do
            v.Color = Color3.new(0,0,0)
            v.Thickness = thickness + 3
        end

        lines.outlines.o1.From = endy1 lines.outlines.o1.To = starty1 
        lines.outlines.o2.From = endx1 lines.outlines.o2.To = startx1 
        
        lines.outlines.o3.From = starty1 - Vector2.new(t+1.95, 0) lines.outlines.o3.To = (starty12 + Vector2.new(2, 0))
        lines.outlines.o4.From = endy1 + Vector2.new(t+2, 0) lines.outlines.o4.To = (endy12 - Vector2.new(2, 0))
        lines.outlines.o5.From = startx1 + Vector2.new(0, t+2.3) lines.outlines.o5.To = (startx12 - Vector2.new(0, 2))
        lines.outlines.o6.From = endx1 - Vector2.new(0, t+2) lines.outlines.o6.To = (endx12 + Vector2.new(0, 1.7)) 
    else
        for i,v in next, lines do
            if type(v) ~= 'table' then
                v.Visible = false
            end
        end
        for i,v in next, lines.outlines do
            v.Visible = false
        end
    end
end)
