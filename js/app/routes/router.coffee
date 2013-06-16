app = window.app

Router = Backbone.Router.extend
# Регистрация страниц
    routes: {
# Страница просмотра папки
      'folder/:id': 'folder'
# Страница просмотра заметки
      'note/:id': 'note'
# Просмотр всех заметок
      '': 'all',
# Поиск по заметкам
      'search': 'search'
    }

# Показывает все заметки, которые находятся в выбранной папке
    folder: (folderId) ->
# Найти все заметки из папки
      folderNotes = app.Collection.Folders.get(folderId).rel('notes')
# Спрятать все заметки
      app.AppEvent.trigger 'hide:notes'
# Показать заметки только из выбранной папки
      note.view.show() for note in folderNotes if folderNotes?

# Показывает выбранную заметку
    note: (noteId) ->
# Спрятать все заметки
      app.AppEvent.trigger 'hide:notes'
# Показать выбранную заметку
      app.Collection.Notes.get(noteId).view?.showFull()

# Показать все заметки
    all: ->
      app.AppEvent.trigger 'show:notes'
# Заглушка для поиска.
    search: ->

# Запускаем роутинг
app.Router = new Router
Backbone.history.start()