Worker = Backbone.Model.extend
  defaults:
    name: 'Default'
    age: 20
    dossier: 'Default'

Crew = Backbone.Collection.extend model : Worker

Vasya = new Worker
  name: "Vasya"
  age: 20
  dossier: "Tupovat"

Petya = new Worker
  name: "Petya"
  age: 30
  dossier: "Serednya4ok"

Misha = new Worker
  name: "Misha"
  age: 40
  dossier: "Genius"

pool = [Vasya, Petya, Misha]

Crowd = new Crew
Crowd.add pool

WorkerView = Backbone.View.extend
  tagName: "div"
  className: "Worker"
  template: _.template $('#worker-template').html()
  render: -> $(@el).html(@template(@model))

WorkersView = Backbone.View.extend
  el: $("#myapp")
  tagName: "div"
  className: "Workers"
  initialize : -> 
    @_searchResults = []
    input = $("#field-search").val().toLowerCase()
    @collection.each (Worker) =>
      if Worker.attributes.name.toLowerCase().search(input) != -1 
        @_searchResults.push new WorkerView model : Worker
  render: -> 
    $(@el).empty()
    _(@_searchResults).each (dv) => 
      $(@el).append dv.render()
    if (@_searchResults).length == 0 
      $("#myapp").html("<p> No such a Worker <p>")
    
SeachView = Backbone.View.extend
  el: $("#mysearch")
  tagName: "div"   
  template: _.template $('#search-template').html()
  render: -> $(@el).html(@template) 
  initialize : -> @render()
  events:
    "click #search-button": "searchOnClick"
    "keypress #field-search": "searchOnEnter"
  searchOnClick: ->
    $("#myapp").empty()
    Va = new WorkersView collection: Crowd
    Va.render()
  
  searchOnEnter: (e) -> @searchOnClick()  if e.keyCode is 13

s = new SeachView;












