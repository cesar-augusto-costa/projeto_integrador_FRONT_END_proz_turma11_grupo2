document.addEventListener("DOMContentLoaded", function () {
    const nextButton = document.getElementById("nextButton");
    const option1 = document.getElementById("option1");
    const option2 = document.getElementById("option2");
    const slide1 = document.getElementById("slide1");
    const slide2 = document.getElementById("slide2");

    nextButton.addEventListener("click", function () {
        if (option1.checked || option2.checked) {
            // Verifica se pelo menos uma opção de radiobotão está marcada
            slide1.style.display = "none"; // Oculta o slide atual
            slide2.style.display = "block"; // Exibe o próximo slide
        } else {
            alert("Selecione uma opção antes de avançar.");
        }
    });
});

