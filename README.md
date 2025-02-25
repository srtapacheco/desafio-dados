# 📊 Desafio de Cientista de Dados - Análise e Tratamento de Dados

## 📌 Descrição do Projeto
Este repositório contém a solução do **Desafio de Cientista de Dados**, que consiste na **análise, estruturação e transformação de dados brutos** fornecidos no arquivo `dados_ficha_a_desafio.csv`. O objetivo foi identificar problemas nos dados, propor soluções e realizar o tratamento dos mesmos utilizando **Python, SQL e DBT**.


## 🎯 **Objetivos**
1. **Exploração e Análise dos Dados**:
   - Identificar características e padrões dos dados.
   - Apontar possíveis inconsistências e problemas.
   - Fazer inferências sobre a origem dos problemas.

2. **Tratamento e Padronização**:
   - Aplicar regras de limpeza e formatação dos dados.
   - Resolver inconsistências e normalizar valores.
   - Criar uma versão tratada e estruturada dos dados.

3. **Implementação no DBT**:
   - Criar um pipeline de transformação utilizando **DBT (Data Build Tool)**.
   - Modularizar o código SQL para facilitar a manutenção e a reprodutibilidade.

---

## 🛠️ Tecnologias Utilizadas
- **Python**: Para análise exploratória dos dados, utilizando `pandas` e `numpy`
- **SQL**: Para consultas e manipulação dos dados  
- **DBT (Data Build Tool)**: Para criação e padronização dos modelos de dados  
- **PostgreSQL**: Banco de dados utilizado para armazenamento e transformação  
- **Google Colab**: Para a execução e documentação da análise exploratória  

---

## 📂 Estrutura do Diretório
```bash
desafio-dados/
├── data/                              # Dados brutos e arquivos auxiliares
│   ├── dados_ficha_a_desafio.csv      # Dataset original
│   ├── descricao_de_campos.xlsx       # Descrição dos campos do dataset
│
├── dbt_project/                        # Projeto DBT para transformação de dados
│   ├── models/                         # Modelos SQL criados para transformação
│   ├── dbt_project.yml                  # Configuração do DBT
│
├── notebooks/                          # Notebooks para análise exploratória
│   ├── analysis.ipynb      # Notebook com exploração, analise e relatórios de desenvolvimento versao notebook jupter
│   ├── analysis.py      # Notebook com exploração mas na versao em python
│   ├── export_data.py      # Arquivo usado para importacao de dados no Postgres
│
├── sql/                                # Scripts SQL antes e depois da transformação
│   ├── raw_data.sql                # Dump do banco antes da limpeza
│   ├── processed_data.sql              # Dump do banco após a limpeza e transformação
│
├── README.md      
├── relatorio_desenvolvimento.pdf   # Relatorio versao pdf com analise e desenvolvimento do desafio
├── .gitignore                           
```

---

## 🔎 Análise dos Dados
A análise exploratória foi realizada utilizando Python e está documentada no notebook analise_exploratoria.ipynb. Caso queira visualizar o notebook, ele está disponível no repositório dentro da pasta \notebooks, e também é possível visualizar o arquivo em formato PDF (na raiz do diretorio). 

---

## 🔄 Transformação com DBT
A transformação dos dados foi feita utilizando **SQL e DBT**, garantindo um modelo padronizado e pronto para futuras análises. As principais mudanças incluem:

🔹 Conversão de tipagem de variáveis  
🔹 Padronização dos campos 
🔹 Normalização de categorias
🔹 Ajuste de valores inconsistentes  

O código SQL do modelo tratado pode ser encontrado dentro da pasta do projeto dbt [`dbt_project/models].

---

## 🚀 Como Executar o Projeto

### 📌 Requisitos
1. **Python** instalado (versão 3.8 ou superior)  
2. Banco de dados **PostgreSQL** configurado localmente  
3. **DBT** instalado (seguindo as instruções da documentação oficial)  

### 📌 Passos
1. Clone este repositório:
   ```bash
   git clone [https://github.com/srtapacheco/desafio-dados]
   https://github.com/srtapacheco/desafio-dados
   cd desafio-dados
   ```
2. Instale as dependências necessárias
3. Configurar Banco de Dados
No arquivo `profiles.yml`, configure as credenciais do banco de dados:

```yaml
default:
  outputs:
    dev:
      type: postgres
      host: "localhost"
      user: "seu_usuario"
      password: "sua_senha"
      dbname: "desafio_db"
      schema: "public"
      threads: 1
  target: dev
```

4. Executar o Pipeline DBT
Após configurar o banco, rode os seguintes comandos:

```bash
# Limpar cache do DBT
dbt clean

# Compilar os modelos
dbt compile

# Rodar o pipeline completo
dbt run --full-refresh
```

Após a execução, os dados tratados estarão disponíveis na tabela `public.mart_dados_finais`. 

Para fins de teste e validação, os arquivos de exportação do banco (antes e depois da limpeza) estão disponíveis na pasta \sql.

## 📊 **Validação dos Dados**
Após a transformação, realizei comparações entre os dados brutos e tratados para validar o pipeline. Algumas verificações incluem:
- **Comparação entre os valores antes e depois da transformação**.
- **Contagem de registros antes e depois para evitar perda de dados inesperada**.
- **Análise de estatísticas descritivas para garantir a consistência dos dados corrigidos**.

---

## 📜 Conclusão
Este projeto demonstrou como uma **boa análise de dados** pode revelar problemas importantes e permitir a **transformação estruturada** de um conjunto de dados, melhorando a performance, o armazenamento e a manipulação desses dados, além de garantir a veracidade e a coerência das informações extraídas dessas fontes de dados.
