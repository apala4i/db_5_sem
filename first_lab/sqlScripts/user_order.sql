drop table if exists public.user_order;
create table public.user_order(
    id INT primary key,
    fk_user INT REFERENCES users(id),
    price INT,
    creation_date DATE,
    address TEXT
);

COPY public.user_order FROM 'C:\Users\Apala\university\db\csv\order.csv'
DELIMITER ','
CSV
HEADER
;

-- columnNames = ["id", "fk_user", "price", "creation_date", "address"]