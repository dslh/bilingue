current = correct = 0
questions = null

$ ->
  meta = $('meta#questions')
  if meta.length > 0
    questions = $.parseJSON meta.attr('data-questions')
    enableQuiz()

enableQuiz = ->
  showNextQuestion()
  $('#answer').keypress((e) ->
    return if current == null or $(this).val() == ''

    if event.which == 13
      event.preventDefault()

      onQuestionAnswered()
      keepScore()
      showNextQuestion()
  )

currentQuestion = ->
  questions[current][0]

currentAnswers = ->
  questions[current][1]

isCorrect = (answer) ->
  answers = currentAnswers()

  if answers.constructor.name == 'String'
    if answer == answers
      return true

  for a in answers
    return true if a == answer

  return false

showNextQuestion = ->
  $('#answer').val('').focus()

  if current == questions.length
    current = null
    $('#question').text('All done!')
    return

  $('#question').text(currentQuestion())

onQuestionAnswered = ->
  answer = $('#answer').val()
  output = '<dt>' + currentQuestion() + '</dt>'
  if isCorrect answer
    correct++
  else
    output += '<dd class="wrong">' + answer + '</dd>'
  output += '<dd class="right">' + currentAnswers() + '</dd>'
  current++

  h = $('#history').append(output)
  hs = $('#historyScroll')
  if h.outerHeight() > hs.innerHeight()
    hs.animate({ scrollTop: (h.outerHeight() - hs.innerHeight() + 32) }, 750)

keepScore = ->
  $('#score').html(correct + ' / ' + current)
