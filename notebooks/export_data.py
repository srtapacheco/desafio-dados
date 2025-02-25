import pandas as pd
from sqlalchemy import create_engine

caminho_csv = r'C:\Users\karen\Downloads\Cientista de Dados\desafio-dados\data\dados_ficha_a_desafio.csv'
df = pd.read_csv(caminho_csv)

# Conectar ao MySQL
engine = create_engine('postgresql://postgres:25884466@localhost:5432/desafio_db')

# Enviar os dados para a tabela no MySQL
df.to_sql('dados_brutos', engine, index=False, if_exists='replace')

print("Dados importados com sucesso!")
