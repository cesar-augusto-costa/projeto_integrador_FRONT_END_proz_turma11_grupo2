//705.484.450-52 070.987.720-03
class validaCpf {
  constructor(cpfEnviado) {
    Object.defineProperty(this, 'cpfLimpo', {
      value: cpfEnviado.replace(/\D+/g, "")
    })
  }

  eSequencia() {
    return this.cpfLimpo.charAt(0).repeat(this.cpfLimpo.length) === this.cpfLimpo;
  }

  geraNovoCpf() {
    const cpfParcial = this.cpfLimpo.slice(0, -2);
    const digito1 = validaCpf.geraDigito(cpfParcial);
    const digito2 = validaCpf.geraDigito(cpfParcial + digito1);
    this.novoCPF = cpfParcial + digito1 + digito2 
  }

  static geraDigito(cpfParcial) {
    let total = 0;
    let i = cpfParcial.length + 1;
    for(let numeros of cpfParcial) {
      total +=  i * Number(numeros);
      i--;
      // console.log(total)
    }
    const digito = 11 - (total % 11)
    return digito <=9 ? String(digito) : '0'
  }

  valida() {
    if(!this.cpfLimpo) return false;
    if(typeof this.cpfLimpo !== 'string') return false;
    if(this.cpfLimpo.length !== 11) return false;
    if(this.eSequencia()) return false;
    this.geraNovoCpf()
    console.log(this.novoCPF)
    return `${this.novoCPF === this.cpfLimpo}`
  }
}

// const validacpf = new validaCpf("705.484.450-52")
// if(validacpf.valida()) {
// console.log(`CPF Válido`) 
// } else {
//   console.log(`CPF INVÁLIDO`) 
// }