--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- flag to check collision
    self.isColliding = false

    -- default empty collision callback
    self.onCollide = function() end

    self.projectile = nil
    self.remove = false
    self.removing = false -- flag to check if the process of object removal going on (to add some functionality like shatter effect)
end

function GameObject:fire(dx, dy)
    self.projectile = Projectile(self, dx, dy)
end

function GameObject:update(dt)
    if self.projectile then
        self.projectile:update(dt)
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    if self.projectile then
        self.projectile:render(adjacentOffsetX, adjacentOffsetY)
    end

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end