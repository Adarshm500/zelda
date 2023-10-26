PlayerPotLiftState = Class{__includes = BaseState}

function PlayerPotLiftState:init(player, dungeon)
    print('pot-lift')
    self.player = player
    self.dungeon = dungeon

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
        self.player:changeState('pot-idle')
    end

    print(self.player.liftingPot)

    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if object.type == 'pot' then
            object.y = self.player.y - self.player.height / 2
            object.x = self.player.x

            if self.player.direction == 'left' or self.player.direction == 'right' then
                object.state = 'side'
            else
                object.state = 'top' 
            end
        end
    end
    if self.timer > 0.5 then
        self.player.liftingPot = false
    end
end

function PlayerPotLiftState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end