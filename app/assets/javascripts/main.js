$(document).ready(function(){
	var modal = $("#modal-auth-form").modal({backdrop: true});
	$("a.sign-in").click(function(e){
		e.preventDefault();
		modal.modal('show');
	});
});