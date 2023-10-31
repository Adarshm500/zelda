--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(object, dx, dy)
    self.object = object
    self.object.state = 'lifted'
    self.initX = object.x
    self.initY = object.y
    self.dx = dx
    self.dy = dy
    -- distance travelled after fire
    self.distanceTravelledX = 0
    self.distanceTravelledY = 0

    -- wait for a bit before removing the pot(to add the shatter effect)
    self.delayTimer = 0
end

function Projectile:update(dt)

    -- if the object collides with the wall it shatters and is removed
    local function wallCollision()
        if self.object.type == 'pot' then
            self.object.state = 'broken'
        end
        -- stop the object
        self.object.projectile.dx = 0
        self.object.projectile.dy = 0

        -- remove the object
        self.object.remove = true
    end

    local leftBound = MAP_RENDER_OFFSET_X + TILE_SIZE
    local rightBound = VIRTUAL_WIDTH - TILE_SIZE * 2
    local topEdge = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.object.height / 2
    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE

    local isProjectileMoving = self.object.projectile.dx ~= 0 or self.object.projectile.dy ~= 0
    
    if isProjectileMoving then
        local isOutsideXBounds = (self.object.projectile.dx < 0 and self.object.x <= leftBound) or
                                 (self.object.projectile.dx > 0 and self.object.x + self.object.width >= rightBound)
        
        local isOutsideYBounds = (self.object.projectile.dy < 0 and self.object.y <= topEdge) or
                                 (self.object.projectile.dy > 0 and self.object.y + self.object.height >= bottomEdge)
    
        if isOutsideXBounds or isOutsideYBounds then
            wallCollision()
        end
    end

    -- calculate the distance
    self.distanceTravelledX = math.abs(self.object.x - self.initX)
    self.distanceTravelledY = math.abs(self.object.y - self.initY)
    
    -- remove the pot after four tiles
    if self.distanceTravelledX >= 4 * TILE_SIZE or self.distanceTravelledY >= 4 * TILE_SIZE then
        self.dx = 0
        self.dy = 0
        self.object.remove = true
    else
        -- update the location of object
        self.object.x = self.object.x + self.dx
        self.object.y = self.object.y + self.dy
    end
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.object.texture], gFrames[self.object.texture][self.object.states[self.object.state].frame or self.object.frame],
    self.object.x + adjacentOffsetX, self.object.y + adjacentOffsetY)
end