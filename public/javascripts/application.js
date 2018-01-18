
$(document).ready(function() {
	
	// console.log($('#cartAmount').text());
	// $('.login_button').on('click', function() {
	// 	console.log('cliked');
	// 	$.ajax({
	// 		type: 'GET',
	// 		url: '/cart/amount'
	// 	})
	// 	.done(function(result) {
	// 		console.log(result);
	// 		if (result > 0) {
	// 			$('#cartAmount').text(result)
	// 		} else {
	// 			$('#cartAmount').text("0")
	// 		}
	// 	});
	// });

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
	$('#addToCart').on('click', function(event) {
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
			});
		}
	});
});