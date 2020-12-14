function addToCart() {
    var currentValue = $('.addToCart').data('id');
    var pathApi = '/iut.localhost/public/cart/add';
    var request = $.ajax({
        url: pathApi,
        method: "POST",
        data : {
            'id' : currentValue
        },
        dataType: "json"
    });

    request.done(function( data ) {
        console.log(data)
    });

    request.fail(function( jqXHR, textStatus ) {
        console.log( "Request failed: " + textStatus );
    });
}

$( document ).ready(function() {
    $(document).on('click', '.addToCart', function() {
        addToCart();
    });
});