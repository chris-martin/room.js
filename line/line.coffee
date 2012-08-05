$(->

  log = (x) -> console.log(x)

  atan = Math.atan
  pow = Math.pow
  sqrt = Math.sqrt

  line = $('<div class="line"/>').appendTo('body')

  refresh = ->
    line.css(
      left: (center.x - length / 2) + 'px'
      top: center.y + 'px'
      width: length + 'px'
      '-webkit-transform': 'rotate(' + angle + 'rad)'
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
