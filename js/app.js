// LOGIN
var btnSignIn = document.querySelector("#signin");
var btnSignUp = document.querySelector('#signup');

var body = document.querySelector("body");

btnSignIn.addEventListener("click", function () {
    body.className = "sign-in-js";
})

btnSignUp.addEventListener("click", function () {
    body.className = "sign-up-js";
})
// FIM LOGIN 

