// Generated by CoffeeScript 1.6.2
(function() {
  var app;

  app = this.app;

  app.Notes = Backbone.Collection.extend({
    model: app.Model.Note,
    localStorage: new Backbone.LocalStorage('notes'),
    initialize: function() {
      return this.fetch();
    }
  });

}).call(this);