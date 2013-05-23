app = window.app

app.View.App = Backbone.View.extend
  Forms:
    Folder:
      $el: $ '#form-add-folder'
      $title: $ '#new-folder-title'

    Note:
      $el: $ '#form-add-note'
      form: document.note_form
      $newButton: $ '#new-note'

  $searchField: $ '#search'

  Templates:
    noteForm: app.Template.Note.noteForm

  initialize: ->
    @addFolder = _.bind @addFolder, this
    @addNote = _.bind @addNote, this

    @focusFolderTitle = _.bind @focusFolderTitle, this
    @focusNoteTitle = _.bind @focusNoteTitle, this
    @renderNoteForm = _.bind @renderNoteForm, this
    @doSearch = _.bind @doSearch, this

    @clearFolder = _.bind @clearFolder, this

    @Forms.Folder.$el
      .on('hidden', @clearFolder)
      .on('shown', @focusFolderTitle)
      .on('click', '.add-folder', @addFolder)


    @Forms.Folder.$title.on 'keyup', @addFolder

    @Forms.Note.$el
      .on('shown', @focusNoteTitle)
      .on('click', '.add-note', @addNote)

    @Forms.Note.$newButton.on 'click', @renderNoteForm

    @Forms.Note.form.onsubmit = (event) -> event.preventDefault()

    @$searchField.on 'keyup', @doSearch


  addFolder: (event) ->
    if event.type is 'keyup' and event.which isnt 13 then return

    folder = new app.Model.Folder title: @Forms.Folder.$title.val()
    app.Collection.Folders.add folder
    folder.save()

    @Forms.Folder.$el.modal 'hide'

  focusFolderTitle: ->
    @Forms.Folder.$title.focus()

  clearFolder: ->
    @Forms.Folder.$title.val ''

  addNote: ->
    form = @Forms.Note.form

    note = new app.Model.Note
      title: form.title.value
      body: form.body.value
      folder_id: form.folder.value

    app.Collection.Notes.add note
    note.save()

    @Forms.Note.$el.modal 'hide'

  focusNoteTitle: ->
    @Forms.Note.form.title.focus()

  renderNoteForm: ->
    @Forms.Note.form.innerHTML = @Templates.noteForm
      title: ''
      body: ''
      folders: app.Collection.Folders.toJSON()
      folder_id: -1
      id: false

  doSearch: ->
    value = @$searchField.val()
    app.Router.navigate 'search', trigger: true

    if value is ''
      app.AppEvent.trigger 'show:notes'
      return
    else
      app.AppEvent.trigger 'hide:notes'
      searchedNotes = app.Collection.Notes.filter (note) ->
        !!note.get('title').match value or !!note.get('body').match value

      note.view.show() for note in searchedNotes
