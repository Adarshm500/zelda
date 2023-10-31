PlayerPotLiftState = Class{__includes = BaseState}

function PlayerPotLiftState:init(player, dungeon, pot)
    self.player = player
    self.dungeon = dungeon
    self.pot = pot

    self.player:changeAnimation('pot-lift-' .. self.player.direction)
end

function PlayerPotLiftState:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        -- change the state
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('pot-idle',self.pot)
    end
    -- change the position of the pot accordint to the player direction
    if self.player.direction == 'left' then
        self.pot.y = self.player.y
        self.pot.x = self.player.x - self.player.width / 4
    elseif self.player.direction == 'right' then
        self.pot.y = self.player.y
        self.pot.x = self.player.x + self.player.width / 4
    elseif self.player.direction == 'up' then
        self.pot.y = self.player.y - self.player.height / 2 
        self.pot.x = self.player.x 
    elseif self.player.direction == 'down' then
        self.pot.y = self.player.y
        self.pot.x = self.player.x 
    end
    self.pot.state = 'lifted'

    -- set the self.pot state to lifted
end

function PlayerPotLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end