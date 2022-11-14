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


;; Heroes section
(fn is-heroe-inside-limits [heroes-position p1 p2]
  (let [heroes-x (. heroes-position :x)
        heroes-y (. heroes-position :y)]
    (and (< heroes-x (. p2 :x))
         (< heroes-y (. p2 :y))
         (> heroes-x (. p1 :x))
         (> heroes-y (. p1 :y)))))

(fn move-heroes-reference [heroe-reference p1 p2 dt]
  (let [actual-position-x (. heroe-reference :position :x)
        actual-position-y (. heroe-reference :position :y)
        new-position-x (+ actual-position-x (* (. heroe-reference :speed) dt))
        new-position-y (+ actual-position-y (* (. heroe-reference :speed) dt))]
    (when (is-heroe-inside-limits {:x new-position-x :y new-position-y} p1 p2)
      (tset heroe-reference :position {:x new-position-x :y new-position-y}))))

(fn move-heroes-party [heroe-reference heroe-one heroe-two p1 p2]
  (local default-distance 40)
  (move-heroes-reference heroe-reference p1 p2 dt)
  (let [actual-reference-position-x (. heroe-reference :position :x)
        actual-reference-position-y (. heroe-reference :position :y)
        heroe-one-position-x (- actual-reference-position default-distance)
        heroe-one-position-y (+ actual-reference-position default-distance)
        heroe-two-position-x (+ actual-reference-position default-distance)
        heroe-two-position-y (+ actual-reference-position default-distance)]
    (tset heroe-one :position {:x heroe-one-position-x :y heroe-one-position-y})
    (tset heroe-two :position {:x heroe-two-position-x :y heroe-two-position-y})
    (move-heroes-reference heroe-one p1 p2 dt)
    (move-heroes-reference heroe-two p1 p2 dt)))
