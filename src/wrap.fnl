(local gamestate (require :lib.gamestate))
(local stdio (require :lib.stdio))

(fn love.load [args]
  ;; (love.window.setFullscreen true "desktop")
  (love.graphics.setDefaultFilter "nearest" "nearest" 0)
  (if (= :web (. args 1)) (global web true) (global web false))
  (gamestate.registerEvents)
  (gamestate.switch (require :mode-intro))
  (when (not web) (stdio.start)))
