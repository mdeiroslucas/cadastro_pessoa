
# 🛠 Projeto Delphi

Este projeto foi desenvolvido utilizando **Delphi 10.3** (ou superior), juntamente com a biblioteca **Request4Delphi** e o banco de dados **SQLite 3.47.2**.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado as seguintes ferramentas:

-   [**Delphi 10.3**](https://www.embarcadero.com/br/products/delphi/starter) (ou superior)
-   [**Request4Delphi**](https://github.com/viniciussanchez/RESTRequest4Delphi): Biblioteca para requisições HTTP
-   [**SQLite 3.47.2**](https://www.sqlite.org/download.html): Banco de dados utilizado no projeto

## 🗄 Banco de Dados

-   O projeto utiliza **SQLite 3.47.2**. Garanta que o driver SQLite esteja corretamente configurado no seu ambiente de desenvolvimento. Além disso, é necessário informar o endereço do arquivo.db dentro da unit DBConnection.

## 🎯 Funcionalidades

-   **Cadastro de Pessoas**: O sistema permite registrar, editar e excluir pessoas.
-   **Consulta por CEP**: Integração com API do VIACEP para consultar o CEP automaticamente.
-   **Validação de dados**: Implementa validações de campos como CPF, e-mail e data.

## 📝 Desafios Enfrentados

-   **Decisão sobre a modelagem da entidade Endereço**:  
    Durante o desenvolvimento, considerei a possibilidade de criar uma tabela separada para a entidade **Endereço**, de forma a seguir o princípio de normalização do banco de dados. No entanto, optei por mantê-la diretamente na classe **Pessoa**. A razão para essa escolha foi a preocupação com a performance, já que uma tabela separada exigiria a realização de _joins_ entre as tabelas, o que poderia comprometer o desempenho do sistema em consultas mais complexas ou com grandes volumes de dados.
    
-   **Experiência com o componente `TDLookupComboBox`**:  
    A utilização do componente `TDLookupComboBox` foi particularmente interessante. Diferentemente de outros componentes que fazem uso da propriedade `DataSource` para leitura de dados, o `TDLookupComboBox` utiliza a propriedade `ListSource`. Esse comportamento diferenciado requer uma abordagem específica para sua configuração e manipulação, o que representou um aprendizado valioso no contexto da implementação das funcionalidades relacionadas à escolha de valores em listas associadas.
    
-   **Validação dos campos no formulário**:  
    Inicialmente, minha intenção era iterar sobre todos os componentes `TEdit` presentes no painel principal do formulário, validando de maneira automatizada se algum deles estava vazio. A longo prazo, essa abordagem facilitaria a manutenção, especialmente em caso de futuras alterações nos campos de entrada. No entanto, após considerar os possíveis excessos de condições (excessivos `IFs`), optei por realizar a validação de cada campo individualmente, assegurando maior controle sobre o processo de verificação de cada dado inserido.

### Próximos Passos

1.  **Aprimoramento da exibição dos dados no DBGrid**:  
    Um dos próximos objetivos será melhorar a forma visual de exibição de campos como CPF, CEP e telefone no componente **DBGrid**. A formatação adequada desses dados facilitará a leitura e tornará a interface mais amigável e profissional.
    
2.  **Criação de uma tela especializada para consultas**:  
    Planeja-se a implementação de uma tela específica para realizar consultas, onde os usuários poderão utilizar filtros baseados nos _datasets_. Essa funcionalidade proporcionará uma experiência mais intuitiva para busca e filtragem de dados, aumentando a eficiência do uso do sistema.
    
3.  **Melhoria nos aspectos visuais da tela principal**:  
    Outro passo importante será o aprimoramento dos elementos visuais da tela principal. O objetivo é tornar a interface mais atraente e funcional, otimizando a experiência do usuário e garantindo uma apresentação mais moderna e coerente.


## 📄 Licença

Este projeto está sob a licença MIT.
