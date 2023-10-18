class ValidarFormulario {
  constructor() {
    this.formulario = document.querySelector('.pagamento-assinante');
    this.eventos();
  }
  eventos() {
    this.formulario.addEventListener('submit', (e) => {
      this.handleSubmit(e);
    });
    const validade = this.formulario.querySelector('#validade');
    validade.addEventListener('input', ({ target }) => {
      if (target.value.length > 4) {
        target.value = target.value.slice(0, 4);
      }
      console.log(target.value);
    });
    const seguranca = this.formulario.querySelector('#seguranca');
    seguranca.addEventListener('input', ({ target }) => {
      if (target.value.length > 3) {
        target.value = target.value.slice(0, 3);
      }
      console.log(target.value);
    });
  }
  handleSubmit(e) {
    e.preventDefault();
    const camposvalidos = this.camposValidos();
    if (camposvalidos) {
      window.alert('Cadastro efetuado');
      this.formulario.submit();
      window.location.href = 'concluido.html';
    }
    console.log('Formulário não enviado');
  }
  camposValidos() {
    let valido = true;
    for (let errorMsg of this.formulario.querySelectorAll('.mensagem-erro')) {
      errorMsg.remove();
    }
    for (let campo of this.formulario.querySelectorAll('.campo')) {
      if (!campo.value) {
        const label = campo.previousElementSibling.innerText;
        this.criaErro(campo, `${label} não pode está vazio`);
        valido = false;
      }
      if (campo.classList.contains('cpf')) {
        if (!this.validaCpf(campo)) valido = false;
      }
      if (campo.classList.contains('cartao')) {
        if (!this.validaNumero(campo)) return false;
      }
    }
    return valido;
  }

  validaNumero(campo) {
    const cartao = campo.value;
    let valido = true;
    if (cartao.length < 13 || cartao.length > 16) {
      this.criaErro(campo, 'Informe os dígitos do cartão');
      valido = false;
    }
    if (!cartao.match(/^[0-9]+/g)) {
      this.criaErro(campo, 'Número precisa conter apenas dígitos');
      valido = false;
    }
    return valido;
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
