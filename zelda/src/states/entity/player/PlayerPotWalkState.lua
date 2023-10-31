PlayerPotWalkState = Class{__includes = PlayerWalkState}

function PlayerPotWalkState:init(player, dungeon, pot)
    self.entity = player
    self.dungeon = dungeon
    self.pot = pot
    self.entity.canSwingSword = false
    self.entity.canChangeRoom = false

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotWalkState:update(dt)
    -- perform base collision detection against walls
    PlayerWalkState.update(self, dt)

    for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
        if self.entity:collides(doorway) then
            gSounds['invalid-move']:play()
        end
    end

    -- pot tracks the location of the player
    self.pot.y = self.entity.y - self.entity.height / 3
    self.pot.x = self.entity.x

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('pot-walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('pot-walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('pot-walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('pot-walk-down')
    else
        self.entity:changeState('pot-idle', self.pot)
    end

    if love.keyboard.wasPressed('space') then
        -- Do nothing
    end

    if love.keyboard.wasPressed('return') then
        -- throw the pot in the direction of the player
        local dx = 0
        local dy = 0
        if self.entity.direction == 'left' then
            dx = -2
        elseif self.entity.direction == 'right' then
            dx = 2
        elseif self.entity.direction == 'up' then
            dy = -2
        elseif self.entity.direction == 'down' then
            dy = 2
        end

        gSounds['projectile']:play()
        self.pot:fire(dx, dy)
        self.entity:changeState('idle')
    end 
end