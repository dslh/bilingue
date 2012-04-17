$.ajaxPrefilter((opts, originalOpts, xhr) ->
  checked_tags().each((t) ->
    opts.data += '&tags%5B%5D=' + this
  )
)

$ ->
  filter_phrases() unless $('#phrases').length == 0

filter_phrases = ->
  show_and_hide_phrases $('#tags')
  $('#tags form.new_tag').on('ajax:success',
    (evt, data, xhr) ->
      dom = $(data)
      $(this).before(dom)
      dom.hide().show(300)
      show_and_hide_phrases dom
      $('input[type=text]',this).val('').focus()
  )
  $('#tags form.new_tag').submit((e) ->
    e.preventDefault()
    input = $('#tag_name',this)
    name = input.val()
    input.val('')
    id = "tag_#{name}_check"
    existing = $("#tags ##{id}")
    if existing.length > 0
      existing.prop('checked',true)
      set_phrase_visibility(checked_tags())
      return
    # Needs to be replaced with a client/server mustache template
    new_tag = $(
      "<form class='tag'>
        <input id='#{id}' name='#{id}' type='checkbox' value='#{name}' />
        <label for='#{id}'>#{name}</label>
      </form>"
    )
    $(this).before(new_tag)
    show_and_hide_phrases(new_tag.hide().show(300))
  )

set_phrase_visibility = (tags) ->
  $('.phrase').each( ->
    phrase_tags = $(this).data('tags')
    matches = phrase_tags.filter((t) -> jQuery.inArray(t,tags) != -1)
    if matches.length == tags.length
      $(this).show(300)
    else
      $(this).hide(300)
  )

show_and_hide_phrases = (e) ->
  $('input[type=checkbox]', e).click((e) ->
    tags = checked_tags()
    set_phrase_visibility(tags)
  )
