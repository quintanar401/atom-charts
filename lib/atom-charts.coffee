{CompositeDisposable} = require 'atom'

testData = ->
  data:(-> [new Date(1409518800000+86400000*i),Math.sin(i/10),Math.cos(i/10)] for i in [1..100])()
  options:
    legend: 'always'
    title: 'NYC vs. SF'
    labels: ["T","A","B"]
    ylabel: 'Temperature (F)'

module.exports = AtomCharts =
  activate: (state) ->
    # setTimeout (=> @showInPane {title: 'myGraph'}, test), 1500

  deactivate: ->
    @panelView?.destroy()
    @panelView = null

  showInPanel: (chartOpts, libOpts) ->
    unless @panelView
      view = require './panel-view'
      @panelView = new view

    @panelView.setOpts chartOpts, libOpts
    return @panelView.showPanel()

  showInPane: (chartOpts, libOpts) ->
    return null unless chartOpts.title
    if !pane = atom.workspace.paneForURI('atomcharts://'+chartOpts.title)
      view = require './panel-view'
      currPane = atom.workspace.getActivePane()
      if currPane.parent.orientation is 'vertical'
        pane = currPane.parent.getPanes()
        pane = pane[pane.length-1]
      else
        pane = currPane.splitDown()
      return null unless pane
      paneView = new view()
      paneView.setOpts chartOpts, libOpts
      pane.activateItem pane.addItem paneView
      paneView.showPanel()

  provideService: ->
    showInPanel: (c,l) => @showInPanel c,l
    showInPane : (c,l) => @showInPane  c,l
    # test2: (t) => @test2 t
    # test1: => @test()

  # test: -> @showInPanel {}, testData()

  # test2: (title) -> @showInPane {title: title}, testData()
