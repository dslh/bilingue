$ ->
  $('#errors').ajaxError(
    (evt,xhr,opts,error) ->
      $(this).html(xhr.responseText)
  )
