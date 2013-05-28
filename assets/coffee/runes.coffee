# document.ondblclick = function(evt) 
#     if (window.getSelection)
#         window.getSelection().removeAllRanges();
#     else if (document.selection)
#         document.selection.empty();

$ ->
  $.extend $.fn.disableTextSelect = ->
    @each ->
    	$(this).mousedown ->
        	false

$(document).ready ->
	$(".collapse").collapse()

	# $("li span").disableTextSelect()
	$("ul.marks").on 'dblclick', (e) ->
		e.preventDefault()
		console.log 'toto'
		return false

	$("ul.marks li").draggable
		appendTo: "body"
		helper: "clone"
	$(".rune-page").droppable 
		drop: (event, ui) ->
			elem = ui.draggable[0].dataset
			type = elem.type
			name = elem.name
			console.log type
			switch type
				when "mark" then addMark(name)
				when "seal" then addSeal(name)
				when "glyph" then addGlyph(name)
				when "quintessence" then addQuintessence(name)

	addMark = (name) ->
		if $('.rune-page div[class*=mark][class*=empty]').length
			newElem = $('.rune-page div[class*=mark][class*=empty]').first().removeClass('empty')
			console.log("addMark")

	addSeal = (name) ->
		if $('.rune-page div[class*=seal]').find(".empty").length
			newElem = $('.rune-page div[class*=seal][class*=empty]').first().removeClass('empty')
			console.log("addSeal")

	addGlyph = (name) ->
		if $('.rune-page div[class*=glyph]').find(".empty").length
			newElem = $('.rune-page div[class*=glyph][class*=empty]').first().removeClass('empty')
			console.log("addGlyph")

	addQuintessence = (name) ->
		if $('.rune-page div[class*=quintessence]').find(".empty").length
			newElem = $('.rune-page div[class*=quintessence][class*=empty]').first().removeClass('empty')
			console.log("addQuintessence")