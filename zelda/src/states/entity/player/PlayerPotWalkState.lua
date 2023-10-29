PlayerPotWalkState = Class{__includes = PlayerWalkState}

function PlayerPotWalkState:init(player, dungeon, pot)
    self.entity = player
    self.dungeon = dungeon
    self.pot = pot
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

    -- pot tracks the location of the player
    self.pot.y = self.entity.y - self.entity.height / 2
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
end