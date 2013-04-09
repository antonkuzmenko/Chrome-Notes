app = window.app

app.View.App = Backbone.View.extend
  Forms:
    Folder:
      $el: $ '#form-add-folder'
      $title: $ '#new-folder-title'

    Note:
      $el: $ '#form-add-note'
      $title: $ '#new-note-title'
      $body: $ '#new-note-body'
      $foldersList: $ '#new-note-folder'

  Templates:
    foldersSelectList: app.Template.Note.foldersSelectList

  initialize: ->
    @addFolder = _.bind @addFolder, this
    @addNote = _.bind @addNote, this

    @Forms.Folder.$el
      .on('hidden', @clearFolder)
      .on('shown', @focusFolderTitle)
      .on('click', '.add-folder', @addFolder)

    @Forms.Folder.$title.on 'keyup', @addFolder

    @Forms.Note.$el
      .on('hidden', @clearNote)
      .on('shown', @focusNoteTitle)
      .on('click', '.add-note', @addNote)

    @renderFoldersSelectList
    @listenEvents()

  listenEvents: ->
    @listenTo app.Collection.Folders, 'remove add change:title', @renderFoldersSelectList
    return

  addFolder: (event) ->
    if event.type is 'keyup' and event.which isnt 13 then return

    folder = new app.Model.Folder title: @Forms.Folder.$title.val()
    app.Collection.Folders.add folder
    folder.save()

    @Forms.Folder.$el.modal 'hide'

  focusFolderTitle: ->
    @Forms.Folder.$title.val ''

  clearFolder: ->
    @Forms.Folder.$title.val ''

  addNote: ->
    app.Collection.Notes.add
      title: @Forms.Note.$title.val()
      body: @Forms.Note.$body.val()
      folder_id: @Forms.Note.$foldersList.val()

    @Forms.Note.$el.modal 'hide'

  focusNoteTitle: ->
    @Forms.Note.$title.focus()

  clearNote: ->
    @Forms.Note.$title.val ''
    @Forms.Note.$body.val ''

  renderFoldersSelectList: ->
    folders = @Templates.foldersSelectList folders: app.Collection.Folders.toJSON()
    @Forms.Note.$foldersList.html folders
    @
