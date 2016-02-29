# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
a = 5
b = 10 if a > 5
# $ -> alert('hey')
# @ sign becomes 'this'
# $ ->
#   $(document).on "click",  ->
#     alert("hey")

$ ->
  $(document).hover ->
    $("#hoho").addClass("jojo");

$ ->
  $(".btn").click ->
    $(@).toggleClass("btn-danger")

capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

titleize = (string) ->
  words = string.split(" ");
  qords = words.map (word) -> capitalize(word)
  qords.join(" ")

$ ->
  $("#title").on "keyup", ->
    text = $(@).val()
    $("#output").html(titleize(text));

  # $("form").on("submit", function() {
  #       console.log("form submitted");
  #     });
