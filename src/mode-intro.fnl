(local gamestate (require :lib.gamestate))
(local story-screen (require :story))
(love.graphics.setNewFont 30)

(var menu-state {:options {:start {:description "This option starts the game"
                                   :selected true
                                   :position 1
                                   :context {}}
                           :settings {:description "Settings to be used for the game"
                                      :selected false
                                      :position 2
                                      :context {}}
                           :quit {:description "Leave the game"
                                  :selected false
                                  :position 3
                                  :context {}}}})
(local max-index 3)
(local min-index 1)

(fn select-menu-option [target]
  (let [option (. menu-state :options target)]
    (when (not (. option :selected))
      (tset option :selected true))))

(fn change-option-index [operator index]
  (let [aux-index (operator index 1)
        next-option-index (if (< aux-index 1 )
                              max-index
                   ´           ())]))

(fn change-menu-option [operator option]
  (let []))

{:draw (fn draw [self message]
         (local (w h _flags) (love.window.getMode)))
 :update (fn update [self dt set-mode])
 :keypressed (fn keypressed [self key set-mode]
               (when (= key "escape")
                 (love.event.quit))
               (when (= key "return")
                 (gamestate.switch story-screen)))}
