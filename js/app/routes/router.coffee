app = window.app

Router = Backbone.Router.extend
    # Register routes
    routes: {
      'folder/:id': 'folder'
      'note/:id': 'note'
      '': 'all',
      'search': 'search'
    }

    # Show notes of selected folder
    folder: (folderId) ->
      folderNotes = app.Collection.Folders.get(folderId).rel('notes')
      app.AppEvent.trigger 'hide:notes'
      note.view.show() for note  in folderNotes if folderNotes?

    # Show note
    note: (noteId) ->
      app.AppEvent.trigger 'hide:notes'
      app.Collection.Notes.get(noteId).view?.showFull()

    # Show all notes
    all: ->
      app.AppEvent.trigger 'show:notes'

    search: ->


app.Router = new Router
Backbone.history.start()