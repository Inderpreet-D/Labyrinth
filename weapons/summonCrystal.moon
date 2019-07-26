export class SummonCrystal extends Weapon
  new: (player) =>
    sprite = Sprite "unused/wormhole.tga", 40, 40, 1, 1
    sprite.color = {20, 255, 100, 255}
    super player, sprite
    @damage = 3

  action: (x, y, button, isTouch) =>
    sprite = Sprite "weapon/crystal.tga", 64, 32, 1, 1
    sprite.color = {50, 200, 200, 255}
    orb = GameObject @player.position.x - Screen_Size.half_width, @player.position.y - Screen_Size.half_height, sprite
    orb.base_color = sprite.color
    orb.attack_color = {255, 20, 100, 255}
    orb.delay = 2
    orb.elapsed = orb.delay
    orb.player = @player
    orb.offset = (Vector x - @player.position.x, y - @player.position.y, true)\multiply (@player.sprite.scaled_height * 1.5)
    orb.position = Vector @player.position.x, @player.position.y
    orb.position\add orb.offset
    orb.draw_health = false
    orb.update = (dt) =>
      @sprite\update dt
      @offset = (Vector @position.x - @player.position.x, @position.y - @player.position.y, true)\multiply (@player.sprite.scaled_height * 1.5)
      speed = Vector @offset.x + @player.position.x - @position.x, @offset.y + @player.position.y - @position.y
      speed = speed\multiply 1.75
      @position\add (speed\multiply dt)
      @elapsed += dt
      if @elapsed >= @delay
        @sprite.color = @base_color
        filters = {EntityTypes.enemy, EntityTypes.boss}
        for k, filter in pairs filters
          for k2, o in pairs Driver.objects[filter]
            target = o\getHitBox!
            bullet = @getHitBox!
            bullet.radius *= 5
            if target\contains bullet
              o\onCollide @
              @elapsed = 0
              @sprite.color = @attack_color
    Driver\addObject orb, EntityTypes.particle
    Timer 3, @, (() =>
      @parent.used = false
    ), false
    Timer 15, @, (() =>
      orb.health = 0
    ), false