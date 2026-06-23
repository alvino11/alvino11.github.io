document.addEventListener("DOMContentLoaded", function() {
    const filterButtons = document.querySelectorAll(".filter-btn");
    const projectCards = document.querySelectorAll(".project-card");

    filterButtons.forEach(button => {
        button.addEventListener("click", function() {
            // Manage Active Button States
            filterButtons.forEach(btn => btn.classList.remove("active"));
            this.classList.add("active");

            const filterTarget = this.getAttribute("data-filter");

            // Filter Projects Grid Elements smoothly
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
