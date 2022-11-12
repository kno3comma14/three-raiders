(local anim8 (require :lib.anim8))
(local images (require :images))

;; Loading images
(local knight-sheet (images.load-image "assets/spritesheets/knight-heroe.png"))
(local ranger-sheet (images.load-image "assets/spritesheets/forsaken-ranger.png"))
(local priest-sheet (images.load-image "assets/spritesheets/shadow-priest-heroe.png"))

;; Creating grids
(local knight-grid (anim8.newGrid 32 32 (knight-sheet:getWidth) (knight-sheet:getHeight)))
(local ranger-grid (anim8.newGrid 32 32 (ranger-sheet:getWidth) (ranger-sheet:getHeight)))
(local priest-grid (anim8.newGrid 32 32 (priest-sheet:getWidth) (priest-sheet:getHeight)))

;; Creating animations
(local knight-idle-animation (anim8.newAnimation (grid "1-4" 1) 0.1))
(local knight-run-animation (anim8.newAnimation (grid "5-7" 1) 0.1))
(local knight-attack-animation (anim8.newAnimation (grid "8-12" 1) 0.1))
(local knight-special-animation (anim8.newAnimation (grid "13-18" 1) 0.1))

(local ranger-idle-animation (anim8.newAnimation (grid "1-4" 1) 0.1))
(local ranger-run-animation (anim8.newAnimation (grid "5-7" 1) 0.1))
(local ranger-attack-animation (anim8.newAnimation (grid "8-13" 1) 0.1))

(local priest-idle-animation (anim8.newAnimation (grid "1-4" 1) 0.1))å
(local priest-run-animation (anim8.newAnimation (grid "5-7" 1) 0.1))
(local priest-attack-animation (anim8.newAnimation (grid "8-14" 1) 0.1))


;; Registering animations
{:knight-sheet knight-sheet
 :knight-idle-animation knight-idle-animation
 :knight-run-animation knight-run-animation
 :knight-attack-animation knight-attack-animation
 :knight-special-animation knight-special-animation

 :ranger-sheet ranger-sheet
 :ranger-idle-animation ranger-idle-animation
 :ranger-run-animation ranger-run-animation
 :ranger-attack-animation ranger-attack-animation

 :priest-sheet priest-sheet
 :priest-idle-animation priest-idle-animation
 :priest-run-animation priest-run-animation
 :priest-attack-animation priest-attack-animation}







