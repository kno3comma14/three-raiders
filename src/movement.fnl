;; Enemy section
(fn move-enemy [enemy heroes speed dt]
  (let [actual-enemy-position-x (. enemy :position :x)
        actual-enemy-position-y (. enemy :position :y)
        actual-heroes-position-x (. heroes :position :x)
        actual-heroes-position-y (. heroes :position :y)
        dist-x (- actual-lisper-position-x actual-enemy-position-x)
        dist-y (- actual-lisper-position-y actual-enemy-position-y)
        direction (math.atan2 dist-y dist-x)
        new-enemy-position-x (+ actual-enemy-position-x (* (* speed (math.cos direction)) dt))
        new-enemy-position-y (+ actual-enemy-position-y (* (* speed (math.sin direction)) dt))]
    {:x new-enemy-position-x :y new-enemy-position-y}))

(fn move-all-enemies [dt speed enemy-swarm heroes]
  (for [i 1 (# (enemy-swarm))]
    (let [enemy (. enemy-swarm i)]
      (tset enemy :position (move-enemy enemy heroes speed dt)))))

(fn is-heroe-inside-limits [heroes-position p1 p2]
  (let [heroes-x (. heroes-position :x)
        heroes-y (. heroes-position :y)]
    (and (< heroes-x (. p2 :x))
         (< heroes-y (. p2 :y))
         (> heroes-x (. p1 :x))
         (> heroes-y (. p1 :y)))))

;; Heroes section
(fn move-heroes-reference [heroe-reference p1 p2]
  (let [actual-position-x (. heroe-reference :position :x)
        actual-position-y (. heroe-reference :position :y)
        angle 0
        new-position-x (+ actual-position-x (* (math.cos (+ angle (/ math.pi 2))) (. heroe-reference :velocity :y)))
        new-position-y (+ actual-position-y (* (math.sin (+ angle (/ math.pi 2))) (. heroe-reference :velocity :y)))]
    (when (is-heroe-inside-limits new-position-x new-position-y p1 p2)
      (tset heroe-reference :position :x new-position-x)
      (tset heroe-reference :position :y new-position-y)))
