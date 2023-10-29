PlayerPotLiftState = Class{__includes = BaseState}

function PlayerPotLiftState:init(player, dungeon, pot)
    print('pot-lift')
    self.player = player
    self.dungeon = dungeon
    self.pot = pot
    print(self.pot)

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8
    
    -- pot is being lifted
    self.player.liftingPot = true
    self.timer = 0

    self.player:changeAnimation('pot-lift-' .. self.player.direction)
end

function PlayerPotLiftState:update(dt)
    self.timer = self.timer + dt
    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('pot-idle',self.pot)
    end

    -- change the position of the pot accordint to the player
    self.pot.y = self.player.y - self.player.height / 2
    self.pot.x = self.player.x

    -- set the self.pot state to lifted
    self.pot.state = 'lifted'
    print('lifted',self.pot.state == 'lifted')

    if self.timer > 0.5 then
        self.player.liftingPot = false
    end
end

function PlayerPotLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end