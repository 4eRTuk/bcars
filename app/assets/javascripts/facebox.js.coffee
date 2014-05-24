# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('a[rel*=facebox]').facebox()

# facebox - make modal

#$(document).bind "loading.facebox", ->
 # $(document).unbind "keydown.facebox"
  #$("#facebox_overlay").unbind "click"