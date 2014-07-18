
coffee = require('coffee-script')
vm = require('vm')
esprima = require('esprima')
remote = require('remote') # no clue what 'remote' really is, but lets use it!

module.exports =

  activate: ->
    atom.workspaceView.command 'eval-selection:eval', => @eval_current_selection()

  deactivate: ->

  serialize: ->

  eval_current_selection: ->
    remote.getCurrentWindow().openDevTools()
    editor = atom.workspace.getActiveEditor()

    code = editor.getSelectedText() or editor.lineForScreenRow(editor.getCursorScreenRow()).text

    if @valid_js(code)
      console.log(vm.runInThisContext(code))
    else
      console.log(vm.runInThisContext(coffee.compile(code, bare: true)))

  valid_js: (code) ->
    try
      syntax = esprima.parse(code, tolerant: true)
      return syntax.errors.length == 0
    catch e
      return false
