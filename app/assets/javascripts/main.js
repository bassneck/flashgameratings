$(document).ready(function(){
	$('a.sign-in').click(function(e){
		e.preventDefault();
		$('#modal-auth-form').modal();
	});
});