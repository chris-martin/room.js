init = ->

  log = (x) -> console.log(x)
  atan = Math.atan

  line = $('<div class="line"/>')
    .appendTo('body')
    .css('width', '400px')

  center = undefined

  do ->
    win = $(window)

    resize = ->
      center =
        x: win.width() / 2
        y: win.height() / 2
      line.css(
        left: (center.x - 200) + 'px'
        top: center.y + 'px'
      )

    win.resize(resize)
    resize()

  rotate = (el, angle) ->
    $(el).css('-webkit-transform', 'rotate(' + angle + 'rad)')

  move = (p) ->
    angle = atan((p.y - center.y) / (p.x - center.x))
    rotate(line, angle)

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

$(init)
