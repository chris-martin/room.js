$(() ->

  $('<div class="line"/>').appendTo('body')
    .css(
      '-webkit-transform': 'rotate(72deg)'
      top: '200px'
      left: '400px'
      width: 400
    )

  pos = $('<span/>').appendTo('body')

  move = (p) ->
    pos.text(p.x + ', ' + p.y)

  mouse_move = (e) ->
    move({ x: e.pageX, y: e.pageY })

  touch_move = (e) ->
    e.preventDefault()
    touch_start(e)

  touch_start = (e) ->
    mouse_move(window.event.touches[0])

  down = (e) ->
    mouse_move(e)
    $(e.target).bind('mousemove', mouse_move)

  up = (e) ->
    $(e.target).unbind('mousemove', mouse_move)

  $('html').bind(
    mousedown: down
    mouseup: up
    mouseout: up
    touchmove: touch_move
    touchstart: touch_start
  )

)