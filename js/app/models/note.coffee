app = window.app

Note = Backbone.Model.extend
  defaults: ->
    title: ''
    body: ''

  type: 'note'

  initialize: ->
    @id ?= app.Iterator.note.next()
    new app.View.Note model: @
    @listenEvents()

  listenEvents: ->
    @on 'remove', ->
      @destroy()
      @clear()
    , @

Note::belongsTo = -> folder: app.Collection.Folders

app.Model.Note = Note