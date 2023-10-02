const inputValidade = document.querySelector('#validade');
const inputCvv = document.querySelector('#seguranca');
const inputCPF = document.querySelector('#cpf');
const form = document.querySelector('.pagamento-assinante');
const btn = document.querySelector('.comprarbutton');

function handleClick(event) {
  window.location.href = 'http://127.0.0.1:5500/pages/concluido.html';
}

inputCPF.addEventListener('input', function () {
  const valor = inputCPF.value;
  if (inputCPF.value.length > 11) inputCPF.value = inputCPF.value.slice(0, 11);
});

inputValidade.addEventListener('input', function () {
  const valor = inputValidade.value;
  if (inputValidade.value.length > 4)
    inputValidade.value = inputValidade.value.slice(0, 4);
});

inputCvv.addEventListener('input', function () {
  const valor = inputCvv.value;
  if (inputCvv.value.length > 3) inputCvv.value = inputCvv.value.slice(0, 3);
});
btn.addEventListener('click', handleClick);
