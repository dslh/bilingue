$.ajaxPrefilter((opts, originalOpts, xhr) ->
  checked_tags().each((t) ->
    opts.data += '&tags%5B%5D=' + this
  )
)

$ ->
  show_and_hide_phrases $('#tags')
  $('#tags form.new_tag').on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $(this).before(dom)
      dom.hide().show(300)
      show_and_hide_phrases dom
      $('input[type=text]',this).val('').focus()
  )

checked_tags = ->
  $('#tags .tag input[type=checkbox]:checked').map(-> $(this).val())

show_and_hide_phrases = (e) ->
  $('input[type=checkbox]', e).click((e) ->
    tags = checked_tags()
    $('.phrase').each( ->
      phrase_tags = $(this).data('tags').split(',').filter((t) -> t.length != 0)
      matches = phrase_tags.filter((t) -> jQuery.inArray(t,tags) != -1)
      if matches.length == tags.length
        $(this).show(300)
      else
        $(this).hide(300)
    )
  )
