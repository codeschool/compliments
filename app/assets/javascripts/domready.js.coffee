# -------------------------------------
#   Document Ready
# -------------------------------------

jQuery ($) ->

  # ----- Uphearts ----- #

  $('.js-upheart-toggle').on 'click', (e) ->
    e.preventDefault()

    link = $(e.currentTarget)
    url = link.data('upheart-url')
    method = if link.hasClass('is-uphearted') then 'DELETE' else 'POST'
    count = link.find('.js-upheart-count')

    $.ajax url,
      method: method
      success: (data) ->
        count.text(data.upheart_count)
        link.toggleClass('is-uphearted')
      error: (data) ->
        alert(data.responseJSON.errors)
