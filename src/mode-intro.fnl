(local gamestate (require :lib.gamestate))

(local logic (require "gui.menu-logic"))
(local story-screen (require :story))

(var menu-state {:options [{:name "Start"
                            :description "This option starts the game"
                            :selected true
                            :context {}}
                           {:name "Quit"
                            :description "Leave the game"
                            :selected false
                            :context {}}]
                 :selected-option 1
                 :ready-to-action false})

(fn draw-menu [state w h]
  (for [i 1 (# (. state :options))]
    (let [main-coords {:x (- (/ w 2) 40) :y (/ h 2)}
          option (. state :options i)
          x (. main-coords :x)
          y (+ (. main-coords :y) (* (- i 1) 30))
          text (. option :name)]
      (if (. option :selected)
          (do
            (love.graphics.print ">" (- x 30) y)
            (love.graphics.print "<" (+ x 80) y)
            (love.graphics.print text x y))
          (do
            (love.graphics.print text x y))))))

;; Game life-cycle
{:draw (fn draw [self message]
         (local (w h _flags) (love.window.getMode))
         (draw-menu menu-state w h))
 :update (fn update [self dt set-mode]
           (when (. menu-state :ready-to-action)
             (let [selected-option (. menu-state :selected-option)
                   option-name (. menu-state :options selected-option :name)]
               (when (= option-name "Quit")
                 (love.event.quit)))))
 :keypressed (fn keypressed [self key set-mode]
               (when (= key "return")
                 (tset menu-state :ready-to-action true))
               (when (= key "up")
                 (tset menu-state :ready-to-action false)
                 (logic.change-menu-option (- (. menu-state :selected-option) 1)
                                           menu-state))
               (when (= key "down")
                 (tset menu-state :ready-to-action false)
                 (logic.change-menu-option (+ (. menu-state :selected-option) 1)
                                           menu-state)))}
