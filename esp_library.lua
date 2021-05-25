local drawingOuro = {obj = {}}
drawingOuro.__index = drawingOuro

function drawingOuro.new(text, props)
    local self = {
        Enabled = props.Enabled or false,
        Text = text,
        Color = props.Color or Color3.fromRGB(255, 255, 255),
        Target = props.Target
    }

    setmetatable(self, drawingOuro)
    self.obj[text] = Drawing.new("Text")
    self.obj[text].Text = self.Text
    self.obj[text].Color = self.Color
    self.obj[text].Position = Vector2.new(workspace.CurrentCamera:WorldToViewportPoint(self.Target.Position).X, workspace.CurrentCamera:WorldToViewportPoint(self.Target.Position).Y)
    self.obj[text].Size = 20
    self.obj[text].Outline = true
    self.obj[text].Visible = self.Enabled
    self.obj[text].Center = true

    game:GetService("RunService").RenderStepped:Connect(function()
        local _, onScreen = workspace.CurrentCamera:WorldToViewportPoint(self.Target.Position)
        if onScreen and self.Enabled then
            self.obj[text].Position = Vector2.new(workspace.CurrentCamera:WorldToViewportPoint(self.Target.Position).X, workspace.CurrentCamera:WorldToViewportPoint(self.Target.Position).Y)
            self.obj[text].Visible = true
        else
            self.obj[text].Visible = false
        end
        
        if not self.Target:IsDescendantOf(workspace) then
            self.obj[text].Visible = false
        end
    end)

    return self
end

function drawingOuro:CurrentColor(color)
    if color ~= nil then
        self.obj[self.Text].Color = color
    end
    return ("%s, %s, %s"):format(math.floor(self.obj[self.Text].Color.R * 255), math.floor(self.obj[self.Text].Color.G * 255), math.floor(self.obj[self.Text].Color.B * 255))
end

return drawingOuro
