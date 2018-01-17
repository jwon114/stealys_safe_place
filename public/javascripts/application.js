$(document).ready(function() {

	// $('#cartAmount').load('/cart', function(result) {
	// 	// console.log(result)
	// })

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
			result = JSON.parse(result)
			console.log(result.message);
			if (result.message === "added to cart") {
				$('#cartModal').modal('show');
				$('#cartAmount').text(parseInt($('#cartAmount').text()) + parseInt(result.quantity));
			}
		});
	});
});