$ ->
  hide_translations $('#phrases')
  sliding_translations $('#phrases .phrase')
  animate_new_phrases()
  animate_new_translations()

animate_new_phrases = ->
  $('#phrases .add_phrase form').on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $('#phrases .add_phrase').before(dom)
      dom.hide().show(300)
      sliding_translations(dom)
      $('input',this).val('')
      $('input',dom).focus()
  )

animate_new_translations = (e) ->
  $('.translations form', e).on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $(this).before(dom)
      dom.hide().show(300)
      $('input',this).val('')
      $('#phrases .add_phrase input').focus()
  )
  

translations_of = (e) -> $('.translations',e.currentTarget || e)

hide_translations = (e) ->
  translations_of(e).hide()

sliding_translations = (e) ->
  e.mouseenter(
    (e) -> translations_of(e).show(300)
  ).mouseleave(
    (e) -> translations_of(e).hide(300)
  )

