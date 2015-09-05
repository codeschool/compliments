# -------------------------------------
#   Document Ready
# -------------------------------------

jQuery ($) ->

  # ----- Uphearts ----- #

  $('.js-reaction-toggle').on 'click', (e) ->
    e.preventDefault()

    link = $(e.currentTarget)
    url = link.data('url')
    method = if link.hasClass('is-reacted') then 'DELETE' else 'POST'
    count = link.find('.js-reaction-count')

    $.ajax url,
      method: method
      success: (data) ->
        if data.count == 0
          link.remove()
        else
          count.text(data.count)
          link.toggleClass('is-reacted')
      error: (data) ->
        alert(data.responseJSON.errors)
