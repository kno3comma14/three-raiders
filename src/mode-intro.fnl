(local gamestate (require :lib.gamestate))

(local menu-logic (require :gui.menu-logic))
(local story-screen (require :story))

(love.graphics.setNewFont 30)

(var menu-state {:options [{:name "Start"
                                   :description "This option starts the game"
                                   :selected true
                                   :context {}}
                           {:name "Quit"
                                  :description "Leave the game"
                                  :selected false
                                  :context {}}]
                 :selected-option 1
                 :ready-to-draw false})

{:draw (fn draw [self message]
         (local (w h _flags) (love.window.getMode)))
 :update (fn update [self dt set-mode])
 :keypressed (fn keypressed [self key set-mode]
               (when (= key "escape")
                 (love.event.quit))
               (when (= key "return")
                 (tset menu-state :ready-to-draw true))
               (when (= key "up")
                 (change-menu-option + (menu-state :selected-option) menu-state))
               (when (= key "down")
                 (change-menu-option - (menu-state :selected-option) menu-state)))}
