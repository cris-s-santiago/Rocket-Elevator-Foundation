/**	CONTACT FORM
*************************************************** **/
var _hash = window.location.hash;

/**
	BROWSER HASH - from php/contact.php redirect!

	#alert_success 		= email sent
	#alert_failed		= email not sent - internal server error (404 error or SMTP problem)
	#alert_mandatory	= email not sent - required fields empty
**/	jQuery(_hash).show();

//MESSAGE CONTACT FORM
jQuery( "#form-contact" ).submit(function( event ) {	
	// For clean the form
	jQuery("#form-contact").trigger("reset");
	//For Pop
	window.alert("Thank You, your message was successfully sent!");
	//Not open the php page
	event.preventDefault();
  });


  const input = document.getElementById('input')

  input.addEventListener('change', (event) => {
	const target = event.target
		if (target.files && target.files[0]) {  
		
		const maxAllowedSize = 10 * 1024 * 1024;
		if (target.files[0].size > maxAllowedSize) {
			window.alert("File is too big! Max file size: 10Mb ");
			 target.value = ''
		}
	}
  })