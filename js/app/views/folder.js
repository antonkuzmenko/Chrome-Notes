// Generated by CoffeeScript 1.6.2
(function() {
  var app;

  app = this.app;

  app.View.Folder = Backbone.View.extend({
    className: 'row-fluid'
  }, events({
    'keyup input': 'save',
    'blur input': 'save',
    'click a.edit-link': 'edit',
    'click button.delete': 'destroy'
  }), {
    $foldersWrapper: $('#folders'),
    templates: {
      listItem: _.templates($('#folder-item').html()),
      formConfirm: _.templates($('#form-folder-confirm').html())
    },
    initialize: function() {
      this.$input = null;
      this.model.view = this;
      this.render().$el.appendTo(this.$foldersWrapper);
      this.listenEvents();
      return this;
    },
    listenEvents: function() {
      this.listenTo(this.model, 'change:title', this.render);
      this.listenTo(this.model, 'remove', this.remove);
      return this;
    },
    save: function(event) {
      if (event.type === 'keyup' && event.which !== 13) {
        return;
      }
      this.$el.removeClass('edit');
      this.model.set({
        title: event.target.value
      });
      if (this.model.hasChanged('title')) {
        return this.model.save();
      }
    },
    edit: function(event) {
      event.preventDefault();
      this.$el.addClass('edit');
      return this.$input.focus();
    },
    destroy: function() {
      return this.model.collection.remove(this.model);
    },
    render: function() {
      this.$el.html(this.templates.listItem(this.model.toJSON() + this.$el.html(this.templates.formConfirm(this.model.toJSON()))));
      if (this.$input != null) {
        this.$input.remove();
      }
      this.$input = this.$('input');
      return this;
    }
  }, remove(function() {
    Backbone.View.prototype.remove.apply(this, arguments);
    this.$input.remove();
    delete this.options.model;
    delete this.model.view;
    delete this.model;
    return this;
  }));

}).call(this);
