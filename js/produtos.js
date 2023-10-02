// Array - lista de produtos
const produtos = [
    {
      id: 1,
      description: "Ração 15 Kg",
      forPets: "Para Cães Adultos",
      race: "Raças Grandes",
      brand: "Marca: Golden Mega",
      imageSrc:
        "../img/produtos/cachorro/racao/racao_cao_adulto_porte_grande.png",
      price: "R$169,90",
    },
    {
      id: 2,
      description: "Ração 15 Kg",
      forPets: "Para Cães Filhotes",
      race: "Raças Grandes",
      brand: "Marca: Golden Mega",
      imageSrc:
        "../img/produtos/cachorro/racao/racao_cao_filhote_porte_grande.png",
      price: "R$179,90",
    },
    {
      id: 3,
      description: "Ração 15 Kg",
      forPets: "Para Cães Filhotes",
      race: "Raças Pequenas",
      brand: "Marca: SuperPet",
      imageSrc:
        "../img/produtos/cachorro/racao/racao_cao_filhote_porte_pequeno.png",
      price: "R$159,90",
    },
    {
      id: 4,
      description: "Ração 15 Kg",
      forPets: "Para Cães Adultos",
      race: "Raças Grandes",
      brand: "Marca: Premium Food",
      imageSrc:
        "../img/produtos/cachorro/racao/racao_cao_adulto_porte_grande.png",
      price: "R$189,90",
    },
    {
      id: 5,
      description: "Ração 15 Kg",
      forPets: "Para Cães Adultos",
      race: "Raças Pequenas",
      brand: "Marca: PetMaster",
      imageSrc:
        "../img/produtos/cachorro/racao/racao_cao_adulto_porte_pequeno.png",
      price: "R$169,90",
    },
    {
      id: 6,
      description: "Biscoito 250 g",
      forPets: "Para Cães Filhotes",
      race: "Todas as Raças",
      brand: "Marca: Premier Cookie",
      imageSrc: "../img/produtos/cachorro/petisco/petisco_cao_filhote.png",
      price: "R$16,40",
    },
    {
      id: 7,
      description: "Biscoito 250 g",
      forPets: "Para Cães Adultos",
      race: "Raças Pequenas",
      brand: "Marca: Premier Cookie",
      imageSrc:
        "../img/produtos/cachorro/petisco/petisco_cao_adulto_porte_pequeno.png",
      price: "R$16,99",
    },
    {
      id: 8,
      description: "Bifinho 500 g",
      forPets: "Para Cães Adultos",
      race: "Todas as Raças",
      brand: "Marca: KelDog Mini",
      imageSrc: "../img/produtos/cachorro/petisco/petisco_cao_adulto.png",
      price: "R$25,41",
    },
    {
      id: 9,
      description: "Brinquedo Bola Cravo",
      forPets: "Para Cães",
      race: "Todas as Raças",
      brand: "Marca: Líder Pet",
      imageSrc: "../img/produtos/cachorro/brinquedos/bolinha.png",
      price: "R$12,99",
    },
    {
      id: 10,
      description: "Brinquedo Interativo Petball",
      forPets: "Para Cães",
      race: "Todas as Raças",
      brand: "Marca: Pet Games",
      imageSrc: "../img/produtos/cachorro/brinquedos/bolinha_interativa.png",
      price: "R$37,99",
    },
    {
      id: 11,
      description: "Brinquedo Mordedor Galinha",
      forPets: "Para Cães",
      race: "Todas as Raças",
      brand: "Marca: Napi",
      imageSrc: "../img/produtos/cachorro/brinquedos/galinha.png",
      price: "R$19,99",
    },
    {
      id: 12,
      description: "Ração 10,1 Kg",
      forPets: "Para Gatos Adultos",
      race: "Todas as Raças",
      brand: "Marca: GranPlus",
      imageSrc: "../img/produtos/gato/racao/racao_gato_adulto.png",
      price: "R$147,99",
    },
    {
      id: 13,
      description: "Ração 1,5 Kg",
      forPets: "Para Gatos Filhotes",
      race: "Todas as Raças",
      brand: "Marca: Royal Canin",
      imageSrc: "../img/produtos/gato/racao/racao_gato_filhote.png",
      price: "R$112,19",
    },
    {
      id: 14,
      description: "Petisco",
      forPets: "Para Gatos Adultos",
      race: "Todas as Raças",
      brand: "Marca: Dreamies",
      imageSrc: "../img/produtos/gato/petisco/petisco.png",
      price: "R$19,99",
    },
    {
      id: 15,
      description: "Bifitos 30 g",
      forPets: "Para Gatos",
      race: "Todas as Raças",
      brand: "Marca: Snack Kelcat",
      imageSrc: "../img/produtos/gato/petisco/bifitos.png",
      price: "R$5,52",
    },
    {
      id: 16,
      description: "Leite 220 ml",
      forPets: "Para Gatos",
      race: "Todas as Raças",
      brand: "Marca: Pet Hello Kitty",
      imageSrc: "../img/produtos/gato/petisco/leite.png",
      price: "R$12,99",
    },
    {
      id: 17,
      description: "Brinquedo Ratinhos",
      forPets: "Para Gatos",
      race: "Todas as Raças",
      brand: "Marca: Chalesco",
      imageSrc: "../img/produtos/gato/brinquedos/ratinho.png",
      price: "R$16,99",
    },
    {
      id: 18,
      description: "Brinquedo Bolas Catnip",
      forPets: "Para Gatos",
      race: "Todas as Raças",
      brand: "Marca: Chalesco",
      imageSrc: "../img/produtos/gato/brinquedos/bolinha.png",
      price: "R$29,99",
    },
  ];
  
  // Função para criar um elemento de produto e adicioná-lo à seção de produtos
  function criarProduto(productData, index) {
    const movieProduct = document.createElement("section");
    movieProduct.classList.add("movie-product");
    movieProduct.id = `product-${index + 1}`;
  
    const productTitle = document.createElement("strong");
    productTitle.classList.add("product-title");
  
    // Adicione parágrafos para cada propriedade do produto
    const descriptionParagraph = document.createElement("p");
    descriptionParagraph.classList.add("description");
    descriptionParagraph.textContent = productData.description;
  
    const forPetsParagraph = document.createElement("p");
    forPetsParagraph.classList.add("for-pets");
    forPetsParagraph.textContent = productData.forPets;
  
    const raceParagraph = document.createElement("p");
    raceParagraph.classList.add("race");
    raceParagraph.textContent = productData.race;
  
    const brandParagraph = document.createElement("p");
    brandParagraph.classList.add("brand");
    brandParagraph.textContent = productData.brand;
  
    // Adicione a imagem do produto
    const productImage = document.createElement("img");
    productImage.src = productData.imageSrc;
    productImage.alt = productData.description;
    productImage.classList.add("product-image");
  
    // Container para o preço e botão
    const productPriceContainer = document.createElement("div");
    productPriceContainer.classList.add("product-price-container");
  
    const productPrice = document.createElement("span");
    productPrice.classList.add("product-price");
    productPrice.textContent = productData.price;
  
    const addToCartButton = document.createElement("button");
    addToCartButton.type = "button";
    addToCartButton.classList.add("button-hover-background");
    addToCartButton.textContent = "Adicionar ao carrinho";

    addToCartButton.setAttribute("data-id", productData.id);
  
    // Adicione todos os elementos ao produto
    productTitle.appendChild(descriptionParagraph);
    productTitle.appendChild(forPetsParagraph);
    productTitle.appendChild(raceParagraph);
    productTitle.appendChild(brandParagraph);
  
    productPriceContainer.appendChild(productPrice);
    productPriceContainer.appendChild(addToCartButton);
  
    movieProduct.appendChild(productTitle);
    movieProduct.appendChild(productImage);
    movieProduct.appendChild(productPriceContainer);
  
    return movieProduct;
  }
  
  // Obtenha a seção onde deseja inserir os produtos dinamicamente
  const productsContainer = document.querySelector(".products-container");
  
  // Percorra o array de produtos e insira cada um deles na seção
  produtos.forEach((produto, index) => {
    const productElement = criarProduto(produto, index);
    productsContainer.appendChild(productElement);
  });
  
// CARRINHO

if (document.readyState == 'loading') {
    document.addEventListener('DOMContentLoaded', ready)
} else {
    ready()
}

var totalAmount = "0,00"

function ready() {
    // Botão remover produto
    const removeCartProductButtons = document.getElementsByClassName("remove-product-button")
    for (var i = 0; i < removeCartProductButtons.length; i++) {
        removeCartProductButtons[i].addEventListener("click", removeProduct)
    }

    // Mudança valor dos inputs
    const quantityInputs = document.getElementsByClassName("product-qtd-input")
    for (var i = 0; i < quantityInputs.length; i++) {
        quantityInputs[i].addEventListener("change", checkIfInputIsNull)
    }

    // Botão add produto ao carrinho
    const addToCartButtons = document.getElementsByClassName("button-hover-background")
    for (var i = 0; i < addToCartButtons.length; i++) {
        addToCartButtons[i].addEventListener("click", addProductToCart)
    }

    // Botão comprar
    const purchaseButton = document.getElementsByClassName("purchase-button")[0]
    purchaseButton.addEventListener("click", makePurchase)
}

function removeProduct(event) {
    event.target.parentElement.parentElement.remove()
    updateTotal()
}

function checkIfInputIsNull(event) {
    if (event.target.value === "0") {
        event.target.parentElement.parentElement.remove()
    }

    updateTotal()
}

function addProductToCart(event) {
  const button = event.target;
  const productId = button.getAttribute("data-id");

  // Verifique se o produto já está no carrinho
  const cartProduct = document.querySelector(`.cart-product-title[data-id="${productId}"]`);

  if (cartProduct) {
      const quantityInput = cartProduct.parentElement.parentElement.querySelector(".product-qtd-input");
      quantityInput.value = parseInt(quantityInput.value) + 1;
  } else {
      const productInfos = button.parentElement.parentElement;
      const productImage = productInfos.querySelector(".product-image").src;
      const productName = productInfos.querySelector(".product-title").innerText;
      const productDescription = productInfos.querySelector(".description").innerText;
      const productForPets = productInfos.querySelector(".for-pets").innerText;
      const productRace = productInfos.querySelector(".race").innerText;
      const productBrand = productInfos.querySelector(".brand").innerText;
      const productPrice = productInfos.querySelector(".product-price").innerText;

      let newCartProduct = document.createElement("tr");
      newCartProduct.classList.add("cart-product");
      newCartProduct.innerHTML =
          `
          <td class="product-identification">
              <img src="${productImage}" alt="${productName}" class="cart-product-image">
              <strong class="cart-product-title" data-id="${productId}">
                  <p class="description">
                      ${productDescription}
                  <p>
                  <p class="for-pets">
                      ${productForPets}
                  <p>
                  <p class="race">
                      ${productRace}
                  <p>
                  <p class="brand">
                      ${productBrand}
                  <p>
              </strong>
          </td>
          <td>
              <span class="cart-product-price">${productPrice}</span>
          </td>
          <td>
              <input type="number" value="1" min="0" class="product-qtd-input">
              <button type="button" class="remove-product-button">Remover</button>
          </td>
          `;

      const tableBody = document.querySelector(".cart-table tbody");
      tableBody.append(newCartProduct);

      newCartProduct.querySelector(".remove-product-button").addEventListener("click", removeProduct);
      newCartProduct.querySelector(".product-qtd-input").addEventListener("change", checkIfInputIsNull);
  }

  updateTotal();
}


function makePurchase() {
    if (totalAmount === "0,00") {
        alert("Seu carrinho está vazio!")
    } else {
        alert(
            `
              Obrigado pela sua compra!
              Valor do pedido: R$${totalAmount}\n
              Volte sempre :)
            `
        )

        document.querySelector(".cart-table tbody").innerHTML = ""
        updateTotal()
    }
}

// Atualizar o valor total do carrinho
function updateTotal() {
    const cartProducts = document.getElementsByClassName("cart-product")
    totalAmount = 0

    for (var i = 0; i < cartProducts.length; i++) {
      const productPrice = cartProducts[i].getElementsByClassName("cart-product-price")[0].innerText.replace("R$", "").replace(",", ".")
      const productQuantity = cartProducts[i].getElementsByClassName("product-qtd-input")[0].value

      totalAmount += productPrice * productQuantity
    }
    
    totalAmount = totalAmount.toFixed(2)
    totalAmount = totalAmount.replace(".", ",")
    document.querySelector(".cart-total-container span").innerText = "R$" + totalAmount
}