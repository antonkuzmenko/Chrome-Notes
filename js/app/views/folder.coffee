app = window.app

app.View.Folder = Backbone.View.extend
  className: 'row-fluid'
  events:
    'keyup input': 'save'
    'blur input': 'save'
    'click a.edit-link': 'edit'
    'click button.delete': 'destroy'

  $foldersWrapper: $ '#folders'

  Templates:
    listItem: app.Template.Folder.listItem
    formConfirm: app.Template.Folder.formConfirm

  initialize: ->
    @$input = null
    @model.view = @
    @render().$el.appendTo @$foldersWrapper
    @listenEvents()

  listenEvents: ->
    @listenTo @model, 'change:title', @render
    @listenTo @model, 'remove', @remove
    @

  #Save folder title and show link instead of input.
  save: (event) ->
    if event.type is 'keyup' and event.which isnt 13 then return

    @$el.removeClass 'edit'
    @model.set title: event.target.value

    @model.save() if @model.hasChanged 'title'

  #Show input instead of link.
  edit: (event) ->
    event.preventDefault()

    @$el.addClass 'edit'
    @$input.focus()

  destroy: -> @model.collection.remove @model

  render: ->
    @$el.html @Templates.listItem(@model.toJSON()) + @Templates.formConfirm @model.toJSON()

    @$input.remove() if @$input?
    @$input = @$ 'input'
    @

  remove: () ->
    @$input.remove()

    delete @options.model
    delete @model.view
    delete @model

    Backbone.View::remove.apply @, arguments
    @
