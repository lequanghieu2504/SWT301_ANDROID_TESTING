-- School Health Management System Database Design
-- Total: 14 tables

-- 1. Users table - Quản lý người dùng hệ thống
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    role ENUM('admin', 'health_staff', 'parent', 'teacher') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Students table - Thông tin học sinh
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female') NOT NULL,
    class_name VARCHAR(20) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    address TEXT,
    parent_id INT,
    emergency_contact VARCHAR(20),
    blood_type VARCHAR(5),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES users(user_id)
);

-- 3. Health Records table - Hồ sơ sức khỏe học sinh
CREATE TABLE health_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    allergies TEXT,
    chronic_diseases TEXT,
    medical_history TEXT,
    vision_status VARCHAR(50),
    hearing_status VARCHAR(50),
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    bmi DECIMAL(4,2),
    blood_pressure VARCHAR(20),
    special_notes TEXT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- 4. Vaccinations table - Quản lý tiêm chủng
CREATE TABLE vaccinations (
    vaccination_id INT PRIMARY KEY AUTO_INCREMENT,
    vaccination_name VARCHAR(100) NOT NULL,
    description TEXT,
    recommended_age_months INT,
    is_mandatory BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Vaccination Records table - Lịch sử tiêm chủng của học sinh
CREATE TABLE vaccination_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    vaccination_id INT NOT NULL,
    vaccination_date DATE,
    batch_number VARCHAR(50),
    administrator VARCHAR(100),
    side_effects TEXT,
    status ENUM('scheduled', 'completed', 'postponed', 'declined') DEFAULT 'scheduled',
    parent_consent BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (vaccination_id) REFERENCES vaccinations(vaccination_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- 6. Medical Events table - Sự kiện y tế (tai nạn, bệnh tật, etc.)
CREATE TABLE medical_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    event_type ENUM('accident', 'illness', 'injury', 'emergency', 'outbreak') NOT NULL,
    event_date DATETIME NOT NULL,
    description TEXT NOT NULL,
    symptoms TEXT,
    severity ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    treatment_given TEXT,
    medication_given TEXT,
    parent_notified BOOLEAN DEFAULT FALSE,
    requires_followup BOOLEAN DEFAULT FALSE,
    followup_notes TEXT,
    handled_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (handled_by) REFERENCES users(user_id)
);

-- 7. Medications table - Danh mục thuốc
CREATE TABLE medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(100) NOT NULL,
    generic_name VARCHAR(100),
    dosage_form VARCHAR(50),
    strength VARCHAR(50),
    manufacturer VARCHAR(100),
    expiry_date DATE,
    storage_requirements TEXT,
    contraindications TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Student Medications table - Thuốc của học sinh (do phụ huynh gửi)
CREATE TABLE student_medications (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    frequency VARCHAR(100) NOT NULL,
    duration_days INT,
    start_date DATE NOT NULL,
    end_date DATE,
    special_instructions TEXT,
    parent_provided BOOLEAN DEFAULT TRUE,
    quantity_provided INT,
    quantity_remaining INT,
    status ENUM('active', 'completed', 'discontinued') DEFAULT 'active',
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- 9. Medical Supplies table - Vật tư y tế
CREATE TABLE medical_supplies (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    supply_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_of_measure VARCHAR(20),
    current_stock INT DEFAULT 0,
    minimum_stock INT DEFAULT 0,
    unit_cost DECIMAL(10,2),
    supplier VARCHAR(100),
    expiry_date DATE,
    storage_location VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Health Checkups table - Kiểm tra y tế định kỳ
CREATE TABLE health_checkups (
    checkup_id INT PRIMARY KEY AUTO_INCREMENT,
    checkup_name VARCHAR(100) NOT NULL,
    checkup_type ENUM('annual', 'semester', 'monthly', 'special') NOT NULL,
    grade_levels VARCHAR(100), -- JSON array of applicable grades
    scheduled_date DATE NOT NULL,
    checkup_items TEXT, -- JSON array of checkup items
    status ENUM('planned', 'ongoing', 'completed', 'cancelled') DEFAULT 'planned',
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- 11. Health Checkup Records table - Kết quả kiểm tra y tế của học sinh
CREATE TABLE health_checkup_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    checkup_id INT NOT NULL,
    student_id INT NOT NULL,
    checkup_date DATE NOT NULL,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    bmi DECIMAL(4,2),
    vision_left VARCHAR(20),
    vision_right VARCHAR(20),
    hearing_status VARCHAR(50),
    dental_status VARCHAR(100),
    blood_pressure VARCHAR(20),
    heart_rate INT,
    temperature DECIMAL(4,2),
    other_findings TEXT,
    recommendations TEXT,
    requires_followup BOOLEAN DEFAULT FALSE,
    followup_scheduled_date DATE,
    parent_notified BOOLEAN DEFAULT FALSE,
    examiner_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (checkup_id) REFERENCES health_checkups(checkup_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (examiner_id) REFERENCES users(user_id)
);

-- 12. Notifications table - Thông báo cho phụ huynh
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    recipient_id INT NOT NULL, -- user_id of parent
    student_id INT,
    notification_type ENUM('vaccination_consent', 'checkup_notice', 'medical_event', 'medication_reminder', 'general') NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    requires_response BOOLEAN DEFAULT FALSE,
    response_deadline DATE,
    parent_response TEXT,
    response_date DATETIME,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipient_id) REFERENCES users(user_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 13. School Information table - Thông tin trường học
CREATE TABLE school_info (
    info_id INT PRIMARY KEY AUTO_INCREMENT,
    school_name VARCHAR(200) NOT NULL,
    school_address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(100),
    principal_name VARCHAR(100),
    health_room_location VARCHAR(100),
    emergency_procedures TEXT,
    school_year VARCHAR(10),
    total_students INT,
    updated_by INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- 14. System Settings table - Cài đặt hệ thống
CREATE TABLE system_settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    description TEXT,
    category VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    updated_by INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- Create indexes for better performance
CREATE INDEX idx_students_parent ON students(parent_id);
CREATE INDEX idx_students_class ON students(class_name);
CREATE INDEX idx_health_records_student ON health_records(student_id);
CREATE INDEX idx_vaccination_records_student ON vaccination_records(student_id);
CREATE INDEX idx_medical_events_student ON medical_events(student_id);
CREATE INDEX idx_medical_events_date ON medical_events(event_date);
CREATE INDEX idx_student_medications_student ON student_medications(student_id);
CREATE INDEX idx_health_checkup_records_student ON health_checkup_records(student_id);
CREATE INDEX idx_notifications_recipient ON notifications(recipient_id);
CREATE INDEX idx_notifications_type ON notifications(notification_type);

-- Insert some sample data for system settings
INSERT INTO system_settings (setting_key, setting_value, description, category) VALUES
('vaccination_reminder_days', '7', 'Days before vaccination to send reminder', 'notifications'),
('checkup_reminder_days', '3', 'Days before health checkup to send reminder', 'notifications'),
('medication_low_stock_threshold', '10', 'Alert when medication stock is below this number', 'inventory'),
('default_checkup_items', '["height", "weight", "vision", "hearing", "dental", "blood_pressure"]', 'Default items for health checkups', 'checkups'),
('school_emergency_contact', '+84-xxx-xxx-xxx', 'Emergency contact number for the school', 'emergency'); 