# Atividade de Gestão de Projetos de TI & Administração de Sistemas de Banco de Dados - 11/06/2026

Atividade prática de banco de dados com foco na **criação de Views**. Os dados utilizados são registros públicos de suicídios no Brasil entre 2010 e 2019, extraídos do arquivo CSV com auxílio de ferramentas de IA (ChatGPT e Claude).

## 📁 Arquivos do Repositório

```
📦 atividade-projeto-github
 ┣ 📄 suicidio.sql                 # Script SQL completo (tabelas, inserts e views)
 ┗ 📄 suicidios_2010_a_2019.csv    # Base de dados bruta fornecida pelo professor
```

---

## ✅ Pré-requisitos

- [MySQL](https://dev.mysql.com/downloads/mysql/) 8.0+
- Um cliente SQL: [MySQL Workbench](https://dev.mysql.com/downloads/workbench/), [DBeaver](https://dbeaver.io/) ou terminal

---

## ▶️ Como Executar

### Via terminal

```bash
# Clone o repositório
git clone https://github.com/Lorena-Pinheiro/atividade-projeto-github.git
cd atividade-projeto-github

# Execute o script
mysql -u seu_usuario -p < suicidio.sql
```

### Via MySQL Workbench ou DBeaver

1. Conecte-se ao servidor MySQL
2. Abra o arquivo `suicidio.sql`
3. Execute o script completo (`Ctrl + Shift + Enter`)

### Confirmar que funcionou

```sql
USE suicidio;
SHOW TABLES;
```

---

## 🗂️ Etapas de Elaboração do Projeto

### Etapa 1 — Criação do Banco de Dados

```sql
CREATE DATABASE suicidio;
USE suicidio;
```

---

### Etapa 2 — Criação das Tabelas

As tabelas foram fornecidas pelo professor.

**Tabelas de domínio** (criadas primeiro):

```sql
CREATE TABLE estados (
  id_estado    INT PRIMARY KEY AUTO_INCREMENT,
  sigla        VARCHAR(2) NOT NULL
);

CREATE TABLE estado_civil (
  id_estado_civil  INT PRIMARY KEY AUTO_INCREMENT,
  ds_estado_civil  VARCHAR(24) NOT NULL
);

CREATE TABLE escolaridade (
  id_escolaridade  INT PRIMARY KEY AUTO_INCREMENT,
  ds_escolaridade  VARCHAR(11) NOT NULL
);

CREATE TABLE causas (
  id_causa     INT PRIMARY KEY AUTO_INCREMENT,
  causasbas    VARCHAR(4),
  causasbas_o  VARCHAR(4)
);
```

**Tabela principal** (criada por último, pois referencia as outras):

```sql
CREATE TABLE suicidios (
  id_suicidio      BIGINT PRIMARY KEY AUTO_INCREMENT,
  ano              YEAR NOT NULL,
  dt_nasc          DATE,
  sexo             ENUM('Feminino','Masculino') NOT NULL,
  id_estado        INT NOT NULL,
  id_estado_civil  INT NOT NULL,
  id_escolaridade  INT NOT NULL,
  id_causa         INT NOT NULL,
  FOREIGN KEY (id_estado)        REFERENCES estados(id_estado),
  FOREIGN KEY (id_estado_civil)  REFERENCES estado_civil(id_estado_civil),
  FOREIGN KEY (id_escolaridade)  REFERENCES escolaridade(id_escolaridade),
  FOREIGN KEY (id_causa)         REFERENCES causas(id_causa)
);
```

---

### Etapa 3 — Inserção dos Dados

Os dados foram extraídos do arquivo `suicidios_2010_a_2019.csv` com auxílio de IA e inseridos nas tabelas.

```sql
INSERT INTO estados (sigla) VALUES
  ('AC'), ('AL'), ('AM'), ('AP'), ('BA'), ('CE'), ('DF'), ('ES'),
  ('GO'), ('MA'), ('MG'), ('MS'), ('MT'), ('PA'), ('PB'), ('PE'),
  ('PI'), ('PR'), ('RJ'), ('RN'), ('RO'), ('RR'), ('RS'), ('SC'),
  ('SE'), ('SP'), ('TO');

INSERT INTO estado_civil (ds_estado_civil) VALUES
  ('Casado/a'), ('Separado/a judicialmente'),
  ('Solteiro/a'), ('União consensual'), ('Viúvo/a');

INSERT INTO escolaridade (ds_escolaridade) VALUES
  ('1 a 3 anos'), ('12 e mais'), ('4 a 7 anos'),
  ('8 a 11 anos'), ('Nenhuma');

INSERT INTO causas (causasbas, causasbas_o) VALUES
  ('X749','X749'), ('X700','X700'), ('X630','X630'), ...;

-- Tabela principal referenciando os IDs das tabelas de domínio
INSERT INTO suicidios (ano, dt_nasc, sexo, id_estado, id_estado_civil, id_escolaridade, id_causa)
VALUES
  (2015, '1987-08-23', 'Masculino', 18, 3, 4, 1),
  (2014, '1979-10-04', 'Masculino', 14, 3, 3, 2), ...;
```

---

### Etapa 4 — Criação das Views

As views foram criadas com base nas consultas solicitadas pelo professor.

---

#### View 1 — Listar idade, sexo e estado de cada caso

```sql
CREATE VIEW idade_sexo_estado AS
  SELECT
    TIMESTAMPDIFF(YEAR, s.dt_nasc, CURDATE()) AS idade,
    s.sexo,
    e.sigla
  FROM suicidios s
  JOIN estados e ON e.id_estado = s.id_estado;
```

---

#### View 2 — Total de suicídios por estado

```sql
CREATE VIEW suicidio_por_estado AS
  SELECT
    COUNT(s.id_suicidio) AS total,
    e.sigla AS estado
  FROM suicidios s
  JOIN estados e ON e.id_estado = s.id_estado
  GROUP BY e.id_estado, e.sigla;
```

---

#### View 3 — Top 10 estados com mais casos

```sql
CREATE VIEW top_10_estados AS
  SELECT
    COUNT(s.id_suicidio) AS total,
    e.sigla AS estado
  FROM suicidios s
  JOIN estados e ON e.id_estado = s.id_estado
  GROUP BY e.id_estado, e.sigla
  ORDER BY total DESC
  LIMIT 10;
```

---

#### View 4 — Casos por nível de escolaridade

```sql
CREATE VIEW suicidio_por_escolaridade AS
  SELECT
    COUNT(s.id_suicidio) AS total,
    e.ds_escolaridade AS escolaridade
  FROM suicidios s
  JOIN escolaridade e ON e.id_escolaridade = s.id_escolaridade
  GROUP BY e.id_escolaridade, e.ds_escolaridade;
```

---

#### View 5 — Casos por estado civil

```sql
CREATE VIEW suicidio_por_estado_civil AS
  SELECT
    COUNT(s.id_suicidio) AS total,
    e.ds_estado_civil AS estado_civil
  FROM suicidios s
  JOIN estado_civil e ON e.id_estado_civil = s.id_estado_civil
  GROUP BY e.id_estado_civil, e.ds_estado_civil;
```

---

#### View 6 — Média de idade por estado

```sql
CREATE VIEW media_idade_estado AS
  SELECT
    FLOOR(AVG(TIMESTAMPDIFF(YEAR, s.dt_nasc, CURDATE()))) AS media_idade,
    e.sigla AS estado
  FROM suicidios s
  JOIN estados e ON e.id_estado = s.id_estado
  GROUP BY e.id_estado, e.sigla;
```

---

#### View 7 — Relatório completo por caso

```sql
CREATE VIEW relatorio AS
  SELECT
    e.sigla                                    AS estado,
    ec.ds_estado_civil                         AS estado_civil,
    es.ds_escolaridade                         AS escolaridade,
    CONCAT(c.causasbas, ' - ', c.causasbas_o) AS causas,
    COUNT(s.id_suicidio)                       AS quantidade_casos
  FROM suicidios s
  JOIN estados     e  ON e.id_estado        = s.id_estado
  JOIN estado_civil ec ON ec.id_estado_civil = s.id_estado_civil
  JOIN escolaridade es ON es.id_escolaridade = s.id_escolaridade
  JOIN causas       c  ON c.id_causa         = s.id_causa
  GROUP BY e.sigla, ec.ds_estado_civil, es.ds_escolaridade, c.causasbas, c.causasbas_o;
```
