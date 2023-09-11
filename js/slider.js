/*criação de variáveis*/
const slide = document.querySelectorAll(".slide");
const botaoVoltar = document.getElementById("botao-voltar");
const botaoAvancar = document.getElementById("botao-avancar");
/*constante para o slide que está ativo*/
let correnteSlide = 0;

/*criação de funções*/
/*função para esconder o slider*/

function esconderSlider(){
    slide.forEach(item => item.classList.remove("on"));
}

/*função mostrar o slider*/

function mostrarSlider(){
    slide[correnteSlide].classList.add('on');

}

function avancarSlide(){
    esconderSlider();
    if(correnteSlide == slide.length -1){
        correnteSlide == 0;
    }else{
        correnteSlide++;
    }

    mostrarSlider();
}

function voltarSlide(){
    esconderSlider();
    if(correnteSlide == 0){
        correnteSlide == slide.length -1;
    }else{
        correnteSlide--;
    }

    mostrarSlider();
}

//evento nos botões
botaoAvancar.addEventListener('click', avancarSlide);
botaoVoltar.addEventListener('click', voltarSlide);
