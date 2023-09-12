/*criação de variáveis*/
const slidePromo = document.querySelectorAll(".slide-promocao");
const botaoVoltarPromo = document.getElementById("botao-voltar-promocao");
const botaoAvancarPromo = document.getElementById("botao-avancar-promocao");
/*constante para o slide que está ativo*/
let correnteSlidePromo = 0;

/*criação de funções*/
/*função para esconder o slider*/

function esconderSliderPromo(){
    slidePromo.forEach(item => item.classList.remove("on"));
}

/*função mostrar o slider*/

function mostrarSliderPromo(){
    slidePromo[correnteSlidePromo].classList.add('on');

}

function avancarSlidePromo(){
    esconderSliderPromo();
    if(correnteSlidePromo == slidePromo.length - 1){
        correnteSlidePromo = 0;
    }else{
        correnteSlidePromo++;
    }

    mostrarSliderPromo();
}

function voltarSlidePromo(){
    esconderSliderPromo();
    if(correnteSlidePromo == 0){
        correnteSlidePromo = slidePromo.length - 1;
    }else{
        correnteSlidePromo--;
    }

    mostrarSliderPromo();
}

//evento nos botões
botaoAvancarPromo.addEventListener('click', avancarSlidePromo);
botaoVoltarPromo.addEventListener('click', voltarSlidePromo);
