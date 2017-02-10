var ajaxRequest;

$('form').on('submit', function(form) {
     form.preventDefault();
     
     var title = $('#exampleInputTitle').val();
     var msg = $('#exampleInputMessage').val();
     
     if (title != "" && msg != "") {
	    
	    var uri = "/notify";
	    var json = {"title": title, "message": msg};
	     
		ajaxRequest = $.ajax({
		            url: uri,
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
					dataType: "json",
		            data: JSON.stringify(json)
		        });
		
		      /*  request cab be abort by ajaxRequest.abort() */
		
		     ajaxRequest.done(function (response, textStatus, jqXHR){
		          alert("Sucessfully Submitted");
		     });
		
		     /* On failure of request this function will be called  */
		     ajaxRequest.fail(function (jqXHR, textStatus, errorThrown){
		        // Log the error to the console
		        console.error(
		            "The following error occurred: "+
		            textStatus, errorThrown
		        );
		    });
	     
	     $('#exampleInputTitle').val('');
		 $('#exampleInputMessage').val('');
     }
     
     
});