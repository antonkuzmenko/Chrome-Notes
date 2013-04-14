app = window.app

Notes = Backbone.Collection.extend
  model: app.Model.Note
  type: 'note'

  initialize: -> @fetch()

app.Collection.Notes = new Notes