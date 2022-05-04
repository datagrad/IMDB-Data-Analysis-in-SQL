<details>
<summary>
  Q1. Find the total number of rows in each table of the schema?
  </summary>
<br>
Answer:
<br><br>
<pre>
### Alternative 1:
**Number of Rows after ignoring the Null Rows**

```
SELECT COUNT(*) AS "Number of Rows in Movie Table"
FROM movie;
```
> 7997

```
SELECT COUNT(*) AS "Number of Rows in Genre Table"
FROM genre;
```
> 14662


```

SELECT COUNT(*) AS "Number of Rows in director_mapping Table"
FROM director_mapping;
```
> 3867

```
SELECT COUNT(*) AS "Number of Rows in role_mapping Table"
FROM role_mapping;
```
> 15615


```

SELECT COUNT(*) AS "Number of Rows in names Table"
FROM names;
```
> 25735


```

SELECT COUNT(*) AS "Number of Rows in Ratings Table"
FROM ratings;
```
> 7997


### Alternative 2:
**Rows count inclusive of Null Rows:**

```
SELECT table_name, table_rows
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'imdb';
```
**ANSWER:**

>
>| 	 TABLE_NAME 	 | 	Tables_in_imdb	 |
>| 	----------- 	 | 	----------- 	 |
>| 	director_mapping	 | 	3867	 |
>| 	genre	 | 	14662	 |
>| 	movie	 | 	8519	 |
>| 	names	 | 	23714	 |
>| 	ratings	 | 	8230	 |
>| 	role_mapping	 | 	15173	 |



</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
<details>
<summary>
  Q1. Question
  </summary>
<br>
Answer:
<br><br>
<pre>


</details>

---

  
  
  
