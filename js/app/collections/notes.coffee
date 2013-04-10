app = window.app

Notes = Backbone.Collection.extend
  model: app.Model.Note

#  initialize: -> @fetch()

app.Collection.Notes = new Notes