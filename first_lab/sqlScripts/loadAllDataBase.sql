DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\privileges.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\furniture_type.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\manufacturer.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\furniture.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\users.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\user_info.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\user_order.sql'
\i 'C:\\Users\\Apala\\university\\db\\sqlScripts\\order_furniture.sql'