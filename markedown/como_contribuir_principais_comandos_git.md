## Principais Comandos e seu Funcionamento:

Comando                                       | Descrição
-------------                                 | -------------
git config      	                            | Mostra as opções de utilização
git config init.defaultBranch                 | Mostra a branch principal
git config -- global init.defaultBranch main  | Configura a branch global padrão como main
git config --list	                            | Mostra uma lista de configurações no git
git config --global --list	                  | Mostra uma lista de configurações global no git
git config user.name “NOME”	                  | Definir o nome do usuário que usará Git neste projeto
git config --global user.name “NOME”	        | Definir o nome do usuário para todos os projetos neste computador
git config user.email “EMAIL”	                | Definir o email do usuário que usará Git neste projeto
git config --global user.email “EMAIL”	      | Definir o email do usuário para todos os projetos neste computador
git config --global credential.helper         | Mostra qual é o estado da gravação da credencial (cache / store)
git config --global credential.helper cache   | 
git config --global credential.helper store   |
git clone CAMINHO-GITHUB                      | Clona somente a branch principal com a pasta raiz do github
git clone CAMINHO-GITHUB .                    | Clona somente a branch principal sem a pasta raiz do github
git clone CAMINHO-GITHUB nova-pasta           | Clona somente a branch principal sem a pasta raiz do github na nova-pasta
git clone URL --branch feature --single-branch|
git remote -v                                 |
git remote add origin CAMINHO-GITHUB          |        
git init                                      | Inicializar um repositório na pasta atual
git status	                                  | Mostrar os arquivos e pastas que estão na área de staging
git add .                                     | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add *                                     | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add -A                                    | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add -all                                  | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add nome_do_arquivo.ext                   | Adiciona o arquivo especificado à “area de staging” 
git commit -m “MENSAGEM”                      | Realizar um commit com uma mensagem que o identifique
git clean -d -f                               | Limpa todas as incosistências locais para o commit ser limpo
git pull                                      | Baixa ultima versão do repositório
git push                                      | Envia as modificações para o repositório master
git log	                                      | Mostra os últimos commits do repositório atual
git restore                                   | **FALTA FAZER**
