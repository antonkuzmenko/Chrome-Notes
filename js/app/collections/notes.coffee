app = window.app

Notes = Backbone.Collection.extend
  model: app.Model.Note
  type: 'note'

  initialize: ->
    @on 'sync', (model, resp) ->
      if resp? and resp.length?
        app.Iterator.note.set _.max(resp, (note) -> note.id).id

    @fetch()

app.Collection.Notes = new Notes