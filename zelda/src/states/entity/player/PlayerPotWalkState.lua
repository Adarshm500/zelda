PlayerPotWalkState = Class{__includes = PlayerWalkState}

function PlayerPotWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    print('lift')
    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotWalkState:update(dt)
    print('potwalking')
    -- perform base collision detection against walls
    self.canSwingSword = false
    PlayerWalkState.update(self, dt)
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if object.type == 'pot' then
            object.y = self.entity.y - self.entity.height / 2
            object.x = self.entity.x

            if self.entity.direction == 'left' or self.entity.direction == 'right' then
                object.state = 'side'
            else
                object.state = 'top' 
            end
        end
    end

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
        self.entity:changeState('pot-idle')
    end

    if love.keyboard.wasPressed('space') then
        -- Do nothing
    end
end