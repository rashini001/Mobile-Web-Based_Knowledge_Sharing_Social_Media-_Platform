// notifications.js
document.addEventListener('DOMContentLoaded', function() {
    // Add animation to notifications when they load
    const boxes = document.querySelectorAll('.notifications .box');
    
    boxes.forEach((box, index) => {
        box.style.opacity = '0';
        box.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            box.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            box.style.opacity = '1';
            box.style.transform = 'translateY(0)';
        }, 100 * index);
    });
    
    // Mark notification as read when clicked
    boxes.forEach(box => {
        box.addEventListener('click', function(e) {
            if (!e.target.classList.contains('inline-btn')) {
                this.classList.remove('unread');
            }
        });
    });
});

// Script loader for notifications page
if (document.querySelector('.notifications')) {
    // Check if the script is already loaded to prevent duplicates
    if (!document.querySelector('script[src="js/notifications.js"]')) {
        const script = document.createElement('script');
        script.src = 'js/notifications.js';
        script.onerror = () => console.error('Failed to load notifications script');
        document.body.appendChild(script);
    }
}