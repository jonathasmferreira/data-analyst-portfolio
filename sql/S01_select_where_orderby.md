# 🗄️ S01 — SELECT, WHERE e ORDER BY

**Nível:** Básico
**Banco:** sakila

---

## 📋 Enunciado

### Conceitos abordados
Estrutura básica de consulta, filtro com `WHERE`, ordenação com `ORDER BY`, `LIMIT`.

### Briefing
Toda consulta SQL começa com `SELECT` (o que você quer ver) e `FROM` (de onde). `WHERE` filtra linhas. `ORDER BY` ordena. `LIMIT` corta o resultado. Esses 4 elementos respondem ~30% das perguntas que um analista faz em SQL.

📖 **Aprofundar:** [SQLBolt — Lessons 1-3](https://sqlbolt.com/lesson/select_queries_introduction)

### Tarefa

Escreva uma única consulta que retorne os **10 filmes mais longos** do banco Sakila, mostrando título e duração, mas apenas filmes com classificação `PG` ou `PG-13` (use o operador `IN`).

- **Colunas a exibir:** `title`, `length`, `rating`
- **Tabela:** `film`
- **Ordem:** do mais longo para o mais curto

> 💡 **Antes de olhar a solução abaixo, tente resolver sozinho.** Se travar por mais de 15 minutos, leia o material do link, tente de novo, e só então olhe.

---

## ✅ Solução

```sql
USE sakila;

-- Os 10 filmes mais longos com classificação PG ou PG-13
SELECT
    title,
    length,
    rating
FROM film
WHERE rating IN ('PG', 'PG-13')   -- filtro por múltiplos valores
ORDER BY length DESC              -- ordena do mais longo para o mais curto
LIMIT 10;                         -- retorna apenas as 10 primeiras linhas
```

**Resultado esperado:** uma tabela com 10 linhas, com filmes ordenados por `length` decrescente. Os mais longos do Sakila com essas classificações têm entre 180 e 185 minutos.

---

## 🧠 Conceitos-chave

- **`SELECT col1, col2`** — define quais colunas aparecem no resultado. **Evite `SELECT *`** em produção (puxa dados desnecessários e quebra análises se a tabela mudar).
- **`IN ('a', 'b', 'c')`** — equivalente a `coluna = 'a' OR coluna = 'b' OR coluna = 'c'`, mas mais limpo.
- **`ORDER BY ... DESC`** — `DESC` = decrescente (maior para menor), `ASC` = crescente (padrão se omitir).
- **`LIMIT N`** — corta o resultado. Sempre vem **depois** de `ORDER BY` para garantir que você está pegando os "top N" corretos.
- **`USE banco;`** — define o banco padrão da sessão. Sem isso, você tem que qualificar tabelas com `sakila.film` em cada query.

## ⚠️ Erros comuns

1. **Colocar `LIMIT` antes de `ORDER BY`** — não funciona. A ordem correta é sempre: filtrar (WHERE), agrupar (GROUP BY), ordenar (ORDER BY), limitar (LIMIT).
2. **Esquecer aspas em texto** — `WHERE rating IN (PG, PG-13)` dá erro. Texto em SQL sempre entre aspas simples: `'PG'`.
3. **Usar `==` em vez de `=`** — em SQL, comparação é com **um sinal de igual**, não dois.
4. **Confundir `IN` com `BETWEEN`** — `IN` é para uma lista de valores específicos; `BETWEEN x AND y` é para um intervalo numérico ou de datas.
5. **Esquecer o `USE sakila;`** — query funciona mesmo sem isso se a tabela tiver nome único, mas é boa prática deixar explícito qual banco você está usando.

## 📚 Se errou, estude

- [SQLBolt — Lessons 1-3](https://sqlbolt.com/lesson/select_queries_introduction)
