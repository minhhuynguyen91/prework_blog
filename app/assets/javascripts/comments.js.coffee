$(document).on "turbolinks:load", ->
	$('#comments-link').click ->
		$('#comments-section').toggle();