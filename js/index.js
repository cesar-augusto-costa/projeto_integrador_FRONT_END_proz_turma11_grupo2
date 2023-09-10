function toggleSearchBar() {
    const searchBar = document.getElementById("divBusca");
    searchBar.classList.toggle("active");
}

const searchIcon = document.querySelector(".fa-magnifying-glass");
searchIcon.addEventListener("click", toggleSearchBar);

function changeSlide(slideId) {
    const slides = document.querySelectorAll(".slide-controller");
    slides.forEach((slide) => {
        slide.checked = slide.id === slideId;
    });
}

const slideLinks = document.querySelectorAll(".slider li label");
slideLinks.forEach((slideLink) => {
    slideLink.addEventListener("click", () => {
        changeSlide(slideLink.getAttribute("for"));
    });
});

function togglePaymentMethods() {
    const paymentMethods = document.querySelector(".col:first-child");
    paymentMethods.classList.toggle("active");
}

const paymentLink = document.querySelector(".col:first-child a");
paymentLink.addEventListener("click", togglePaymentMethods);
