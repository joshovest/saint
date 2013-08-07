// sorting
$(document).ready(function(){
	var sortSelector	= '.sortable tbody'
		,alertSelector	= '#save-alert';
	$(sortSelector).sortable({
		scroll:		true
		,cursor:	'crosshair'
		,opacity:	0.6
	});
	
	$('.save-sort').on('click', function(){
		$.ajax({
			type:			'post'
			,data:			$(sortSelector).sortable('serialize')
			,dataType:		'script'
			,beforeSend:	function(){
				$(alertSelector).css('opacity', '0');
			}
			,complete:		function(request){
				$(alertSelector).css('opacity', '1').html('Order successfully saved.');
				$(sortSelector + ' tr').each(function(i){
					$(this).find('td:first').html(i+1);
				})
			}
			,url: $(this).attr('rel')
		});
		return false;
	});
});