drop table if exists public.user_info;
create table public.user_info(
    id INT primary key,
    fk_favorite_furniture_type INT REFERENCES furniture_type(id),
    purchase_sum INT CHECK(purchase_sum > 0),
    last_visit_date TIMESTAMP,
    birthday DATE,
    privileges_id INT,
    fk_user INT REFERENCES users(id)
);

COPY public.user_info FROM 'C:\Users\Apala\university\db\csv\users_info.csv'
DELIMITER ','
CSV
HEADER
;

-- ["id", "favorite_furniture_type", "purchase_sum", "last_visit_date", "birthday", "privelegies_id", "user_id"]