$(->

  log = (x) -> console.log(x)

  atan = Math.atan
  floor = Math.floor
  max = Math.max
  min = Math.min
  pow = Math.pow
  sqrt = Math.sqrt

  line = $('<div class="line"/>').appendTo('body')
    .append(inside = $('<div/>').text('line.js'));

  inside_x = inside.outerWidth()
  inside_y = inside.outerHeight()

  a = inside_x * 1.0
  b = 100.0
  c = 1000.0
  d = inside_y * 1.5

  # alpha and beta are defined such that
  # f(x) = alpha + beta x^2
  # where f(a) = b and f(c) = d
  beta = (b - d) / (pow(a, 2) - pow(c, 2))
  alpha = b - beta * pow(a, 2)

  refresh = ->
    $length = floor(max(inside_x, length))
    thickness = floor(max(d, alpha + beta * pow($length, 2)))
    line.css(
      left: (center.x - $length / 2) - thickness + 'px'
      top: (center.y - thickness / 2) + 'px'
      width: $length + 'px'
      height: thickness + 'px'
      '-webkit-transform': 'rotate(' + angle + 'rad)'
      'border-width': '0 ' + thickness + 'px'
    )
    inside.css(
      top: (thickness - inside_y) / 2 + 'px'
    )

  angle = 1
  center = undefined
  length = 400

  do ->
    win = $(window)

    resize = ->
      center =
        x: win.width() / 2
        y: win.height() / 2
      refresh()

    win.resize(resize)
    resize()

  move = (p) ->
    delta =
      x: p.x - center.x
      y: p.y - center.y
    angle = atan(delta.y / delta.x)
    length = 2 * sqrt(
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

  root = $('html')

  down = (e) ->
    mouse_move(e)
    root.bind('mousemove', mouse_move)

  up = (e) ->
    root.unbind('mousemove', mouse_move)

  root.bind(
    mousedown: down
    mouseup: up
    mouseleave: up
    touchmove: touch_move
    touchstart: touch_start
  )

)
