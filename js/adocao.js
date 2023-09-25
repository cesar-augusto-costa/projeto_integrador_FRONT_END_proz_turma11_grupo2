//apresentação. Expande a aba ao clicar em leia mais
function leiaMais(){
    let pontos = document.getElementById("pontos");
    let maisTexto = document.getElementById("mais");
    let btnLeiaMais = document.getElementById("btnLeiaMais");
if(pontos.style.display === "none"){
    pontos.style.display = "inline";
    maisTexto.style.display = "none";
    btnLeiaMais.innerHTML = "Leia Mais";
}else{
    pontos.style.display = "none";
    maisTexto.style.display = "inline";
    btnLeiaMais.innerHTML = "Leia Menos";
    
}
}

let currentSlide = 0;
const slides = document.querySelectorAll('.slide');
const resultadoTitulo = document.getElementById('resultado-titulo');
const resultadoTexto = document.getElementById('resultado-texto');
const resultadoImg = document.getElementById('resultado-imagem');

function proximaPergunta() {
    if (currentSlide < slides.length - 1) {
        slides[currentSlide].style.display = 'none';
        currentSlide++;
        slides[currentSlide].style.display = 'block';
    } else {
        calcularResultado();
    }
}

function calcularResultado() {
    // Calcule o resultado com base nas respostas aqui
    // Exemplo simples: contar quantas opções "cachorro" ou "gato" foram selecionadas
    const respostas = document.querySelectorAll('input[name^="pergunta"]');
    let opcao1Count = 0;
    let opcao2Count = 0;

    for (const resposta of respostas) {
        if (resposta.checked && resposta.value === 'cachorro') {
            opcao1Count = opcao1Count + 1;
        }
        if (resposta.checked && resposta.value === 'gato') {
            opcao2Count = opcao2Count + 1;
        }
    }
console.log(opcao1Count);
console.log(opcao2Count);
    // Exiba o resultado
    if (opcao1Count > opcao2Count) {
        resultadoTitulo.textContent = "Cães"
        resultadoTexto.textContent = "ócil, inteligente e carinhoso. Como você tem tempo livre para cuidar, passear e ensinar seu pet, cachorros são as opções que mais se adaptam a sua vida, já que são animais sociáveis (com pessoas e outros tipos de animais), extremamente dependentes, ativos e gostam de brincar. A personalidade pode variar de uma raça para outra, mas no geral, ficam deprimidos quando passam muito tempo sozinhos. Vale lembrar que, antes de escolher seu amigo, cães necessitam de alimentação diária, passeios, horas de dedicação, banhos frequentes, vacinas e visitas ao veterinário.";
        resultadoImg.src = "../img/adocao/imagem_quiz/dog.png"
    
    } else if (opcao1Count < opcao2Count) {
        resultadoTitulo.textContent = "Gatos"
        resultadoTexto.textContent = "Independentes, os gatos se adaptam bem à rotina dos donos que passam boa parte do tempo fora de casa. No geral, se viram bem quando estão sozinhos, mas são curiosos e exigem alguns cuidados. Raramente tomam banho, curtem passeios solitários quando moram em casas e, em apartamentos, costumam saltar em janelas e varandas, o que exige certa proteção. Além disso, é bom investir em brinquedos, que evitam desgastes nos móveis";
        resultadoImg.src = "../img/adocao/imagem_quiz/gatinho-cinza.png"
    }

    // Exiba a seção de resultado
    slides[currentSlide].style.display = 'none';
    document.querySelector('.resultado').style.display = 'block';
}

// Inicie o quiz
slides[currentSlide].style.display = 'block';
