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
git clone -b develop CAMINHO-GITHUB           |
git clone URL --branch feature --single-branch|
git remote -v                                 |
git remote add origin CAMINHO-GITHUB          |        
git init                                      | Inicializar um repositório na pasta atual
git status	                                  | Mostrar os arquivos e pastas que estão na área de staging
git restore ARQUIVO                           | Restaura o arquivo modificado, descartando toda a alteração.
git add .                                     | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add *                                     | Adiciona todos os arquivo a partir do local no qual o script foi executado
git add -A                                    | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add -all                                  | Adiciona todos os arquivos atuais (novos, atualizados e deletados)
git add nome_do_arquivo.ext                   | Adiciona o arquivo especificado à “area de staging”
git reset ARQUIVO                             | Remove os arquivos da área de staged
git restore --staged ARQUIVO                  | Remove os arquivos da área de staged
git rm --cached ARQUIVO                       |
git clean -d -f                               | Limpa todas as incosistências locais para o commit ser limpo
git commit -m “MENSAGEM”                      | Realizar um commit com uma mensagem que o identifique
git commit -m “MENSAGEM” -m "DETALHE"         | Realizar um commit com uma mensagem e um detalhe que o identifique
git commit --amend -m "nova mensagem"         | Altera a mensagem do commit alterior
git reset --soft HASH_COMMIT                  | Remove o commit e adiciona as alterações na área de staged
git reset --mixed HASH_COMMIT                 | Remove o commit e adiciona as alterações na área de untracked
git reset HASH_COMMIT                         | Remove o commit e adiciona as alterações na área de untracked
git reset --hard HASH_COMMIT                  | Remove o commit e exclui totalmente tudo que foi feito nesse commit
git branch -M main                            | Renomeia a branch principal
git push -u origin main                       | Envia as alterações do repositório local para o remoto na primeira vez
git pull                                      | Baixa ultima versão do repositório
git push                                      | Envia as modificações para o repositório remoto
git push origin main                          |
git log	                                      | Mostra os últimos commits do repositório atual
git reflog                                    | Mostra o histórico de todos os commits e seus status
git branch                                    | Lista as branch's do repositório
git branch -v                                 | Lista o último commit de cada branch
git branch -b NOVA_BRANCH                     | Cria uma branch chamada "NOVA_BRANCH" e entra nela
git branch -d NOME_BRANCH                     | Exclui a branch "NOME_BRANCH"
git checkout NOME_BRANCH                      | Entra na branch "NOME_BRANCH"
git merge BRANCH_NAO_PRINCIPAL                | Uni a branch que esta com a BRANCH_NAO_PRINCIPAL
git pull = git fetch + git merge              |
git fetch origin main                         |              
git diff branch_main origin/main             |
git stash                                      | Arquiva a modificação 
git stash list                                | Lista as modificações arquivadas
git stash pop                                 | Exclui a última modificação da pilha arquivada
git stash apply                               |


## Saiba Mais

* Convenção de branch
* Convenção de commits
