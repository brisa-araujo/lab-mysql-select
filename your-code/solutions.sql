SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title, pubs.pub_name 
FROM publications.authors authors
INNER JOIN publications.titleauthor t_author
ON authors.au_id = t_author.au_id
INNER JOIN publications.titles titles
ON t_author.title_id = titles.title_id
INNER JOIN publications.publishers pubs
ON titles.pub_id = pubs.pub_id
ORDER BY authors.au_id;

SELECT authors.au_id, authors.au_lname, authors.au_fname, pubs.pub_name, COUNT(titles.title_id)
FROM publications.authors authors
INNER JOIN publications.titleauthor t_author
ON authors.au_id = t_author.au_id
INNER JOIN publications.titles 
ON t_author.title_id = titles.title_id
INNER JOIN publications.publishers pubs
ON titles.pub_id = pubs.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, pubs.pub_name
ORDER BY authors.au_id DESC;

SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty)
FROM publications.authors authors
INNER JOIN publications.titleauthor t_author
ON authors.au_id = t_author.au_id
INNER JOIN publications.sales
ON t_author.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(sales.qty) DESC LIMIT 3;

SELECT authors.au_id, authors.au_lname, authors.au_fname, IFNULL(SUM(sales.qty),0) as TOTAL
FROM publications.authors authors
LEFT JOIN publications.titleauthor t_author
ON authors.au_id = t_author.au_id
LEFT JOIN publications.sales
ON t_author.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(sales.qty) DESC;

SELECT authors.au_id, authors.au_lname, authors.au_fname, (SUM((titles.advance * titleauthor.royaltyper)+(((titles.price*sales.qty)*titles.royalty/100)*titleauthor.royaltyper))/100) as PROFIT
FROM publications.authors
INNER JOIN publications.titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN publications.titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publications.sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname 
ORDER BY PROFIT DESC LIMIT 3;