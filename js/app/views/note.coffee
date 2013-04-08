app = @app

app.View.Note = Backbone.View.extend
  className: 'row-fluid'

  $notesWrapper: $ '#notes'

  templates:
    noteItem: _.templates $('#note-item').html()

  initialize: ->
    @model.view = @
    @render().$el.appendTo @$notesWrapper
    @listenEvents()

  listenEvents: ->
    @listenTo @model, 'change:title change:body', @render
    @listenTo @model, 'remove', @remove
    @

  render: ->
    @$el.html @templates.noteItem @model.toJSON()
    @