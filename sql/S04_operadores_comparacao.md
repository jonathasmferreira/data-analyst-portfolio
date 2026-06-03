# 🗄️ S04 — Filtros com operadores de comparação

**Nível:** Básico
**Banco:** sakila

---

## 📋 Enunciado

### Conceitos abordados
`LIKE`, `BETWEEN`, `IS NULL`, `IS NOT NULL`, operadores combinados.

### Briefing
Além de `=`, `>`, `<`, SQL tem operadores específicos para casos comuns: `LIKE` para busca de padrões em texto (com `%` curinga), `BETWEEN` para intervalos numéricos/datas, e `IS NULL` / `IS NOT NULL` para verificar ausência de valor. Atenção: **não use `= NULL`** — não funciona.

📖 **Aprofundar:** [W3Schools — SQL Operators](https://www.w3schools.com/sql/sql_operators.asp)

### Tarefa

Liste todos os filmes onde:
- O título começa com a letra "S" (use `LIKE 'S%'`)
- A duração está entre 60 e 120 minutos (use `BETWEEN`)
- O campo `original_language_id` é nulo (use `IS NULL`)

- **Colunas a exibir:** `title`, `length`, `rating`
- **Ordem:** por título alfabeticamente

> 💡 **Antes de olhar a solução abaixo, tente resolver sozinho.** Se travar por mais de 15 minutos, leia o material do link, tente de novo, e só então olhe.

---

## ✅ Solução

```sql
USE sakila;

-- Filmes que começam com S, duram entre 60-120 min, sem idioma original definido
SELECT
    title,
    length,
    rating
FROM film
WHERE title LIKE 'S%'                       -- começa com S (% = qualquer coisa depois)
  AND length BETWEEN 60 AND 120             -- entre 60 e 120 (inclusivo nos dois lados)
  AND original_language_id IS NULL          -- é nulo (NÃO use = NULL!)
ORDER BY title ASC;
```

**Resultado esperado:** filmes começando com "S", duração entre 60-120 min, com original_language_id vazio. No Sakila, a maioria dos filmes tem `original_language_id` nulo, então o filtro principal é o `LIKE` e o `BETWEEN`.

---

## 🧠 Conceitos-chave

- **`LIKE`** — busca por padrão em texto. `%` significa "qualquer sequência de caracteres". Exemplos:
  - `'S%'` → começa com S
  - `'%S'` → termina com S
  - `'%S%'` → contém S em qualquer posição
  - `'_at'` → exatamente 3 letras: qualquer 1 letra + "at" (`_` = exatamente 1 caractere)
- **`BETWEEN x AND y`** — inclui ambos os limites. `BETWEEN 60 AND 120` aceita o 60 e o 120.
- **`IS NULL` / `IS NOT NULL`** — `NULL` é especial em SQL. Você **NÃO pode** usar `= NULL` ou `!= NULL` — sempre retorna nada. Tem que ser `IS NULL` ou `IS NOT NULL`.
- **`AND` e `OR`** — combinam condições. `AND` exige que todas sejam verdadeiras; `OR` exige pelo menos uma. Sempre que misturar os dois, use parênteses para clareza.
- **Quebrar query em várias linhas** — não é só estética. Facilita revisão, debug, e versionamento (cada filtro fica em uma linha).

## ⚠️ Erros comuns

1. **Usar `= NULL`** — sempre retorna nada (nem verdadeiro nem falso). O comportamento correto é `IS NULL`.
2. **Confundir `LIKE` com `=`** — `LIKE 'João'` sem `%` funciona como `=`, mas é mais lento (o banco tenta interpretar curingas). Use `=` quando não houver curinga.
3. **Esquecer maiúsculas/minúsculas em `LIKE`** — no MySQL padrão, `LIKE` é case-insensitive em colunas com collation comum (busca por 'S%' também acha 's%'). Mas isso varia — em produção, sempre teste.
4. **Achar que `BETWEEN` exclui os limites** — ele **inclui**. `BETWEEN 1 AND 10` aceita o 1 e o 10.
5. **Misturar `AND` e `OR` sem parênteses** — `A AND B OR C` pode dar resultado diferente de `(A AND B) OR C` ou `A AND (B OR C)`. Use parênteses para evitar bugs.

## 📚 Se errou, estude

- [W3Schools — SQL Operators](https://www.w3schools.com/sql/sql_operators.asp)
