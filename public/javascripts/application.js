$(document).ready(function() {
	console.log('script loaded');

	$('#addToCart').on('click', function(event) {
		// stop refresh of page after post submission on form
		event.preventDefault();
		var quantity_value = $('.quantity_form select').val();
		var item_id = $('.quantity_form #item_id').val();
		$.ajax({
			type: "POST",
			url: "/cart/add",
			data: { id: item_id, quantity: quantity_value },
		})
		.done(function(result) {
			if (result === "added to cart") {
				$('#cartModal').modal('show')
			}
		});
	});

	
});