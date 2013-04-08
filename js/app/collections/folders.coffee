app = @app

app.Folders = Backbone.Collection.extend
  model: app.Model.Folder
  localStorage: new Backbone.LocalStorage 'folders'

  initialize: ->
    @on 'all', (event) -> console.log event, 'Folder event'
    @fetch()