app = window.app

app.View.Note = Backbone.View.extend
  className: 'row-fluid'

  events:
    'click .edit': 'renderForm'
    'click .delete': 'renderConfirmForm'

  $notesWrapper: $ '#notes'
  $noteForm: $ '#form-add-note'
  $confirmModalForm: $ '#form-note-confirm'
  form: document.note_form

  Templates:
    noteItem: app.Template.Note.noteItem
    noteForm: app.Template.Note.noteForm
    noteConfirmForm: app.Template.Note.confirmForm

  initialize: ->
    @save = _.bind @save, this
    @destroy = _.bind @destroy, this
    @model.view = @

    @render().$el.appendTo @$notesWrapper

    @$noteForm.on 'click', '.save-note', @save
    @$confirmModalForm.on('click', '.delete', @destroy);

    @listenEvents()

  listenEvents: ->
    @listenTo @model, 'change:title change:body', @render
    @listenTo @model, 'remove', @remove
    @

  destroy: (event) ->
    if +event.target.dataset.id isnt +@model.id then return

    @model.collection.remove @model
    @$confirmModalForm.modal 'hide'

  renderForm: ->
    @form.innerHTML = @Templates.noteForm _.extend {}, @model.toJSON(), folders: app.Collection.Folders.toJSON()

  renderConfirmForm: ->
    @$confirmModalForm.html( @Templates.noteConfirmForm @model.toJSON() );

  save: (event) ->
    if +event.target.dataset.id isnt +@model.id then return

    @model.save
      title: @form.title.value
      body: @form.body.value
      folder_id: @form.folder.value

    @$noteForm.modal 'hide'

  render: ->
    @$el.html @Templates.noteItem @model.toJSON()
    @