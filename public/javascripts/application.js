
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
		event.preventDefault();
		var select_array = $('.quantity_select_tag :selected');
		var id_array = $('.item_id');
		var select_values = []
		for (var i = 0; i < select_array.length; i++) {
			var item = {};
			item["id"] = id_array[i].value;
			item["value"] = select_array[i].text;
			select_values.push(item);
		}

		$.ajax({
			type: "PUT",
			url: "/cart/update",
			data: { select_values: JSON.stringify(select_values) }
		})
		.done(function(result) {
			result = JSON.parse(result)
			if (result.message === "cart updated") {
				new_quantities = result.select_values;
				cart_item_quantity = $('.cart_item_quantity');
				cart_total = 0;
				for (var item = 0; item < new_quantities.length; item++) {
					cart_item_quantity[item].textContent = new_quantities[item].value
					cart_total += parseInt(new_quantities[item].value)
				}
				$('#cartAmount').text(cart_total);
				$('.cart_message').text(result.message)
			}
		})
	})

});
