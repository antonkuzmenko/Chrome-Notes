app = @app

app.Model.Note = Backbone.Model.extend
  defaults: ->
    title: ''
    body: ''

  initialize: ->
    @id ?= app.Iterator.note.next()
    new app.View.Note model: @
    @listenEvents()

  listenEvents: ->
    @on 'all', (event) -> console.log event, 'Note event'
    @on 'remove', @destroy, @
    @on 'remove', @clear, @

app.Model::belongsTo = -> folder: app.Collection.Folders