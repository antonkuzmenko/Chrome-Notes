// Generated by CoffeeScript 1.6.2
(function() {
  var Folder, app;

  app = window.app;

  Folder = Backbone.Model.extend({
    defaults: function() {
      return {
        title: '',
        notes: {}
      };
    },
    type: 'folder',
    initialize: function() {
      var _ref;

      if ((_ref = this.id) == null) {
        this.id = app.Iterator.folder.next();
      }
      new app.View.Folder({
        model: this
      });
      return this.listenEvents();
    },
    listenEvents: function() {
      return this.on('remove', function() {
        this.destroyNotes();
        this.destroy();
        return this.clear();
      }, this);
    },
    save: function() {
      var note, noteIds;

      noteIds = (function() {
        var _i, _len, _ref, _results;

        _ref = this.rel('notes');
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          note = _ref[_i];
          _results.push(note.id);
        }
        return _results;
      }).call(this);
      this.set('notes', noteIds);
      return Backbone.Model.prototype.save.apply(this, arguments);
    },
    destroyNotes: function() {
      var note, _i, _len, _ref, _results;

      _ref = this.rel('notes');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        note = _ref[_i];
        _results.push(note.collection.remove(note));
      }
      return _results;
    }
  });

  Folder.prototype.hasMany = function() {
    return {
      notes: {
        collection: app.Collection.Notes,
        id: 'folder_id',
        filter: function(note) {
          return +note.get('folder_id') === +this.id;
        }
      }
    };
  };

  app.Model.Folder = Folder;

}).call(this);
