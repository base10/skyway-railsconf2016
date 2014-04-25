#//= require jquery
#//= require jquery_ujs
#//= require turbolinks
#//= require_tree .

ready = ->
  if highlightElement = $("[data-highlight]")
    highlight = highlightElement.data("highlight")
    console.log highlight

    highlightElement.find("em, h3").each ->
      if $(this).text().match(new RegExp(highlight, "i"))
        $(this).addClass("highlight")

  $('#js-mobile-menu').on 'click', (e) ->
    e.preventDefault()
    menu = $('#navigation-menu')
    menu.slideToggle ->
      if menu.is(':hidden')
        menu.removeAttr('style')

$(document).ready(ready)
$(document).on('page:load', ready)
