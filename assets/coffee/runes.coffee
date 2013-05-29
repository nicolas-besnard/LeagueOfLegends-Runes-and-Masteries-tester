$(document).ready ->

	#
	# Make rune collapsable
	#

	$(".collapse").collapse()

	#
	# Add mark to rune page
	# Accept both right-click, double-click, & drag'n'drop
	#

	$("ul.mark li, ul.seal li, ul.glyph li, ul.quintessence li")
		.draggable
			appendTo: "body"
			helper: "clone"
		.on "dblclick", ->
			elem = $(@)[0].dataset
			type = $(@).parent().attr('class')
			image = elem.img
			addRune(type, image)
		.on "mousedown", (e) ->
			if e.button == 2
				elem = $(@)[0].dataset
				type = $(@).parent().attr('class')
				image = elem.img
				addRune(type, image)

	#
	# Make rune page droppable
	#

	$(".rune-page").droppable 
		drop: (event, ui) ->
			elem = ui.draggable[0].dataset
			type = $(ui.draggable[0]).parent().attr('class') # get type
			image = elem.img
			addRune(type, image)

	#
	# Disable right-click context menu on rune page
	#

	$('.rune-page, ul.mark li, ul.seal li, ul.glyph li, ul.quintessence li').bind "contextmenu", ->
		false

	#
	# Delete rune from rune page
	# Accept both right-click & double-click
	#

	$('.rune-page div[class*=mark], .rune-page div[class*=seal], .rune-page div[class*=glyph]')
		.on "mousedown", (e) ->
			if e.button == 2
				$(@).children().removeAttr('class')
				$(@).addClass('empty')
		.on "dblclick", ->
			$(@).children().removeAttr('class')
			$(@).addClass('empty')

	#
	# Add rune to page rune
	#

	addRune = (type, image) ->
		if $(".rune-page div[class*=#{type}][class*=empty]").length
			newElem = $(".rune-page div[class*=#{type}][class*=empty]").first() # get first available elem
			newElem
				.removeClass('empty')
				.children()
				.addClass("icn-#{image}")