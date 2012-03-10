$.extend($.fn, {disable_during_ajax: ->
  this.on('ajax:beforeSend', ->
    $('input[type=text]',this).attr('disabled',true)
  ).on('ajax:complete', ->
    $('input[type=text]',this).attr('disabled',null)
  )
})
