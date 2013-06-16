# Создание неймспейсов
window.app =
  Model: {}
  Collection: {}
  View: {}
  Iterator: {}
  Template:
    Folder: {}
    Note: {}
  AppEvent: _.extend {}, Backbone.Events

# Фабрика итераторов.
iterator = do ->
  ->
    i = 0
    next: -> ++i
    get: -> i
    set: (newI) -> i = newI

# Отдельный итератор для папок и заметок.
window.app.Iterator.folder = iterator()
window.app.Iterator.note = iterator()

# Добавляем в сериализованную модель id
Backbone.Model::toJSON = ->
  _.extend {}, _.clone(@attributes), id: @id ? @cid

# Внедряем Chromes local storage в Backbone,
# делая storage местом хранения заметок и папок.
Backbone.sync = (method, model, options) ->
  modelId = "#{model.type}-#{model.id}"
  id = model.id
  storage = chrome.storage.local

  switch method
# Создание, обновление записи
    when 'create', 'update', 'patch'
# Сохранение модели.
      data = {}
      data[modelId] = options.attrs ? model.toJSON options
      storage.set data, ->
        errorMsg = chrome.runtime.lastError?.message
# Notify about occured error.
        if errorMsg?
          options.error errorMsg
        else
# Сообщить о успешно проделанной операции.
          options.success data[modelId]
# Сохранить id модели.
          storage.get model.type, (identifiers) ->
            identifiers[model.type] = [] if not identifiers[model.type]?
            ids = identifiers[model.type]

            if model.id not in ids
              ids.push model.id
              storage.set identifiers

# Удаление записи
    when 'delete'
# Удаение модели.
      storage.remove modelId, ->
        errorMsg = chrome.runtime.lastError?.message

        if errorMsg?
# Сообщить об ошибке.
          options.error errorMsg
        else
# Сообщить о успешно проделанной операции.
          options.success 'ok';
# Удалить id модели.
          storage.get model.type, (identifiers) ->
            ids = identifiers[model.type]
            deletedIndex = ids.indexOf id

            if deletedIndex isnt -1
              ids.splice deletedIndex, 1
              storage.set identifiers

    when 'read'
# Выборка id-шников
      storage.get model.type, (modelIds) ->
        errorMsg = chrome.runtime.lastError?.message

        if errorMsg?
# Сообщить об ошибке.
          options.error errorMsg
        else
# Сообщить о успешно проделанной операции.
          if _.isEmpty modelIds then return

          models = []
          modelsLen = modelIds[model.type].length
          for id in modelIds[model.type]
            do (id) ->
              storage.get model.type + '-' + id, (data) ->
                models.push(data[model.type + '-' + id])
# Передаем модели
                if modelsLen is models.length
                  options.success models

          return

# Запускаем событие request, для корректной работы Backbone
  model.trigger 'request', model, {}, options
  null
