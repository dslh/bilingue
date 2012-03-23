$ ->
  hide_translations()
  animate_phrases $('#phrases .phrase')
  animate_new_phrases()

animate_phrases = (e) ->
  sliding_translations(e)
  animate_new_translations(e)
  editable_phrases(e)

animate_new_phrases = ->
  $('.add_phrase input').keypress(
    -> $('#errors').html('')
  )
  $('#phrases .add_phrase form').on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      hide_translations()
      $('#phrases .add_phrase').before(dom)
      dom.hide().show(300)
      animate_phrases(dom)
      $('input[type=text]',this).val('')
      $('input',dom).focus()
  ).disable_during_ajax()

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
  $('.translations .new_translation', e).on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $(this).before(dom)
      dom.hide().show(300)
      $('input[type=text]',this).val('')
      $('.note',$(this).parent().parent()).detach()
      $('#phrases .add_phrase input').focus()
  ).disable_during_ajax()

as_jq = (e) -> $(e.currentTarget || e)
translations_of = (e) -> $('.translations',as_jq(e))
delete_button = (e) -> $('.delete',as_jq(e))

hide_translations = ->
  translations_of($('#phrases')).hide()

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

editable_phrases = (e) ->
  $('.native,.translation',e).each( ->
    phrase = $(this)
    phrase.click( ->
      $(this).addClass('edit')
      $('input[type=text]',this).focus()
    ).children('input[type=text]').blur( ->
      phrase.removeClass('edit')
    )

    phrase.children('form').on('ajax:success', ->
      phrase.removeClass('edit')
      $('span',phrase).text($('input[type=text]',this).val())
    ).disable_during_ajax()
  )
