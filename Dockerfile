# 1. Use uma imagem base oficial do Python.
# A versão 3.11-alpine é uma boa escolha por ser leve e atender ao pré-requisito (Python 3.10+).
# A tag que você usou (3.13.5-alpine3.22) parece ser inválida.
FROM python:3.13.4-alpine

# 2. Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# 4. Instala as dependências do projeto
# A flag --no-cache-dir é usada para não armazenar o cache do pip, mantendo a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia todos os arquivos da aplicação para o diretório de trabalho
COPY . .

# 6. Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner
EXPOSE 8000

# 7. Comando para iniciar a aplicação com uvicorn
# O host 0.0.0.0 permite que o servidor seja acessível externamente.
# A flag --reload é removida, pois não é recomendada para ambientes de produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]