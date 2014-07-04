{View} = require 'atom'

module.exports =
class evalSelectionView extends View
  @content: ->
    @div class: 'eval-selection overlay from-top', =>
      @div "The evalSelection package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    #atom.workspaceView.command "eval-selection:tuggle-muggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "evalSelectionView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
