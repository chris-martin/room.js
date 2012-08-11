log = (x) -> console.log(x)

atan = Math.atan
floor = Math.floor
max = Math.max
min = Math.min
pow = Math.pow
sqrt = Math.sqrt
pi = Math.PI

refresh_fn = (line, attributes) ->

  inside = line.find('*')
  inside_x = inside.outerWidth()
  inside_y = inside.outerHeight()

  a = inside_x * 1.0
  b = 100.0
  c = 600.0
  d = inside_y * 1.0

  # alpha and beta are defined such that
  # f(x) = alpha + beta x^2
  # where f(a) = b and f(c) = d
  beta = (b - d) / (pow(a, 2) - pow(c, 2))
  alpha = b - beta * pow(a, 2)

  () ->
    length = floor(max(inside_x, attributes.length))
    thickness = floor(max(d, alpha + beta * pow(length, 2)))
    line.css(
      left: (attributes.center.x - length / 2) - thickness + 'px'
      top: (attributes.center.y - thickness / 2) + 'px'
      width: length + 'px'
      height: thickness + 'px'
      transform: 'rotate(' + attributes.angle + 'rad)'
      'border-width': '0 ' + thickness + 'px'
    )
    inside.css(
      top: (thickness - inside_y) / 2 + 'px'
    )

do ->

  line = $('<div class="line"/>').append(
    $('<div/>').text('line.js')
  )

  attributes =
    angle: 1
    length: 400

  refresh = undefined

  resize = ->
    win = $(window)
    attributes.center =
      x: win.width() / 2
      y: win.height() / 2
    refresh()

  move = (p) ->
    delta =
      x: p.x - attributes.center.x
      y: p.y - attributes.center.y
    attributes.angle = atan(delta.y / delta.x)
    attributes.angle -= pi if delta.x >= 0
    attributes.length = 2 * sqrt(
      pow(delta.x, 2) + pow(delta.y, 2)
    )
    refresh()

  mouse_move = (e) ->
    move({ x: e.pageX, y: e.pageY })

  touch_move = (e) ->
    e.preventDefault()
    touch_start(e)

  touch_start = (e) ->
    mouse_move(window.event.touches[0])

  root = () -> $('html')

  down = (e) ->
    mouse_move(e)
    root().bind('mousemove', mouse_move)

  up = (e) ->
    root().unbind('mousemove', mouse_move)

  $(->
    line.appendTo('body')
    refresh = refresh_fn(line, attributes)
    $(window).resize(resize)
    resize()
    root().bind(
      mousedown: down
      mouseup: up
      mouseleave: up
      touchmove: touch_move
      touchstart: touch_start
    )
  )
