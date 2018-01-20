
$(document).ready(function() {

	// setup star rating clickable
	$('.starRating').rateYo({
		starWidth: "40px",
		normalFill: "#A0A0A0",
		ratedFill: "rgb(243, 156, 18)",
		fullStar: true,
	})

	// setup star rating in review (readyOnly)
	$('.starReadOnly').rateYo({
		starWidth: "40px",
		normalFill: "#A0A0A0",
		ratedFill: "rgb(243, 156, 18)",
		fullStar: true,
		readOnly: true
	})

	// set the hidden input with the item rating to send to backend
	$('#submit_review').on('click', function() {
		var itemRating = $('.starRating').rateYo('rating')
		$('#rating_field').attr('value', itemRating);
	})

	// change the stock status based on the number of select options
	if ($('#quantity_select option').length === 0) {
		$('.stock_status').css('color', 'crimson');
	} else {
		$('.stock_status').css('color', 'lawngreen');
	}

	// check for quantity, if available then show the modal.
	// update the cartAmount before page refreshes for instant amount update
	// $('#addToCart').on('click', function(event) {
	// 	// stop refresh of page after post submission on form
	// 	event.preventDefault();
	// 	var quantity_value = $('.quantity_form select').val();
	// 	var item_id = $('.quantity_form #item_id').val();
	// 	if (quantity_value !== null) {
	// 		$.ajax({
	// 			type: "POST",
	// 			url: "/cart/add",
	// 			data: { id: item_id, quantity: quantity_value }
	// 		})
	// 		.done(function(result) {
	// 			result = JSON.parse(result)
	// 			if (result.message === "added to cart") {
	// 				$('#modalMessage').text(result.message);
	// 				$('#cartModal').modal('show');
	// 				$('#cartAmount').text(parseInt($('#cartAmount').text()) + parseInt(result.quantity));
	// 			}

	// 			if (result.message === "updated cart") {
	// 				$('#modalMessage').text(result.message);
	// 				$('#cartModal').modal('show');
	// 			}

	// 			if (result.message === "user not logged in") {
	// 				checkIfUserLoggedIn();
	// 			}
	// 		});
	// 	}
	// });

	$('#quantityForm').on('submit', function(event) {
		// stop refresh of page after post submission on form
		event.preventDefault();
		var quantity_value = $('.quantity_form select').val();
		var item_id = $('.quantity_form #item_id').val();
		if (quantity_value !== null) {
			$.ajax({
				type: "POST",
				url: "/cart/add",
				data: { id: item_id, quantity: quantity_value }
			})
			.done(function(result) {
				result = JSON.parse(result)
				if (result.message === "added to cart") {
					$('#modalMessage').text(result.message);
					$('#cartModal').modal('show');
					$('#cartAmount').text(parseInt($('#cartAmount').text()) + parseInt(result.quantity));
				}

				if (result.message === "updated cart") {
					$('#modalMessage').text(result.message);
					$('#cartModal').modal('show');
				}

				if (result.message === "user not logged in") {
					window.location.href = "/users/login"
				}
			});
		}
	});

	$('#updateCart').on('submit', function() {
		var select_array = $('.quantity_select_tag :selected');
		var id_array = $('.item_id');
		var select_values = []
		for (var i = 0; i < select_array.length; i++) {
			var value_pair = [];
			value_pair[0] = id_array[i].value;
			value_pair[1] = select_array[i].text;
			select_values.push(value_pair);
		}

		$.ajax({
			type: "PUT",
			url: "/cart/update",
			data: { values: select_values }
		})
		.done(function(result) {
			if (result.message === "cart updated") {
				window.location.href = "/cart"
			}
		})
	})

});
