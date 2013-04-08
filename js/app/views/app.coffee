app = @app

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

  templates:
    noteFoldersList: _.template("<% _.each(folders, function(folder, index) { %><option value=\"<%= folder.id %>\"><%= folder.title %></option><%= index %><% }); %>")



