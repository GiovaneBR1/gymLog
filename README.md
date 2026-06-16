# GymLog

O GymLog é um aplicativo desenvolvido em Flutter para o gerenciamento prático e organizado de rotinas de exercícios físicos.


## FUNCIONALIDADES


* Gerenciamento de Treinos: Criação e organização de rotinas de treino estruturadas pelos dias da semana (Segunda a Domingo).
* Catálogo de Exercícios: Integração com a API Ninjas para a busca de exercícios, com suporte a filtragem por grupo muscular.
* Controle de Séries: Configuração customizável da quantidade de séries e repetições para cada exercício da rotina.
* Armazenamento Local: Utilização de banco de dados local para manter o histórico de treinos acessível de forma offline.
* Acessibilidade e Personalização: Suporte a internacionalização (Português e Inglês) e opção de alternância nativa entre tema claro e tema escuro.


## TECNOLOGIAS E ARQUITETURA


O projeto foi construído utilizando os princípios de Clean Architecture, garantindo a separação de responsabilidades com o código organizado em camadas como core, domain, data e presentation.

As principais bibliotecas e ferramentas utilizadas incluem:
* Framework: Flutter com adoção do Material Design 3.
* Gerenciamento de Estado: Riverpod (flutter_riverpod e riverpod_annotation) para gerenciamento de estado reativo e injeção de dependências.
* Navegação: GoRouter (go_router) para o roteamento declarativo entre as telas.
* Persistência de Dados: SQLite (sqflite) para o armazenamento relacional dos treinos e shared_preferences para as configurações locais do usuário.
* Networking e Dados: Dio (dio) para chamadas HTTP à API externa e json_serializable para a geração automática da serialização de dados.
* Testes: O projeto conta com cobertura de testes de unidade, testes de widget para validação de interface e testes de integração de fluxo completo.


## COMO EXECUTAR


Para executar o projeto localmente, certifique-se de ter o ambiente Flutter devidamente configurado em sua máquina e siga as instruções abaixo:

1. Clone o repositório e navegue até o diretório raiz do projeto.
2. Instale as dependências executando o comando: 
   flutter pub get
3. Gere os arquivos de código automático (necessários para o Riverpod e manipulação de JSON) com o comando: 
   dart run build_runner build -d
4. Execute o aplicativo em um emulador ou dispositivo conectado com o comando: 
   flutter run


## AUTORES


Desenvolvido por Giovane, Matheus Iuri, Matheus Alexander, Matheus Ramos, Alexandre, Higor Assmé.