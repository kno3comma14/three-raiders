(local anim8 (require :lib.anim8.anim8))

(fn load-image [path]
  (let [image (love.graphics.newImage path)]
    (image:setFilter "nearest")
    image))

(local knight-idle-sheet (load-image "assets/spritesheets/Idle-Sheet.png"))
(local grid (anim8.newGrid 32 32 (knight-idle-sheet:getWidth) (knight-idle-sheet:getHeight)))
(local animation (anim8.newAnimation (grid "1-4" 1) 0.1))

{:animation animation
 :knight-idle-sheet knight-idle-sheet}







