# *************************************
#
#   Toggle Emoji Reactions
#   -> Toggle emoji reaction
#
# *************************************
#

# @param $trigger       { jQuery object }
# @param filterNode     { string }
# @param inputClass     { string }
# @param reactionClass  { string }
# @param dataAttrUrl    { string }
#
# *************************************

@Compliments.ToggleEmojiReaction = do ->

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
      $toggle       : $( '.js-reaction-toggle' )
      toggleNode    : '.js-reaction-toggle'
      countNode     : '.js-reaction-count'
      reactionClass : 'is-reacted'
      dataAttrUrl   : 'url'
    , options

    _setEventHandlers()

  # -------------------------------------
  #   Set Event Handlers
  # -------------------------------------

  _setEventHandlers = ->
    $( document ).on 'click', _settings.toggleNode, ( event ) ->
      event.preventDefault()

      _$element = $(@)

      _toggleReaction().success ( data ) ->
        new_element = $(data)

        if new_element.children(_settings.countNode).text() == "0"
          _$element.remove()
        else
          _$element.replaceWith( data )

      .error ( data ) ->
        alert( data.responseJSON.errors )

  # -------------------------------------
  #   Add reaction
  # -------------------------------------

  _toggleReaction = ->
    url = _$element.data( _settings.dataAttrUrl )
    method = if _$element.hasClass( _settings.reactionClass ) then 'DELETE' else 'POST'
    data = { emoji: _$element.data('emoji') }

    $.ajax url,
      method: method
      data: data

  # -------------------------------------
  #   Public Methods
  # -------------------------------------

  init : init

# -------------------------------------
#   Usage
# -------------------------------------
#
# Compliments.ToggleEmojiReaction.init()
#
