// LOGIN
function isValidEmail(email)
{
    const validRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (email.match(validRegex)) {
        return true
    }

    return false;
}

const formCadastrar = document.getElementById("form-cadastrar");

formCadastrar.onsubmit = function () {
    const email = formCadastrar.querySelector("input[type='email']").value;

    if (!isValidEmail(email)) {
        alert("E-mail inválido");

        return false;
    }

    return true;
}

var btnSignIn = document.querySelector("#signin");
var btnSignUp = document.querySelector("#signup");

var body = document.querySelector("body");

btnSignIn.addEventListener("click", function () {
  body.className = "sign-in-js";
});

btnSignUp.addEventListener("click", function () {
  body.className = "sign-up-js";
});

// FIM LOGIN
