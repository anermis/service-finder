jQuery(document).ready(function($){
	    
	$(".btnrating").on('click',(function(e) {
	
            var previous_value = $("#selected_rating").val();

            var selected_value = $(this).attr("data-attr");
            $("#selected_rating").val(selected_value);
            
            $.ajax({
                url: 'rate.htm?selected_rating=' + selected_value + '&selectedUser=${selectedUser.userEntity.id}',
                contentType: 'aplication/json',
                success: function (result) {
                    for (i = 1; i <= selected_value; ++i) {
                    $("#rating-star-"+i).toggleClass('btn-success');
                    $("#rating-star-"+i).toggleClass('btn-default');
                    }

                    for (ix = 1; ix <= previous_value; ++ix) {
                    $("#rating-star-"+ix).toggleClass('btn-success');
                    $("#rating-star-"+ix).toggleClass('btn-default');
                    }
                }
            });
        }));
    
});