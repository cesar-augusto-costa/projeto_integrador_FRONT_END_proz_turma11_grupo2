/*codigo quiz*/
let skippular = document.getElementById('skip_pular');
let scorepontuacao = document.getElementById('score_pontuacao');
let totalScore = document.getElementById('totalScore');
let countdowncontagem = document.getElementById('countdown_contagem');
let count = 0;
let scoreCount = 0;
let duration = 0;
let qasettitulo = document.querySelectorAll('.qa_set_titulo');
let qaAnsRow = document.querySelectorAll('.qa_set_titulo .qa_ans_row_linha input');
skippular.addEventListener('click',function(){
    step();
    duration =10
})

qaAnsRow.forEach( function(qaAnsRowSingle){
    qaAnsRowSingle.addEventListener('click', function(){
        setTimeout(function(){
            step();
            duration =10
        },500)
        var valid = this.getAttribute("valid");
        if(valid == "valid"){
            scoreCount = scoreCount + 20;
            scorepontuacao.innerHTML = scoreCount;
            totalScore.innerHTML = scoreCount;
        }else{
            scoreCount = scoreCount - 20;
            scorepontuacao.innerHTML = scoreCount;
            totalScore.innerHTML = scoreCount;

        }
    })
})

function step(){
    count += 1;
    for(let i = 0; i < qasettitulo.length; i++){
        qasettitulo[i].className ='qa_set_titulo';
    }
    qasettitulo[count].className = 'qa_set_titulo active';
    if(count == 6){
        skippular.style.display = 'none';
        clearInterval(durationTime);
        countdowncontagem.innerHTML = 0;

    }
}

let durationTime = setInterval(function(){
    if(duration == 10){
        duration = 0;
    }
   
},1000);



