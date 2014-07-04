
coffee = require('coffee-script')
vm = require('vm')
esprima = require('esprima')


module.exports =

  activate: ->
    atom.workspaceView.command 'eval-selection:eval', => @eval_current_selection()

  deactivate: ->

  serialize: ->

  eval_current_selection: ->
    editor = atom.workspace.getActiveEditor()

    code = editor.getSelectedText() or editor.getText()

    if @valid_js(code)
      console.log(vm.runInThisContext(code))
    else
      console.log(vm.runInThisContext(coffee.compile(code, bare: true)))

  valid_js: (code) ->
    try
      syntax = esprima.parse(code, tolerant: true)
      return syntax.errors.length == 0
    catch
      return false
