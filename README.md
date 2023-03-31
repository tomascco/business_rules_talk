# Desafio Regras de negócio

EN: **example application for two private talks that I presented in 2020 and 2021. This application has a pretty simple frontend to make the explanations more tangible. It also proposes a challange to the viewers on how to implement a bussiness rule that was tested, but left incomplete.**

Essa aplicação é um exemplo de loja online com página de produtos, carrinho e pedidos. O desafio aqui é implementar a lógica de checkout que deverá estar contida em [Orders](app/controllers/orders_controller.rb). São sugeridas duas soluções nas branchs `services` e `u-case`.

## Instalação

O projeto usa Ruby 3.0, Rails 6.1.0, sqlite3 e yarn. Para rodar localmente, siga os passos:

1. Clone o repositório e entre na pasta:

```sh
git clone https://github.com/tomascco/business_rules_talk
cd business_rules_talk
```

2. Dê bundle

```sh
bundle install
```

3. Instale as dependências do yarn:

```sh
yarn install
```

Após isso, é só rodar o servidor com

```sh
rails s
```

## Screenshots

Produtos
![Página de produtos](https://i.imgur.com/RqtrsqV.jpg)

Carrinho
![Página de carrinho](https://i.imgur.com/fMVh1zD.jpg)
