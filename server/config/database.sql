-- Path: server/config/database.sql

CREATE TABLE properties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    location VARCHAR(200) NOT NULL,
    area DECIMAL(10,2),
    bedrooms INT,
    bathrooms INT,
    property_type ENUM('house', 'apartment', 'land', 'commercial') NOT NULL,
    status ENUM('for_sale', 'for_rent', 'sold', 'rented') DEFAULT 'for_sale',
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE properties
ADD COLUMN user_id INT,
ADD FOREIGN KEY (user_id) REFERENCES users(id);

-- Path: server/config/database.sql

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'vendor') DEFAULT 'user',
    phone VARCHAR(20),
    address VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Path: server/config/database.sql

ALTER TABLE users MODIFY COLUMN role ENUM('buyer', 'seller') DEFAULT 'buyer';

-- Path: server/config/database.sql

ALTER TABLE users
ADD COLUMN reset_token VARCHAR(255),
ADD COLUMN reset_token_expires DATETIME;


ALTER TABLE properties MODIFY COLUMN price DECIMAL(15,2) NOT NULL;

CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    user_id INT NOT NULL,
    seller_id INT NOT NULL,
    date DATETIME NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (seller_id) REFERENCES users(id)
);

-- Insertar algunos datos de ejemplo
INSERT INTO properties (title, description, price, location, area, bedrooms, bathrooms, property_type, image_url) VALUES
('Modern Apartment in City Center', 'Beautiful modern apartment with great views', 250000.00, 'Downtown', 85.5, 2, 2, 'apartment', '/images/apartment1.jpg'),
('Spacious Family House', 'Perfect house for a growing family', 380000.00, 'Suburban Area', 180.0, 4, 3, 'house', '/images/house1.jpg'),
('Commercial Space', 'Prime location commercial property', 450000.00, 'Business District', 120.0, 0, 2, 'commercial', '/images/commercial1.jpg');