(fn load-image [path]
  (let [image (love.graphics.newImage path)]
    (image:setFilter "nearest")
    image))



{:load-image load-image}
