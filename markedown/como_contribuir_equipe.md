## Como Contribuir com esse projeto (Equipe)

* ### Siga as etapas abaixo:

1. **Verifique sua configuração de usuário global no git.**
```
git config --list
```
2. **Se a configuração do user.name ou user.email estiver incorreto.**
```
git config --global user.name 'FirstName LastName'
```
```
git config --global user.email 'your_email@domain.com.br'
```
3. **Faça o clone deste repositório.**
```
git clone https://github.com/cesar-augusto-costa/projeto_integrador_FRONT_END_proz_turma11_grupo2.git .
```
4. **LEMBRE: Antes de Alterar e Antes de Commitar, atualize seu repositório para evitar conflito.**
```
git pull
```
5. **Antes de Commitar, Adicionar no Stage.**
- Para adicionar tudo.
```
git add .
```
```
git add *
```
- Para adicionar um ou mais arquivos expecifico.
```
git add nome_arquivo.ext
```
```
git add nome_arquivo.ext outro_nome_arquivo.ext
```
6. **Para saber o status do repositório.**
```
git status
```
7. **Para commitar, coloque uma mensagem, caso necessário adicione uma descrição mais detalhada.**
```
git commit -m "Minha contribuição" -m "Minha descrição"
```
8. **Não esquece que depois do commit, precisa enviar para o GitHup**
```
git push
```
9. **Para ver o relatório dos commites**
```
git log
```

### OBSERVAÇÃO SOBRE CONFLITO

**Caso de conflito, por esquecer de atualizar o repoitório local.**
```
git pull
```

**Caso de conflito por alterar algo no mesmo lugar.**
```
git pull
```
**Que o VS Code vai deixar escolher as opções para resolver, depois é só commitar.**
```
git commit -m "Resolvi conflito de _ " -m "Minha descrição"
```
  
---
* **Caso queira ter uma experiência melhor com o Git, adicione a extensão: `GitLens`**
---

* ### Principais Comandos e seu Funcionamento:

Comando         | Descrição
-------------   | -------------
git config --list	       | Mostra a lista de configuração no git
git config user.name “NOME”	       | Definir o nome do usuário que usará Git neste projeto
git config --global user.name “NOME”	       | Definir o nome do usuário para todos os projetos neste computador
git config user.email “EMAIL”	        | Definir o email do usuário que usará Git neste projeto
git config --global user.email “EMAIL”	       | Definir o email do usuário para todos os projetos neste computador
git init        | Inicializar um repositório na pasta atual
git status	     | Mostrar os arquivos e pastas que estão na área de staging
git add .       | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add *       | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add -A       | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add -all       | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add nome_do_arquivo.ext       | Adiciona o arquivo especificado à “area de staging”
git commit -m “MENSAGEM”  | Realizar um commit com uma mensagem que o identifique
git clean -d -f | Limpa todas as incosistências locais para o commit ser limpo
git pull        | Baixa ultima versão do repositório
git push        | Envia as modificações para o repositório master
git log	        | Mostra os últimos commits do repositório atual
git restore   | **FALTA FAZER**
