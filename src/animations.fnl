(local anim8 (require :lib.anim8))
(local images (require :images))

(local knight-sheet (images.load-image "assets/spritesheets/Idle-Sheet.png"))

(local grid (anim8.newGrid 32 32 (knight-sheet:getWidth) (knight-sheet:getHeight)))
(local animation (anim8.newAnimation (grid "1-4" 1) 0.1))

{:animation animation
 :knight-sheet knight-sheet}







