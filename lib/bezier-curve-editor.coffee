{Disposable} = require 'event-kit'
BezierCurveEditorView = require './bezier-curve-editor-view'

module.exports=
  view: null
  match: null

  activate: ->
    atom.commands.add 'atom-workspace',
      'bezier-curve-editor:open': => @open true

    atom.contextMenu.add '.editor': [{
      label: 'Edit Bezier Curve',
      command: 'bezier-curve-editor:open',
      shouldDisplay: (event) =>
        return true if @match = @getMatchAtCursor()
    }]

    @view = new BezierCurveEditorView

    @view.cancelButton.on 'click', => @view.close()
    @view.validateButton.on 'click', =>
      spline = @view.getSpline()
      @replaceMatch(spline)
      @view.close()

    @subscription = new Disposable =>
      @view.cancelButton.off 'click'
      @view.validateButton.off 'click'

  deactivate: ->
    @view.destroy()
    @subscription.dispose()

  getMatchAtCursor: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    line = editor.getLastCursor().getCurrentBufferLine()
    cursorBuffer = editor.getCursorBufferPosition()
    cursorRow = cursorBuffer.row
    cursorColumn = cursorBuffer.column

    matches = @matchesOnLine(line, cursorRow)
    matchAtPos = @matchAtPosition cursorColumn, matches

    return matchAtPos

  matchesOnLine: (line, cursorRow) ->
    float = '(\\d+|\\d?\\.\\d+)'
    regex = ///
      cubic-bezier\s*
      \(\s*
        (#{float})
        \s*,\s*
        (-?#{float})
        \s*,\s*
        (#{float})
        \s*,\s*
        (-?#{float})
      \s*\)
    ///g

    filteredMatches = []
    matches = line.match regex

    return unless matches?

    for match in matches
      continue if (index = line.indexOf match) is -1

      filteredMatches.push
        match: match
        regexMatch: match.match RegExp regex.source, 'i'
        index: index
        end: index + match.length
        row: cursorRow

      line = line.replace match, (Array match.length + 1).join ' '

    return unless filteredMatches.length
    filteredMatches

  matchAtPosition: (column, matches) ->
    return unless column and matches

    for match in matches
      if match.index <= column and match.end >= column
        matchResults = match
        break

    return matchResults

  selectMatch: ->
    editor = atom.workspace.getActiveTextEditor()

    editor.clearSelections()
    editor.addSelectionForBufferRange
      start:
        column: @match.index
        row: @match.row
      end:
        column: @match.end
        row: @match.row

  replaceMatch: (spline) ->
    return unless @match?

    editor = atom.workspace.getActiveEditor()
    splineCSS = @getSplineCSS(spline)
    editor.replaceSelectedText null, -> splineCSS

    editor.clearSelections()
    editor.addSelectionForBufferRange
      start:
        column: @match.index
        row: @match.row
      end:
        column: @match.index + splineCSS.length
        row: @match.row

  getSplineCSS: (spline) ->
    precision = 100000
    spline = spline.map (n) -> Math.floor(n * precision) / precision

    "cubic-bezier(#{ spline.join ', ' })"

  open: (getMatch = false) ->

    @match = @getMatchAtCursor() if getMatch

    return unless @match?

    [m, a1, _, a2, _, a3, _, a4] = @match.regexMatch
    [a1, a2, a3, a4] = [
      parseFloat a1
      parseFloat a2
      parseFloat a3
      parseFloat a4
    ]

    @view.setSpline(a1, a2, a3, a4)
    @view.renderSpline()
    @view.open()

    @selectMatch()
