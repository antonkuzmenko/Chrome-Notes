app = @app

app.Notes = Backbone.Collection.extend
  model: app.Model.Note
  localStorage: new Backbone.LocalStorage 'notes'

  initialize: -> @fetch()