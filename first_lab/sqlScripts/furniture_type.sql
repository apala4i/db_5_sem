drop table if exists public.furniture_type;
create table public.furniture_type(
    id INT primary key,
    name text
);

COPY public.furniture_type FROM 'C:\Users\Apala\university\db\csv\types.csv'
DELIMITER ','
CSV
HEADER
;