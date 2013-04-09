app = window.app

Notes = Backbone.Collection.extend
  model: app.Model.Note
#  localStorage: new Backbone.LocalStorage 'notes'

  initialize: -> @fetch()

app.Collection.Notes = new Notes