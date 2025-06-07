document.addEventListener('DOMContentLoaded', function() {
   const form = document.querySelector('.register');
   
   form.addEventListener('submit', function(e) {
      let isValid = true;
      
      // Validate file types
      const cvInput = form.querySelector('input[name="cv"]');
      if (cvInput.files.length > 0) {
         const file = cvInput.files[0];
         if (file.type !== 'application/pdf') {
            alert('Please upload a PDF file for your CV.');
            isValid = false;
         }
      }
      
      const imageInput = form.querySelector('input[name="image"]');
      if (imageInput.files.length > 0) {
         const file = imageInput.files[0];
         if (!file.type.match('image.*')) {
            alert('Please upload an image file for your profile picture.');
            isValid = false;
         }
      }
      
      if (!isValid) {
         e.preventDefault();
      }
   });
   
   // Add character counter for textarea
   const motivationTextarea = form.querySelector('textarea[name="motivation"]');
   const charCounter = document.createElement('div');
   charCounter.style.textAlign = 'right';
   charCounter.style.fontSize = '1.2rem';
   charCounter.style.color = 'var(--light-color)';
   motivationTextarea.parentNode.insertBefore(charCounter, motivationTextarea.nextSibling);
   
   motivationTextarea.addEventListener('input', function() {
      const remaining = 1000 - this.value.length;
      charCounter.textContent = `${remaining} characters remaining`;
   });
});