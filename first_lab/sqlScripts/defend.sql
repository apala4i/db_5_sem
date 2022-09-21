drop table if exists public.defend;
create table public.defend(
    id INT primary key,
    fk_user INT REFERENCES users(id),
    name text
);

COPY public.defend FROM 'C:\Users\Apala\university\db\csv\defend.csv'
DELIMITER ','
CSV
HEADER
;