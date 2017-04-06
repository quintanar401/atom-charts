# atom-charts package

Atom interface for dygraphs library.

API:

```
"consumedServices": {
  "atom-charts": {
    "versions": {
      "^0.0.0": "consumeCharts"
    }
  }
```

Functions:

```
charts.showInPanel chartOpts, libOpts
charts.showInPane chartOpts, libOpts
```

where `showInPanel` will create a graph in the top panel and `showInPane` will split down if needed and add a tab with the graph.

`chartOpts` and `libOpts` are objects with options. `libOpts` should be dygraphs options like:
```
options:
  legend: 'always'
  title: 'NYC vs. SF'
  labels: ["T","A","B"]
  ylabel: 'Temperature (F)'
```

`chartOpts` may have the following settings:
* data - compatible with dygraphs `data` parameter - csv file, array of rows and etc.
* title - if `showInPane` is used then this will be used in tab's URI: 'atomcharts://`title`'. If the same title is used again then the tab's content will be changed, a new tab will be opened otherwise.

Both functions return `atom-charts-panel-view` HTML element that can be used to manipulate the graph. This element has additional properties:
* panel - top panel if available.
* graph - Dygraphs object.
* container - additional elements can be added before/after the graph into this container.
