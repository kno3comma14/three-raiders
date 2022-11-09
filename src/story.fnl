(local gamestate (require :lib.gamestate))
(love.graphics.setNewFont 30)

{:draw (fn draw [self message]
         (local (w h _flags) (love.window.getMode))
         (love.graphics.print "Story" (/ w 2) (/ h 2)))
 :update (fn update [self dt set-mode])
 :keypressed (fn keypressed [self key set-mode]
               (when (= key "return")
                 (love.event.quit)))} ;; This has to be changed by the battle screen
