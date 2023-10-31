PlayerPotIdleState = Class{__includes = EntityIdleState}

function PlayerPotIdleState:init(entity, dungeon, pot)
    self.entity = entity
    self.dungeon = dungeon
    self.pot = pot

    self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
        love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk', self.pot)
    end

    if love.keyboard.wasPressed('space') then
     -- do nothing
    end

    if love.keyboard.wasPressed('return') then
        -- throw the pot
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

        self.pot.state = 'ground'
        self.pot:fire(dx, dy)
        self.entity:changeState('idle')
    end 
end