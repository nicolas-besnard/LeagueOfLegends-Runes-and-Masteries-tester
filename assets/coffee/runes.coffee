$(document).ready ->
	#console.log document.URL.split("#")[1]
	
	#
	# Add mark to rune page
	# Accept both right-click, double-click, & drag"n"drop
	#

	$("ul.mark li, ul.seal li, ul.glyph li, ul.quintessence li")
		.draggable
			appendTo: "body"
			helper: "clone"
		.on "dblclick", ->
			elem = $(@)[0].dataset
			type = $(@).parent().attr("class")
			image = elem.img
			addRune(type, image)
		.on "mousedown", (e) ->
			if e.button == 2
				elem = $(@)[0].dataset
				type = $(@).parent().attr("class")
				attribut = elem.attribut
				value = elem.value
				image = elem.img
				addRune(type, image, attribut, value)

	#
	# Make rune page droppable
	#

	$(".rune-page").droppable 
		drop: (event, ui) ->
			elem = ui.draggable[0].dataset
			type = $(ui.draggable[0]).parent().attr("class") # get type
			image = elem.img
			addRune(type, image)

	#
	# Disable right-click context menu on rune page
	#

	$(".rune-page, ul.mark li, ul.seal li, ul.glyph li, ul.quintessence li").bind "contextmenu", ->
		false

	#
	# Delete rune from rune page
	# Accept both right-click & double-click
	#

	$(".rune-page div[class*=mark], .rune-page div[class*=seal], .rune-page div[class*=glyph], .rune-page div[class*=quintessence]")
		.on "mousedown", (e) ->
			if e.button == 2
				removeRune($(@))
		.on "dblclick", ->
			removeRune($(@))
			


	#
	# Clear rune page and statistics
	#

	$(".clear-page").on "click", ->
		$(".rune-page div[class*=mark], .rune-page div[class*=seal], .rune-page div[class*=glyph], .rune-page div[class*=quintessence]")
			.addClass("empty")
			.children().removeAttr("class")
		$(".statistiques").empty();
			

	#
	# Remove rune from rune page
	#

	removeRune = (elem) ->
		attribut = elem.children()[0].dataset["attribut"]
		attributValue = elem.children()[0].dataset["value"]
		oldValue = $(".statistiques div[data-attribut=\"#{attribut}\"]").children().first().html()
		newVal = parseFloat(oldValue) - parseFloat(attributValue)
		elem.children().removeAttr("class")
		elem.children().removeAttr("data-attribut")
		elem.children().removeAttr("data-value")
		elem.addClass("empty")

		if newVal == 0
			$(".statistiques div[data-attribut=\"#{attribut}\"]").remove()
		else
			$(".statistiques div[data-attribut=\"#{attribut}\"]").children().first().html("").html(newVal.toFixed(2))

	#
	# Add rune to rune page
	#

	addRune = (type, image, attribut, value) ->
		if $(".rune-page div[class*=#{type}][class*=empty]").length
			newElem = $(".rune-page div[class*=#{type}][class*=empty]").first() # get first available elem
			newElem
				.removeClass("empty")
				.children()
				.addClass("icn-#{image}")
				.attr("data-attribut", attribut)
				.attr("data-value", value)
			if $(".statistiques div[data-attribut=\"#{attribut}\"]").length
				oldValue = parseFloat($(".statistiques div[data-attribut=\"#{attribut}\"]").children().first().html())
				newVal = oldValue + parseFloat(value)
				$(".statistiques div[data-attribut=\"#{attribut}\"]").children().first().html("").html(newVal.toFixed(2))
			else	
				$("<div data-attribut=\"#{attribut}\">+<span>#{value}</span> <span>#{attribut}</span>").appendTo(".statistiques")