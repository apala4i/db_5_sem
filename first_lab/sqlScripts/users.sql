drop table if exists public.users;
create table public.users(
    id int primary key,
    name text,
    login text,
    email text,
    password text,
    city text
);

COPY users 
FROM 'C:\Users\Apala\university\db\csv\users.csv' delimiter ',' csv header;