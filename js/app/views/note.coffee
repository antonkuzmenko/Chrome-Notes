app = window.app

app.View.Note = Backbone.View.extend
  className: 'row-fluid'

  $notesWrapper: $ '#notes'

  Templates:
    noteItem: app.Template.Note.noteItem

  initialize: ->
    @model.view = @
    @render().$el.appendTo @$notesWrapper
    @listenEvents()

  listenEvents: ->
    @listenTo @model, 'change:title change:body', @render
    @listenTo @model, 'remove', @remove
    @

  render: ->
    @$el.html @Templates.noteItem @model.toJSON()
    @