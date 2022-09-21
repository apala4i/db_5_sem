drop table if exists public.manufacturer;
create table public.manufacturer(
    id INT primary key,
    KPP TEXT,
    INN TEXT,
    reliablity INT CHECK(reliablity > 0 AND reliablity <= 10),
    distance INT CHECK(distance > 0),
    availability BOOLEAN
);

COPY public.manufacturer FROM 'C:\Users\Apala\university\db\csv\manufacturers.csv'
DELIMITER ','
CSV
HEADER
;