(local max-index 2)
(local min-index 1)

(fn change-next-index [actual-index state]
  (if (and (> actual-index 0) (<= actual-index (# (. state :options))))
      actual-index
      (if (<= actual-index 0)
          (# (. state :options))
          1)))

(fn select-menu-option [index state]
  (tset state :options index :selected true)
  (for [i 1 (# (. state :options))]
    (when (not= i index)
      (let [option (. state :options i)]
        (tset option :selected false)))))

(fn change-menu-option [operator index state]
  (let [next-index (change-next-index (operator index 1) state)]
    (select-menu-option next-index state)
    (tset state :selected-option next-index)
    (for [i 1 (# (. state :options))]
      (when (not= i next-index)
        (let [option (. state :options i)]
          (tset option :selected false))))))
