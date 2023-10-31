PlayerPotLiftState = Class{__includes = BaseState}

function PlayerPotLiftState:init(player, dungeon, pot)
    self.player = player
    self.dungeon = dungeon
    self.pot = pot

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8
    
    self.player:changeAnimation('pot-lift-' .. self.player.direction)
end

function PlayerPotLiftState:update(dt)
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('pot-idle',self.pot)
    end

    -- change the position of the pot accordint to the player
    self.pot.y = self.player.y - self.player.height / 2
    self.pot.x = self.player.x

    -- set the self.pot state to lifted
    self.pot.state = 'lifted'
end

function PlayerPotLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end