
$(document).ready(function() {
	
	// console.log($('#cartAmount').text());
	$.ajax({
		type: 'GET',
		url: '/cart/amount'
	})
	.done(function(result) {
		if (result > 0) {
			$('#cartAmount').text(result)
		} else {
			$('#cartAmount').text("0")
		}
	});

	$('.starRating').rateYo({
		starWidth: "40px",
		normalFill: "#A0A0A0",
		ratedFill: "rgb(243, 156, 18)",
		fullStar: true,
	})

	$('.starReadOnly').rateYo({
		starWidth: "40px",
		normalFill: "#A0A0A0",
		ratedFill: "rgb(243, 156, 18)",
		fullStar: true,
		readOnly: true
	})


	$('#submit_review').on('click', function() {
		var itemRating = $('.starRating').rateYo('rating')
		console.log('itemRating', itemRating);
		$('#rating_field').attr('value', itemRating);
	})

	$('#addToCart').on('click', function(event) {
		// stop refresh of page after post submission on form
		event.preventDefault();
		var quantity_value = $('.quantity_form select').val();
		var item_id = $('.quantity_form #item_id').val();
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
	});
});