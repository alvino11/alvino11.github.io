document.addEventListener("DOMContentLoaded", function() {
    
    // --- Mobile Hamburger Menu Controller ---
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (menuToggle && navMenu) {
        menuToggle.addEventListener('click', function() {
            navMenu.classList.toggle('mobile-active');
            
            // Toggle dynamic icons safely
            const toggleIcon = this.querySelector('i');
            if (toggleIcon.classList.contains('fa-bars')) {
                toggleIcon.className = 'fas fa-times';
            } else {
                toggleIcon.className = 'fas fa-bars';
            }
        });

        // Close absolute dropdown menu drawer smoothly on clicking any link
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('mobile-active');
                const toggleIcon = menuToggle.querySelector('i');
                if (toggleIcon) toggleIcon.className = 'fas fa-bars';
            });
        });
    }

    // --- Dynamic Portfolio Projects Filter Logic ---
    const filterButtons = document.querySelectorAll(".filter-btn");
    const projectCards = document.querySelectorAll(".project-card");

    filterButtons.forEach(button => {
        button.addEventListener("click", function() {
            // Manage Active Filter Button Toggle State
            filterButtons.forEach(btn => btn.classList.remove("active"));
            this.classList.add("active");

            const filterTarget = this.getAttribute("data-filter");

            // Filter Layout Elements Smoothly
            projectCards.forEach(card => {
                const category = card.getAttribute("data-category");
                
                if (filterTarget === "all" || category === filterTarget) {
                    card.style.display = "block";
                    setTimeout(() => {
                        card.style.opacity = "1";
                        card.style.transform = "scale(1)";
                    }, 50);
                } else {
                    card.style.opacity = "0";
                    card.style.transform = "scale(0.95)";
                    setTimeout(() => {
                        card.style.display = "none";
                    }, 200);
                }
            });
        });
    });
});
