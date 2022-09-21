drop table if exists public.furniture;
create table public.furniture(
    id INT primary key,
    name TEXT,
    fk_furniture_type INT REFERENCES furniture_type(id),
    fk_manufacturer INT REFERENCES manufacturer(id),
    price INT ,
    available_count INT,
    discount INT
);

COPY public.furniture FROM 'C:\Users\Apala\university\db\csv\furniture.csv'
DELIMITER ','
CSV
HEADER
;

-- ["id", "name", "fk_furniture_type", "fk_manufacturer", "price", "available_count", "discount"]