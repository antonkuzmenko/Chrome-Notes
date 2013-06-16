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
    noteFull: app.Template.Note.full

  initialize: ->
    @save = _.bind @save, this
    @destroy = _.bind @destroy, this
    @model.view = @
    @viewType = 'list'

    @show()

    @$noteForm.on 'click', '.save-note', @save
    @$confirmModalForm.on 'click', '.delete', @destroy

    @listenEvents()

  listenEvents: ->
    @listenTo @model, 'change:title change:body', @renderListItem
    @listenTo @model, 'change:title change:body', @renderFull
    @listenTo @model, 'remove', @remove

    @listenTo app.AppEvent, 'hide:notes', @hide
    @listenTo app.AppEvent, 'show:notes', @show
    @

  destroy: (event) ->
    if +event.target.dataset.id isnt +@model.id then return

    @model.destroy()
    @$confirmModalForm.modal 'hide'
    @

  remove: ->
    delete @options.model
    delete @model.view
    delete @model

    @$noteForm.unbind 'click', @save
    @$confirmModalForm.unbind 'click', @destroy

    Backbone.View::remove.apply @, arguments

  hide: ->
    @$el.detach()

  show: ->
    @viewType = 'list'
    @renderListItem().$el.appendTo @$notesWrapper

  showFull: ->
    @viewType = 'full'
    @renderFull().$el.appendTo @$notesWrapper

  renderForm: ->
    @form.innerHTML = @Templates.noteForm _.extend {}, @model.toJSON(), folders: app.Collection.Folders.toJSON()

  renderConfirmForm: ->
    @$confirmModalForm.html( @Templates.noteConfirmForm @model.toJSON() )

  save: (event) ->
    if +event.target.dataset.id isnt +@model.id then return

    @model.save
      title: @form.title.value
      body: @form.body.value
      folder_id: @form.folder.value

    @$noteForm.modal 'hide'

  renderListItem: ->
    if @viewType is 'list' then @$el.html @Templates.noteItem @model.toJSON()
    @

  renderFull: ->
    if @viewType is 'full' then @$el.html @Templates.noteFull @model.toJSON()
    @