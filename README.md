### Criando um virtual environment

É preciso criar um [ambiente virtual] na pasta home do projeto.

- `python3 -m venv venv` ou
- `py -3.8 -m venv venv` para Bash no Windows. 

O **virtual environment deve ser ativado toda vez que você abrir o projeto** através do comando:
- `source venv/bin/activate` no Linux ou
- `source venv/Scripts/activate` em bash no Windows, ou ainda
- `.\venv\Scripts\activate.ps1` no Windows PowerShell

Garanta que você está na pasta onde o ambiente virtual foi criado. Se ele for ativado corretamente, o terminal terá uma flag apontando ***(venv)*** na frente do nome do usuário antes de cada comando. Para desativar o ambiente virtual, basta rodar: 

- `deactivate`.

### Instalando as bibliotecas do projeto

O próximo passo é instalar as bibliotecas listadas no arquivo **requirements.txt.** Isso pode ser executado através do [pip](https://pypi.org/project/pip/):

- `pip install -r requirements.txt` ou
- `python -m pip install -r requirements.txt` para alguns casos em que o comando anterior não funciona.

Para conferir se todas as bibliotecas foram instaladas corretamente, utilize `pip list` e valide as bibliotecas e suas respectivas versões listadas.


### Configurando o *profiles.yml*

Também, para poder rodar o dbt, é preciso configurar o seu arquivo [profiles.yml](https://docs.getdbt.com/dbt-cli/configure-your-profile/). 
Se você já tem o dbt instalado no seu computador, este arquivo pode ser encontrado na pasta (oculta) **.dbt** do seu usuário local (`~/.dbt/profiles.yml` ou `C:\Users\your-user\.dbt\profiles.yml`).

Caso você ainda não tenha o dbt instalado ou se o arquivo **profiles.yml** ainda não existir, crie-o da forma que preferir e configure-o de acordo com a necessidade.

### Atualizando o projeto na branch de desenvolvimento
Para esse projeto foi utilizado o GitHub como repositório.
Antes de rodar o dbt, é interessante que o seu **repo local esteja atualizado com a branch de desenvolvimento.** Quando o repo remoto é clonado, o git automaticamente clona a branch principal do projeto (*main*). 
Para que o projeto fique **atualizado com a branch * feature/development ***, basta rodar um `git pull`:

- `git pull origin feature/development`

## Data warehouse
Para este projeto foi utilizado o Google BigQuery como data Warehouse. 
Configure uma conta na plataforma da GCloud (https://cloud.google.com/) e em seguida crie um projeto para o data Warehouse. 
É importante que, para conseguir fazer a conexão entre dbt e BigQuery, seja criada na GCloud uma chave jason em Conta de Serviço no projeto específico. 


## Rodando o dbt
Para iniciar o projeto e, se necessário, configurar o **profiles.yml** e o **dbt_project.yml**, execute o comando abaixo e siga as etapas apresentadas no prompet de comando para conexão com o BigQuery:
- ‘dbt init’ 

Para confirmar se o **profiles.yml** e o **dbt_project.yml** estão configurados e rodando corretamente, além de verificar novamente as dependências e as conexões necessárias. Para isso, o comando a ser executado é:
- `dbt debug`
Garantido que todas as configurações estejam funcionando corretamente, é possível iniciar o carregamento e a transformação dos dados.
As etapas de carregamento e transformação são endereçadas à ***GCloud ***. 
Para instalar os pacotes descritos no arquivo *packages.yml*, pode-se rodar:
- `dbt deps`

### Modelos:
O processo para rodar os modelos pode ser feito de diversas maneiras, seja de forma modular (um modelo específico de cada vez), de forma a rodar todos os modelos de uma única vez, ou ainda de outras formas. Abaixo estão descritos os códigos para cada comando:

*O comando abaixo roda todos os modelos de uma única vez:*
- `dbt run --full-refresh`
*Para rodar apenas o modelo especificado:*
- `dbt run -m modelo_que_quer_rodar`
*Para rodar o modelo especificado e todos os modelos dos quais esse modelo depende para ser gerado:*
- `dbt run -m +modelo_que_quer_rodar`
*Para rodar o modelo especificado e todos os modelos que são impactados por ele:*
- `dbt run -m modelo_que_quer_rodar+`

### Testes
Os testes são modelados para garantir a qualidade dos dados. Para rodá-los, basta:
- `dbt test`

#### Gerando o dbt docs

O dbt fornece uma maneira simples de gerar documentação para o projeto e renderizá-lo como um site, o **dbt docs**.
Para gerar a documentação, deve-se utilizar o comando:
- `dbt docs generate` 
Esse comando vai gerar uma pasta **target**. Essa pasta em si vira a documentação. Para visualizar o **dbt Docs**, ou seja, interpretar a pasta target, deve-se usar:
- `dbt docs serve` - que hospeda um servidor local e monta a documentação.
