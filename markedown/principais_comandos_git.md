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
