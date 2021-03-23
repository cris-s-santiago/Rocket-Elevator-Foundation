/**	CONTACT FORM
*************************************************** **/
var _hash = window.location.hash;

/**
	BROWSER HASH - from php/contact.php redirect!

	#alert_success 		= email sent
	#alert_failed		= email not sent - internal server error (404 error or SMTP problem)
	#alert_mandatory	= email not sent - required fields empty
**/	jQuery(_hash).show();

  $(function(){
		const input = document.getElementById('contact:attachment')

		input.addEventListener('change', (event) => {
			const target = event.target
				if (target.files && target.files[0]) {  
				
				const maxAllowedSize = 10 * 1024 * 1024;
				if (target.files[0].size > maxAllowedSize) {
					toastr.error("File is too big! Max file size: 10Mb ");
					target.value = ''
				}
			}
		})
  })
