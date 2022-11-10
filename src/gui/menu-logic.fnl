{:change-next-index (fn change-next-index [actual-index state]
                      (if (and (> actual-index 0) (<= actual-index (# (. state :options))))
                          actual-index
                          (if (<= actual-index 0)
                              (# (. state :options))
                              1)))

 :select-menu-option (fn select-menu-option [index state]
                       (tset state :options index :selected true)
                       (for [i 1 (# (. state :options))]
                         (when (not= i index)
                           (let [option (. state :options i)]
                             (tset option :selected false)))))

 :change-menu-option (fn change-menu-option [index state]
                       (let [next-index (change-next-index index state)]
                         (tset state :options next-index :selected true)
                         (tset state :selected-option next-index)
                         (for [i 1 (# (. state :options))]
                           (when (not= i next-index)
                             (let [option (. state :options i)]
                               (tset option :selected false))))))}
