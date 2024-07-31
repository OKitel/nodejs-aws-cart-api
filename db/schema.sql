CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE cart_status AS ENUM ('OPEN', 'ORDERED');

CREATE TABLE carts (
   id UUID PRIMARY KEY default uuid_generate_v4(),
   user_id UUID NOT NULL,
   created_at DATE NOT NULL,
   updated_at DATE NOT NULL,
   status cart_status NOT NULL
)

CREATE TABLE cart_items (
   cart_id UUID NOT NULL,
   product_id UUID NOT NULL,
   count INTEGER NOT NULL CHECK (count > 0),
   FOREIGN KEY (cart_id) REFERENCES carts(id)
);

CREATE TABLE users (
  id UUID PRIMARY KEY default uuid_generate_v4(),
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
  id UUID PRIMARY KEY default uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE NO ACTION,
  cart_id UUID NOT NULL REFERENCES carts(id) ON DELETE NO ACTION,
  payment JSON,
  delivery JSON,
  comments TEXT,
  status VARCHAR(10) DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'NO PAYMENT', 'CONFIRMED', 'IN PROGRESS', 'SHIPPED', 'COMPLETED', 'CANCELLED')),
  total NUMERIC(10, 2) NOT null,
  FOREIGN KEY (cart_id) REFERENCES carts(id)
);
