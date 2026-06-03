# 🗄️ S03 — GROUP BY e funções de agregação

**Nível:** Básico
**Banco:** northwind

---

## 📋 Enunciado

### Conceitos abordados
`GROUP BY`, `COUNT`, `SUM`, `AVG`, `HAVING`, `DISTINCT`.

### Briefing
`GROUP BY` é o equivalente SQL do `groupby` do pandas. Você agrupa linhas que têm o mesmo valor em uma coluna e aplica uma agregação (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) em cada grupo. `HAVING` filtra grupos depois da agregação (diferente de `WHERE`, que filtra antes).

📖 **Aprofundar:** [Atlassian — HAVING vs WHERE](https://www.atlassian.com/data/sql/how-having-works)

### Tarefa

Liste todos os países dos clientes com:
- Quantidade de clientes
- Quantidade de pedidos feitos por clientes daquele país

Mostre apenas países que tenham **mais de 5 pedidos no total**. Ordene pelos países com mais pedidos primeiro.

- **Tabelas envolvidas:** `customers` e `orders`

> 💡 **Antes de olhar a solução abaixo, tente resolver sozinho.** Se travar por mais de 15 minutos, leia o material do link, tente de novo, e só então olhe.

---

## ✅ Solução

```sql
USE northwind;

-- Países com mais de 5 pedidos: quantos clientes e quantos pedidos
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id) AS qtd_clientes,   -- DISTINCT evita contar cliente duas vezes
    COUNT(o.order_id) AS qtd_pedidos
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country                                    -- agrupa por país
HAVING COUNT(o.order_id) > 5                          -- filtra grupos com MAIS de 5 pedidos
ORDER BY qtd_pedidos DESC;
```

**Resultado esperado:** lista de países com pelo menos 6 pedidos, ordenada por volume.

---

## 🧠 Conceitos-chave

- **`GROUP BY`** — agrupa linhas que têm o mesmo valor na(s) coluna(s) indicada(s). Cada grupo vira **uma linha** no resultado.
- **Funções de agregação** — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` operam **dentro** de cada grupo.
- **`COUNT(*)`** vs **`COUNT(col)`** vs **`COUNT(DISTINCT col)`**:
  - `COUNT(*)`: conta todas as linhas.
  - `COUNT(col)`: conta linhas onde a coluna não é vazia (não nula).
  - `COUNT(DISTINCT col)`: conta valores **únicos** da coluna. Essencial quando JOIN duplica registros.
- **`HAVING` vs `WHERE`**:
  - `WHERE` filtra **linhas individuais** antes do agrupamento.
  - `HAVING` filtra **grupos** depois do agrupamento.
  - Você não pode usar agregações (`COUNT`, `SUM`) em `WHERE`.
- **Ordem da query**: `FROM` → `JOIN` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY`.

## ⚠️ Erros comuns

1. **Usar `WHERE COUNT(*) > 5`** — não funciona. Para filtrar pelo resultado de uma agregação (como contagem), use `HAVING`, não `WHERE`.
2. **Esquecer `DISTINCT` ao contar clientes em JOIN** — se um cliente fez 10 pedidos, ele aparece 10 vezes no resultado do JOIN. Sem `DISTINCT`, você conta o mesmo cliente 10 vezes na coluna de "qtd_clientes".
3. **Colocar coluna no `SELECT` sem estar no `GROUP BY`** — o MySQL moderno dá erro. Toda coluna que não é agregação precisa estar no `GROUP BY`.
4. **Ordenar por coluna que não está no resultado** — funciona no MySQL, mas é considerado má prática. Sempre prefira ordenar por colunas/aliases visíveis no SELECT.
5. **Achar que `HAVING` substitui `WHERE`** — não. Use `WHERE` para filtros simples (mais rápido); `HAVING` só para filtros baseados em agregações.

## 📚 Se errou, estude

- [Atlassian — HAVING vs WHERE](https://www.atlassian.com/data/sql/how-having-works)
