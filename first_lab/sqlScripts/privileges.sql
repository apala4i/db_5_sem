drop table if exists public.privileges;
create table public.privileges(
    id INT primary key,
    name TEXT,
    personal_discount int
);

COPY public.privileges FROM 'C:\Users\Apala\university\db\csv\privileges.csv'
DELIMITER ','
CSV
HEADER
;