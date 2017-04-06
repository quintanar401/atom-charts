{CompositeDisposable} = require 'atom'

class ChartsPanelView extends HTMLElement
  destroy: ->
    @subscriptions?.dispose()
    @panel?.hide()
    @panel?.destroy()
    @subscriptions = @panel = @container = @chartOpts = @libOpts = @graph = null
    @remove()

  createdCallback: ->
    @classList.add 'atom-charts-panel-view'
    @container = document.createElement 'div'
    @container.classList.add 'atom-charts-panel-container'
    @style.overflow = 'auto'
    @appendChild @container

  getTitle: -> @chartOpts.title or "unknown"

  getURI: -> "atomcharts://"+@getTitle()

  setOpts: (@chartOpts,@libOpts) ->

  showPanel: ->
    unless @chartOpts.title
      unless @panel
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace',
          'core:cancel': => @panel?.hide()
          'core:close': => @panel?.hide()
        @panel = atom.workspace.addTopPanel(item: this, priority: 0, visible: false)
      @panel.show()

    @container.innerHTML = ''
    gdiv = document.createElement 'div'
    gdiv.classList.add 'atom-charts-panel-graph'
    @container.appendChild gdiv
    Dygraphs = require 'dygraphs'
    @graph = new Dygraphs gdiv, @libOpts.data, @libOpts.options
    this

  getPanel: -> @panel

  getGraph: -> @graph

  getContainer: -> @container

module.exports = document.registerElement('atom-charts-panel-view', prototype: ChartsPanelView.prototype)
