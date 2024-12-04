-- Ödev 1
-- 1. Film tablosunda bulunan title ve description sütunlarındaki verileri sıralama
SELECT title, description
FROM film;

-- 2. Film tablosunda bulunan tüm sütunlardaki verileri, film uzunluğu (length) 60'dan büyük VE 75'ten küçük olma koşuluyla sıralama
SELECT *
FROM film
WHERE length > 60 AND length < 75;

-- 3. Film tablosunda bulunan tüm sütunlardaki verileri, rental_rate 0.99 VE replacement_cost 12.99 VEYA 28.99 olma koşuluyla sıralama
SELECT *
FROM film
WHERE rental_rate = 0.99 
  AND (replacement_cost = 12.99 OR replacement_cost = 28.99);

-- 4. Customer tablosunda bulunan first_name sütunundaki değeri 'Mary' olan müşterinin last_name sütunundaki değeri
SELECT last_name
FROM customer
WHERE first_name = 'Mary';

-- 5. Film tablosundaki uzunluğu (length) 50'den büyük OLMAYIP, aynı zamanda rental_rate değeri 2.99 veya 4.99 OLMAYAN verileri sıralama
SELECT *
FROM film
WHERE length <= 50 
  AND rental_rate NOT IN (2.99, 4.99);

-- Ödev 2
-- 1. Film tablosunda bulunan tüm sütunlardaki verileri, replacement cost değeri 12.99'dan büyük eşit ve 16.99'dan küçük olma koşuluyla sıralama (BETWEEN - AND yapısı kullanılarak)
SELECT *
FROM film
WHERE replacement_cost BETWEEN 12.99 AND 16.99;

-- 2. Actor tablosunda bulunan first_name ve last_name sütunlarındaki verileri, first_name 'Penelope' veya 'Nick' veya 'Ed' değerleri olması koşuluyla sıralama (IN operatörü kullanılarak)
SELECT first_name, last_name
FROM actor
WHERE first_name IN ('Penelope', 'Nick', 'Ed');

-- 3. Film tablosunda bulunan tüm sütunlardaki verileri, rental_rate 0.99, 2.99, 4.99 VE replacement_cost 12.99, 15.99, 28.99 olma koşuluyla sıralama (IN operatörü kullanılarak)
SELECT *
FROM film
WHERE rental_rate IN (0.99, 2.99, 4.99)
  AND replacement_cost IN (12.99, 15.99, 28.99);

-- Ödev 3
-- 1. Country tablosunda bulunan country sütunundaki ülke isimlerinden 'A' karakteri ile başlayıp 'a' karakteri ile sonlananları sıralama
SELECT country
FROM country
WHERE country LIKE 'A%a';

-- 2. Country tablosunda bulunan country sütunundaki ülke isimlerinden en az 6 karakterden oluşan ve sonu 'n' karakteri ile sonlananları sıralama
SELECT country
FROM country
WHERE LENGTH(country) >= 6 AND country LIKE '%n';

-- 3. Film tablosunda bulunan title sütunundaki film isimlerinden en az 4 adet büyük ya da küçük harf farketmesizin 'T' karakteri içeren film isimlerini sıralama
SELECT title
FROM film
WHERE LOWER(title) LIKE '%t%' 
GROUP BY title
HAVING LENGTH(REPLACE(LOWER(title), 't', '')) <= LENGTH(title) - 4;

-- 4. Film tablosunda bulunan tüm sütunlardaki verilerden title 'C' karakteri ile başlayan ve uzunluğu (length) 90'dan büyük olan ve rental_rate 2.99 olan verileri sıralama
SELECT *
FROM film
WHERE title LIKE 'C%' 
  AND length > 90
  AND rental_rate = 2.99;

-- Ödev 4
-- 1. Film tablosunda bulunan replacement_cost sütununda bulunan birbirinden farklı değerleri sıralama
SELECT DISTINCT replacement_cost
FROM film;

-- 2. Film tablosunda bulunan replacement_cost sütununda birbirinden farklı kaç tane veri vardır?
SELECT COUNT(DISTINCT replacement_cost) AS unique_replacement_cost_count
FROM film;

-- 3. Film tablosunda bulunan film isimlerinde (title) kaç tanesi T karakteri ile başlar ve aynı zamanda rating 'G' ye eşittir?
SELECT COUNT(*)
FROM film
WHERE title LIKE 'T%' AND rating = 'G';

-- 4. Country tablosunda bulunan ülke isimlerinden (country) kaç tanesi 5 karakterden oluşmaktadır?
SELECT COUNT(*)
FROM country
WHERE LENGTH(country) = 5;

-- 5. City tablosundaki şehir isimlerinin kaç tanesi 'R' veya 'r' karakteri ile biter?
SELECT COUNT(*)
FROM city
WHERE city LIKE '%r' OR city LIKE '%R';

-- Ödev 5
-- 1. Film tablosunda bulunan ve film ismi (title) 'n' karakteri ile biten en uzun (length) 5 filmi sıralama
SELECT *
FROM film
WHERE title LIKE '%n'
ORDER BY length DESC
LIMIT 5;

-- 2. Film tablosunda bulunan ve film ismi (title) 'n' karakteri ile biten en kısa (length) ikinci(6,7,8,9,10) 5 filmi sıralama
SELECT *
FROM film
WHERE title LIKE '%n' AND length IN (6, 7, 8, 9, 10)
ORDER BY length ASC
LIMIT 5;

-- 3. Customer tablosunda bulunan last_name sütununa göre azalan yapılan sıralamada store_id 1 olmak koşuluyla ilk 4 veriyi sıralama
SELECT *
FROM customer
WHERE store_id = 1
ORDER BY last_name DESC
LIMIT 4;

-- Ödev 6
-- 1. Film tablosunda bulunan rental_rate sütunundaki değerlerin ortalaması nedir?
SELECT AVG(rental_rate) AS average_rental_rate
FROM film;

-- 2. Film tablosunda bulunan filmlerden kaç tanesi 'C' karakteri ile başlar?
SELECT COUNT(*)
FROM film
WHERE title LIKE 'C%';

-- 3. Film tablosunda bulunan filmlerden rental_rate değeri 0.99'a eşit olan en uzun (length) film kaç dakikadır?
SELECT MAX(length) AS longest_movie_length
FROM film
WHERE rental_rate = 0.99;

-- 4. Film tablosunda bulunan filmlerin uzunluğu 150 dakikadan büyük olanlarına ait kaç farklı replacement_cost değeri vardır?
SELECT COUNT(DISTINCT replacement_cost) AS unique_replacement_cost_count
FROM film
WHERE length > 150;

--Ödev 7
-- 1. Film tablosunda bulunan filmleri rating değerlerine göre gruplayıp sıralama
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 2. Film tablosunda bulunan filmleri replacement_cost sütununa göre grupladığımızda film sayısı 50'den fazla olan replacement_cost değerini ve karşılık gelen film sayısını sıralama
SELECT replacement_cost, COUNT(*) AS film_count
FROM film
GROUP BY replacement_cost
HAVING COUNT(*) > 50;

-- 3. Customer tablosunda bulunan store_id değerlerine karşılık gelen müşteri sayıları
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id;

-- 4. City tablosunda bulunan şehir verilerini country_id sütununa göre gruplandırdıktan sonra en fazla şehir sayısı barındıran country_id bilgisini ve şehir sayısını paylaşma
SELECT country_id, COUNT(*) AS city_count
FROM city
GROUP BY country_id
ORDER BY city_count DESC
LIMIT 1;

-- Ödev 8
-- 1. Employee Tablosunu Oluşturma
CREATE TABLE employee (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    birthday DATE,
    email VARCHAR(100)
);

-- 2. Mockaroo Servisini Kullanarak Veri Eklemek (50 veri satırı olacak şekilde dışa aktarın ve ekleyin)
INSERT INTO employee (id, name, birthday, email) VALUES
(1, 'John Doe', '1980-01-15', 'johndoe@example.com'),
(2, 'Jane Smith', '1990-03-22', 'janesmith@example.com'),
(3, 'Alice Johnson', '1985-04-30', 'alice.johnson@example.com'),
(4, 'Bob Brown', '1992-07-12', 'bob.brown@example.com'),
(5, 'Charlie White', '1988-09-04', 'charlie.white@example.com'),
(6, 'David Green', '1995-11-23', 'david.green@example.com'),
(7, 'Eva Black', '1990-02-18', 'eva.black@example.com'),
(8, 'Frank Blue', '1986-03-09', 'frank.blue@example.com'),
(9, 'Grace Purple', '1993-05-25', 'grace.purple@example.com'),
(10, 'Hannah Pink', '1989-08-11', 'hannah.pink@example.com'),
-- (40 veri satırınız olacak şekilde devam edin)
;

-- 3. UPDATE İşlemleri (5 Adet)
-- 1. Adı 'John Doe' olan kullanıcının doğum tarihini güncelleme
UPDATE employee
SET birthday = '1985-05-20'
WHERE name = 'John Doe';

-- 2. 'Jane Smith' adlı kullanıcının e-posta adresini güncelleme
UPDATE employee
SET email = 'jane.smith@newdomain.com'
WHERE name = 'Jane Smith';

-- 3. 'Mockaroo' e-posta adresine sahip tüm kullanıcıların doğum tarihini güncelleme
UPDATE employee
SET birthday = '1992-11-10'
WHERE email LIKE '%@mockaroo.com%';

-- 4. 1980 doğumlu tüm kullanıcıların adını güncelleme
UPDATE employee
SET name = 'Updated Name'
WHERE birthday = '1980-01-15';

-- 5. Email adresi 'example.com' olan kullanıcıların adlarını 'Example User' olarak değiştirme
UPDATE employee
SET name = 'Example User'
WHERE email LIKE '%example.com';

-- 4. DELETE İşlemleri (5 Adet)
-- 1. 'John Doe' olan kullanıcının kaydını silme
DELETE FROM employee
WHERE name = 'John Doe';

-- 2. Doğum tarihi 1990-03-22 olan kullanıcının kaydını silme
DELETE FROM employee
WHERE birthday = '1990-03-22';

-- 3. 'mockaroo.com' domainine sahip e-posta adresi olan kullanıcıyı silme
DELETE FROM employee
WHERE email LIKE '%@mockaroo.com%';

-- 4. Email adresi 'janesmith@example.com' olan kullanıcıyı silme
DELETE FROM employee
WHERE email = 'janesmith@example.com';

-- 5. Adı 'Updated Name' olan tüm kullanıcıları silme
DELETE FROM employee
WHERE name = 'Updated Name';

-- Ödev 9 
-- 1. City ve Country Tablosu ile Şehir (city) ve Ülke (country) İsimlerini Görebileceğimiz INNER JOIN Sorgusu:
SELECT c.city, co.country
FROM city c
INNER JOIN country co ON c.country_id = co.country_id;

-- 2. Customer ve Payment Tablosu ile Payment ID, Customer'ın First Name ve Last Name İsimlerini Görebileceğimiz INNER JOIN Sorgusu:
SELECT cu.first_name, cu.last_name, p.payment_id
FROM customer cu
INNER JOIN payment p ON cu.customer_id = p.customer_id;

-- 3. Customer ve Rental Tablosu ile Rental ID, Customer'ın First Name ve Last Name İsimlerini Görebileceğimiz INNER JOIN Sorgusu:
SELECT cu.first_name, cu.last_name, r.rental_id
FROM customer cu
INNER JOIN rental r ON cu.customer_id = r.customer_id;

-- Ödev 10
-- 1. City ve Country Tablosu ile Şehir (city) ve Ülke (country) İsimlerini Görebileceğimiz LEFT JOIN Sorgusu:
SELECT c.city, co.country
FROM city c
LEFT JOIN country co ON c.country_id = co.country_id;

-- 2. Customer ve Payment Tablosu ile Payment ID, Customer'ın First Name ve Last Name İsimlerini Görebileceğimiz RIGHT JOIN Sorgusu:
SELECT cu.first_name, cu.last_name, p.payment_id
FROM customer cu
RIGHT JOIN payment p ON cu.customer_id = p.customer_id;

-- 3. Customer ve Rental Tablosu ile Rental ID, Customer'ın First Name ve Last Name İsimlerini Görebileceğimiz FULL JOIN Sorgusu:
SELECT cu.first_name, cu.last_name, r.rental_id
FROM customer cu
FULL JOIN rental r ON cu.customer_id = r.customer_id;

-- Ödev 11
-- 1. Actor ve Customer Tabloarında Bulunan First Name Sütunları İçin Tüm Verileri Sıralama:
SELECT a.first_name
FROM actor a
UNION
SELECT c.first_name
FROM customer c;

-- 2. Actor ve Customer Tablolarında Bulunan First Name Sütunları İçin Kesişen Verileri Sıralama:
SELECT a.first_name
FROM actor a
INTERSECT
SELECT c.first_name
FROM customer c;

-- 3. Actor ve Customer Tablolarında Bulunan First Name Sütunları İçin İlk Tabloda Bulunan Ama İkinci Tabloda Olmayan Verileri Sıralama:
SELECT a.first_name
FROM actor a
EXCEPT
SELECT c.first_name
FROM customer c;

-- 4. İlk 3 Sorguyu Tekrar Eden Veriler İçin Sıralama (Tüm Veriler):
SELECT a.first_name
FROM actor a
UNION ALL
SELECT c.first_name
FROM customer c;

-- 5. İlk 3 Sorguyu Tekrar Eden Veriler İçin Kesişen Veriler:
SELECT a.first_name
FROM actor a
INTERSECT ALL
SELECT c.first_name
FROM customer c;

-- 6. İlk 3 Sorguyu Tekrar Eden Veriler İçin İlk Tabloda Bulunan Ama İkinci Tabloda Olmayan Veriler:
SELECT a.first_name
FROM actor a
EXCEPT ALL
SELECT c.first_name
FROM customer c;

--Ödev 12
-- 1. Film Tablosunda Film Uzunluğu (Length) Sütununda Gösterilmektedir. Uzunluğu Ortalama Film Uzunluğundan Fazla Kaç Tane Film Vardır?
SELECT COUNT(*) 
FROM film 
WHERE length > (SELECT AVG(length) FROM film);

-- 2. Film Tablosunda En Yüksek Rental Rate Değerine Sahip Kaç Tane Film Vardır?
SELECT COUNT(*) 
FROM film 
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);

-- 3. Film Tablosunda En Düşük Rental Rate ve En Düşük Replacement Cost Değerlerine Sahip Filmleri Sıralayınız:
SELECT title, rental_rate, replacement_cost
FROM film 
WHERE rental_rate = (SELECT MIN(rental_rate) FROM film)
AND replacement_cost = (SELECT MIN(replacement_cost) FROM film);

-- 4. Payment Tablosunda En Fazla Sayıda Alışveriş Yapan Müşterileri (Customer) Sıralayınız:
SELECT c.first_name, c.last_name, COUNT(p.payment_id) AS num_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY num_payments DESC;
