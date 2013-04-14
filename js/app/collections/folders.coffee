app = window.app

Folders = Backbone.Collection.extend
  model: app.Model.Folder
  type: 'folder'

  initialize: ->
    @on 'all', (event) -> console.log event, 'Folder event'
    @fetch()

app.Collection.Folders = new Folders