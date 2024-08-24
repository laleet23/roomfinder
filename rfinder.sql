-- Create database
CREATE DATABASE IF NOT EXISTS room_finder;
USE room_finder;

-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    user_type ENUM('seeker', 'provider') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Rooms Table
CREATE TABLE IF NOT EXISTS Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    price DECIMAL(10, 2) NOT NULL,
    available_from DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (provider_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Bookings Table
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    seeker_id INT,
    booking_date DATE,
    start_date DATE,
    end_date DATE,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Room Images Table
CREATE TABLE IF NOT EXISTS Room_Images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    seeker_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Favorites Table
CREATE TABLE IF NOT EXISTS Favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    seeker_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seeker_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer') NOT NULL,
    transaction_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Payment Methods Table
CREATE TABLE IF NOT EXISTS Payment_Methods (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    card_number VARCHAR(20),
    card_type ENUM('Visa', 'MasterCard', 'Amex'),
    expiry_date DATE,
    billing_address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Refunds Table
CREATE TABLE IF NOT EXISTS Refunds (
    refund_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    refund_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    refund_reason VARCHAR(255),
    status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id) ON DELETE CASCADE
);

-- Invoices Table
CREATE TABLE IF NOT EXISTS Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seeker_id INT,
    amount_due DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(10, 2),
    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE,
    status ENUM('unpaid', 'paid', 'overdue') DEFAULT 'unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (seeker_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
