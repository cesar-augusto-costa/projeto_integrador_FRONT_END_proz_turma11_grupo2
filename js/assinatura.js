class ValidarFormulario {
  constructor() {
    this.formulario = document.querySelector('.pagamento-assinante');
    this.eventos();
  }
  eventos() {
    this.formulario.addEventListener('submit', (e) => {
      this.handleSubmit(e);
    });
  }
  handleSubmit(e) {
    e.preventDefault();
    const camposvalidos = this.camposValidos();
    if (camposvalidos) {
      window.alert('Cadastro efetuado');
      this.formulario.submit();
      window.location.replace('http://127.0.0.1:5500/pages/concluido.html');
    }
    console.log('Formulário não enviado');
  }
  camposValidos() {
    let valid = true;
    for (let errorMsg of this.formulario.querySelectorAll('.mensagem-erro')) {
      errorMsg.remove();
    }
    for (let campo of this.formulario.querySelectorAll('.campo')) {
      if (!campo.value) {
        const label = campo.previousElementSibling.innerText;
        this.criaErro(campo, `${label} não pode está vazio`);
        valid = false;
      }
      if (campo.classList.contains('cpf')) {
        if (!this.validaCpf(campo)) valid = false;
      }
      if (campo.classList.contains('cartao')) {
        if (!this.validaNumero(campo)) return false;
      }
    }
    return valid;
  }

  validaNumero(campo) {
    const cartao = campo.value;
    let valid = true;
    if (cartao.length < 13 || cartao.length > 16) {
      this.criaErro(campo, 'Informe os digitos do cartão');
      valid = false;
    }
    if (!cartao.match(/^[0-9]+/g)) {
      this.criaErro(campo, 'Número precisa conter apenas digitos');
      valid = false;
    }
    return valid;
  }

  validaCpf(campo) {
    const cpf = new validaCpf(campo.value);
    if (!cpf.valida()) {
      this.criaErro(campo, 'CPF Inválido');
      return false;
    }
    return true;
  }

  criaErro(campo, msg) {
    const div = document.createElement('div');
    div.innerHTML = msg;
    div.classList.add('mensagem-erro');
    campo.insertAdjacentElement('afterend', div);
  }
}

const valida = new ValidarFormulario();