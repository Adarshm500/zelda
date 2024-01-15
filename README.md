# Legend of Zelda
### Video Demo:  [Watch Demo](https://youtu.be/IPBM3ryj330?si=wTb3mXdjfzXYWv9M)
### Description:
This is an implementation of legend of zelda game. The game is part of CS50 Game Development and I have added the specified features in the Problem Set.

### Table of Contents

- [Hearts](#hearts)
- [Pots](#pots)
  - [Carrying Pots](#carrying-pots)
  - [Throwing Pots](#throwing-pots)
### Features Added:
#### Hearts
- Hearts occasionally drop from vanquished enemies at random. When picked up by the player, they will heal the player for a full heart.
- Each individual heart is worth 2 points of damage. Incrementing health by 2 is done carefully to avoid exceeding the visual cap of 6.

- Define a GameObject with an onConsume callback
- Refer to Super Mario Bros. for insights on the implementation.

#### Pots
- Pots have been added to the game world at random. The player can pick up pots, and their animation will change to reflect them carrying the pot.
- The player cannot swing their sword while carrying a pot. To lift a pot, the player can press a designated key (e.g., enter or return) when in front of it.
- New states for the player have been added, and a link has been established between the pot and the player to ensure the pot tracks the player's position.

#### Throwing Pots
- When carrying a pot, the player can throw it. The thrown pot travels in a straight line based on where the player is facing.
- The pot disappears when it collides with a wall, travels more than four tiles, or collides with an enemy.
- If the pot collides with an enemy, it does 1 point of damage. The GameObject has been extended to accommodate this functionality,
- with the addition of a projectile field, allowing for the specification of dx and dy for traveling functionality.
- The :fire method triggers the throwing behavior by passing in the specified dx and dy.

 Feel free to explore the code for more details on the implementation.

