# *************************************
#
#   Add Emoji Reactions
#   -> Add emoji reaction
#
# *************************************
#

# @param $trigger       { jQuery object }
# @param $input         { jQuery object }
# @param inputNode      { string }
# @param filterNode     { string }
# @param inputClass     { string }
# @param filterClass    { string }
#
# *************************************

@Compliments.AddEmojiReaction = do ->

  # -------------------------------------
  #   Private Variables
  # -------------------------------------

  _settings = {}
  _$element = null

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init = ( options ) ->
    _settings = $.extend
      $trigger       : $( '.js-reaction-trigger' )
      $input         : $( '.js-reaction-input' )
      inputNode      : '.js-reaction-input'
      filterNode     : '.js-reaction-filter'
      inputClass     : 'js-reaction-input'
      filterClass    : 'js-reaction-filter'
    , options

    _setEventHandlers()

  # -------------------------------------
  #   Set Event Handlers
  # -------------------------------------

  _setEventHandlers = ->
    _settings.$trigger.on 'click', ( event ) ->
      event.preventDefault()
      _$element = $(@)
      _showSearch()

    $( document ).on 'keyup', _settings.inputNode, ( event ) ->
      event.preventDefault()

      _$element = $(@)

      if event.keyCode == 27
        _removeSearch()
        return

      else if event.keyCode == 13
        _addReaction().success ( data ) ->
          emoji = _$element.find("[data-emoji=#{data.emoji}]")[0]

          if emoji?
            emoji.replaceWith(data)
          else
            _$element.parent().before("<li class='list-item'>#{data}</li>")

          _removeSearch()
        .error ( data ) ->
          _removeSearch()
          alert( data.responseJSON.errors )

        return

      _filterEmojis()

  # -------------------------------------
  #   Show emoji search
  # -------------------------------------

  _showSearch = ->
    _$element.after("<input type='text' class='#{_settings.inputClass}'><ul class='#{_settings.filterClass}'></ul>")
    _$element.next().focus()

  # -------------------------------------
  #   Remove emoji search
  # -------------------------------------

  _removeSearch = ->
    _$element.next().remove()
    _$element.remove()

  # -------------------------------------
  #   Add reaction
  # -------------------------------------

  _addReaction = ->
    $.ajax
      type       : 'POST'
      url        : _$element.prev().data('url')
      data       :
        emoji    : _$element.next().children().first().data('emoji')

  # -------------------------------------
  #   Filter emojis
  # -------------------------------------

  _filterEmojis = ->
    $filterList = _$element.next(_settings.filterNode)
    searchText = _$element.val()

    if searchText == ""
      $filterList.html ""
    else
      emojis = (emoji for emoji of Compliments.emojis when emoji.includes(searchText))[0..9]
      $filterList.html ("<li data-emoji='#{emoji}'>#{Compliments.emojis[emoji]} (#{emoji})</li>" for emoji in emojis)

  # -------------------------------------
  #   Public Methods
  # -------------------------------------

  init : init

# -------------------------------------
#   Usage
# -------------------------------------
#
# Compliments.AddEmojiReaction.init()
#
