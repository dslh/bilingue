$ ->
  hide_translations $('#phrases')
  sliding_translations $('#phrases .phrase')
  animate_new_phrases()
  animate_new_translations()

animate_new_phrases = ->
  $('.add_phrase input').keypress(
    -> $('#errors').html('')
  )
  $('#phrases .add_phrase form').on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $('#phrases .add_phrase').before(dom)
      dom.hide().show(300)
      sliding_translations(dom)
      animate_new_translations(dom)
      $('input[type=text]',this).val('')
      $('input',dom).focus()
  )

animate_new_translations = (e) ->
  $('.translations input',e).keypress(
    -> $('#errors').html('')
  )
  $('.phrase',e).each( (p) ->
    $('.icons a',p).on('ajax:success', ->
      p = $(this).parent().parent()
      p.hide(300, -> p.detach())
    )
  )
  $('.translations form', e).on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $(this).before(dom)
      dom.hide().show(300)
      $('input[type=text]',this).val('')
      $('.note',$(this).parent().parent()).detach()
      $('#phrases .add_phrase input').focus()
  )

as_jq = (e) -> $(e.currentTarget || e)
translations_of = (e) -> $('.translations',as_jq(e))
delete_button = (e) -> $('.delete',as_jq(e))

hide_translations = (e) ->
  translations_of(e).hide()

sliding_translations = (e) ->
  delete_button(e).hide()
  e.mouseenter((e) ->
    translations_of(e).stop(true).show(300)
    delete_button(e).stop(true).fadeIn(300)
    as_jq(e).addClass('open')
  ).mouseleave((e) ->
    translations_of(e).stop(true).hide(300, ->
      $(this).attr('style','display:none')
    )
    delete_button(e).stop(true).fadeOut(300, ->
      $(this).attr('style','display:none')  
    )
    as_jq(e).removeClass('open')
  )

