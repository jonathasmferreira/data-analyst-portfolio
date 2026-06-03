# 🗄️ S02 — JOIN entre duas tabelas

**Nível:** Básico
**Banco:** sakila

---

## 📋 Enunciado

### Conceitos abordados
`INNER JOIN`, qualificação de colunas (`tabela.coluna`), aliases (apelidos).

### Briefing
Dados reais raramente vivem em uma tabela só. `JOIN` combina linhas de duas (ou mais) tabelas com base em uma coluna em comum (geralmente chave estrangeira). `INNER JOIN` retorna apenas linhas que têm correspondência em ambos os lados. É **o conceito mais cobrado em entrevista técnica de SQL**.

📖 **Aprofundar:** [Mode Analytics — JOINs](https://mode.com/sql-tutorial/sql-joins/)

### Tarefa

Liste os **20 atores que mais aparecem em filmes**. Mostre nome completo do ator e a quantidade de filmes em que ele aparece.

- **Tabelas envolvidas:** `actor` e `film_actor`
- **Ordem:** do que mais aparece para o que menos aparece
- **Dica:** junte as tabelas pela `actor_id` e use `COUNT()` + `GROUP BY`

> 💡 **Antes de olhar a solução abaixo, tente resolver sozinho.** Se travar por mais de 15 minutos, leia o material do link, tente de novo, e só então olhe.

---

## ✅ Solução

```sql
USE sakila;

-- Os 20 atores que aparecem em mais filmes
SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS nome_ator,   -- junta nome e sobrenome
    COUNT(fa.film_id) AS qtd_filmes                         -- conta filmes do ator
FROM actor a                                                -- 'a' é apelido para a tabela actor
INNER JOIN film_actor fa                                    -- 'fa' apelido para film_actor
    ON a.actor_id = fa.actor_id                             -- condição de junção pela chave
GROUP BY a.actor_id, a.first_name, a.last_name              -- agrupa por ator
ORDER BY qtd_filmes DESC
LIMIT 20;
```

**Resultado esperado:** 20 linhas, com os atores mais frequentes aparecendo em ~40 filmes cada.

---

## 🧠 Conceitos-chave

- **`INNER JOIN ... ON ...`** — combina linhas onde a condição `ON` é verdadeira. Linhas sem correspondência são descartadas dos dois lados.
- **Aliases (apelidos de tabela)** — `actor a` é o mesmo que `actor AS a`. Aliases deixam queries com JOINs muito mais legíveis, especialmente quando há várias tabelas.
- **`tabela.coluna`** — quando duas tabelas têm colunas com o mesmo nome (como `actor_id`), você **precisa** dizer de qual tabela está vindo. Sem isso, o banco dá erro de ambiguidade.
- **`CONCAT(a, b, c)`** — junta textos. No MySQL é a função padrão (em outros bancos pode ser `||` ou `+`).
- **`GROUP BY` com múltiplas colunas** — todas as colunas que aparecem no `SELECT` (que não são agregações como `COUNT`) precisam estar no `GROUP BY`.

## ⚠️ Erros comuns

1. **Esquecer o `ON`** — sem condição de junção, o banco combina **cada linha de A com cada linha de B**, gerando milhões de linhas a mais que o esperado (produto cartesiano).
2. **Não dizer de qual tabela vem a coluna** — quando duas tabelas têm a mesma coluna, o banco fica confuso e dá erro. Sempre qualifique: `a.actor_id`, `fa.actor_id`.
3. **Contar a coluna errada** — `COUNT(*)` conta todas as linhas; `COUNT(coluna)` conta só linhas onde aquela coluna não é vazia. Em `INNER JOIN` dá no mesmo, mas saber a diferença ajuda em outros tipos de JOIN.
4. **Confundir `INNER JOIN` com `LEFT JOIN`** — `LEFT JOIN` mantém **todas** as linhas da tabela da esquerda, mesmo as sem correspondência. `INNER` só mantém as que casam.
5. **Esquecer colunas no `GROUP BY`** — no MySQL moderno, todas as colunas do SELECT que não são agregação precisam estar no GROUP BY, senão dá erro.

## 📚 Se errou, estude

- [Mode Analytics — JOINs](https://mode.com/sql-tutorial/sql-joins/)
