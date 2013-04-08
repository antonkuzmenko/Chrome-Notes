Folder = Backbone.Model.extend
  defaults: ->
    title: ''
    notes: {}

  initialize: ->
    @cid ?= app.Iterator.folder.next()

    new app.View.Folder model: @
    @listenEvents()

  listenEvents: ->
    @on 'remove', @destroy, @
    @on 'remove', @clear, @

Folder::hasMany = ->
  notes:
    collection: app.Collection.Notes
    id: 'folder_id'
    filter: (note) -> +note.get('folder_id') is +@id