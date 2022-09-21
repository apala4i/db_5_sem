drop table if exists order_furniture;
create table order_furniture (
    fk_order INT REFERENCES user_order(id),
    fk_furniture INT REFERENCES furniture(id),
    qty INT CHECK (qty > 0),
    PRIMARY KEY (fk_order, fk_furniture)
)
;

COPY order_furniture FROM 'C:\Users\Apala\university\db\csv\order_furniture.csv'
DELIMITER ','
HEADER
CSV
;

-- ["fk_order", "fk_furniture"]