-- Sample Data for School Health Management System

-- Insert sample users
INSERT INTO users (username, password_hash, full_name, email, phone, role) VALUES
('admin', '$2y$10$..hashed_password..', 'Nguyễn Thị Mai', 'admin@truongthanhoa.edu.vn', '0987654321', 'admin'),
('nurse01', '$2y$10$..hashed_password..', 'Trần Văn Bình', 'nurse@truongthanhoa.edu.vn', '0976543210', 'health_staff'),
('parent01', '$2y$10$..hashed_password..', 'Lê Thị Hoa', 'hoa.le@gmail.com', '0965432109', 'parent'),
('parent02', '$2y$10$..hashed_password..', 'Phạm Văn Nam', 'nam.pham@gmail.com', '0954321098', 'parent'),
('teacher01', '$2y$10$..hashed_password..', 'Nguyễn Văn Tùng', 'tung.nguyen@truongthanhoa.edu.vn', '0943210987', 'teacher');

-- Insert sample students
INSERT INTO students (student_code, full_name, date_of_birth, gender, class_name, grade, address, parent_id, emergency_contact, blood_type) VALUES
('TH2024001', 'Lê Minh An', '2018-05-15', 'male', '6A1', '6', '123 Đường Trần Hưng Đạo, Thanh Hóa', 3, '0965432109', 'A'),
('TH2024002', 'Phạm Thị Bảo', '2017-08-20', 'female', '7B2', '7', '456 Đường Lê Lợi, Thanh Hóa', 4, '0954321098', 'O'),
('TH2024003', 'Nguyễn Văn Cường', '2018-12-10', 'male', '6A1', '6', '789 Đường Hai Bà Trưng, Thanh Hóa', 3, '0965432109', 'B');

-- Insert health records
INSERT INTO health_records (student_id, allergies, chronic_diseases, medical_history, vision_status, hearing_status, height, weight, bmi, blood_pressure, special_notes, created_by) VALUES
(1, 'Dị ứng tôm cua', 'Không có', 'Đã phẫu thuật amidan năm 2022', 'Bình thường 10/10', 'Bình thường', 125.5, 28.2, 17.9, '110/70', 'Cần chú ý chế độ ăn', 3),
(2, 'Dị ứng phấn hoa', 'Hen suyễn nhẹ', 'Điều trị hen suyễn thường xuyên', 'Cận thị nhẹ 8/10', 'Bình thường', 135.2, 32.8, 17.9, '105/65', 'Cần mang kính và có thuốc xịt hen suyễn', 4),
(3, 'Không có', 'Không có', 'Tiêm chủng đầy đủ theo lịch', 'Bình thường 10/10', 'Bình thường', 122.0, 25.5, 17.1, '108/68', 'Sức khỏe tốt', 3);

-- Insert vaccination types
INSERT INTO vaccinations (vaccination_name, description, recommended_age_months, is_mandatory) VALUES
('Vắc xin HPV', 'Phòng ngừa ung thư cổ tử cung', 132, TRUE),
('Vắc xin cúm mùa', 'Phòng ngừa cúm theo mùa', 72, FALSE),
('Vắc xin Td', 'Nhắc lại vắc xin bạch hầu - uốn ván', 120, TRUE),
('Vắc xin JE', 'Phòng ngừa viêm não Nhật Bản', 84, TRUE);

-- Insert vaccination records
INSERT INTO vaccination_records (student_id, vaccination_id, vaccination_date, batch_number, administrator, side_effects, status, parent_consent, notes, created_by) VALUES
(1, 1, '2024-03-15', 'HPV2024-001', 'Trần Văn Bình', 'Đau nhẹ tại chỗ tiêm', 'completed', TRUE, 'Tiêm thành công, học sinh nghỉ 30 phút theo dõi', 2),
(2, 2, '2024-10-20', 'FLU2024-002', 'Trần Văn Bình', 'Không có', 'completed', TRUE, 'Bình thường', 2),
(1, 2, '2024-11-15', 'FLU2024-003', NULL, NULL, 'scheduled', TRUE, 'Đã có đồng ý của phụ huynh', 2),
(3, 1, NULL, NULL, NULL, NULL, 'scheduled', FALSE, 'Chờ phụ huynh xác nhận', 2);

-- Insert medications
INSERT INTO medications (medication_name, generic_name, dosage_form, strength, manufacturer, expiry_date, storage_requirements, contraindications) VALUES
('Ventolin', 'Salbutamol', 'Inhaler', '100mcg/dose', 'GSK', '2025-12-31', 'Bảo quản nơi khô ráo, tránh ánh sáng', 'Dị ứng Salbutamol'),
('Paracetamol', 'Paracetamol', 'Tablet', '500mg', 'Pymepharco', '2025-06-30', 'Bảo quản dưới 30°C', 'Suy gan nặng'),
('Cetirizine', 'Cetirizine', 'Tablet', '10mg', 'Teva', '2025-08-15', 'Bảo quản nơi khô ráo', 'Dị ứng thành phần thuốc'),
('Ibuprofen', 'Ibuprofen', 'Suspension', '100mg/5ml', 'Abbott', '2025-04-20', 'Lắc đều trước khi dùng', 'Loét dạ dày');

-- Insert student medications
INSERT INTO student_medications (student_id, medication_id, dosage, frequency, duration_days, start_date, end_date, special_instructions, parent_provided, quantity_provided, quantity_remaining, status, created_by) VALUES
(2, 1, '2 nhát', 'Khi khó thở', NULL, '2024-09-01', NULL, 'Chỉ sử dụng khi có cơn hen suyễn, báo ngay cho y tế trường', TRUE, 1, 1, 'active', 4),
(1, 2, '1 viên', 'Khi sốt trên 38.5°C', 7, '2024-11-01', '2024-11-08', 'Cho uống khi sốt cao, cách nhau ít nhất 4 giờ', TRUE, 10, 8, 'active', 3),
(2, 3, '1 viên', 'Mỗi tối trước khi ngủ', 30, '2024-10-15', '2024-11-15', 'Uống cùng nước, không nhai', TRUE, 30, 15, 'active', 4);

-- Insert medical supplies
INSERT INTO medical_supplies (supply_name, category, unit_of_measure, current_stock, minimum_stock, unit_cost, supplier, expiry_date, storage_location) VALUES
('Băng gạc vô trùng', 'Dressing', 'Cuộn', 50, 10, 15000, 'Công ty Y tế ABC', '2025-12-31', 'Tủ thuốc chính'),
('Betadine', 'Antiseptic', 'Chai', 12, 3, 45000, 'Mundipharma', '2025-08-30', 'Tủ thuốc chính'),
('Thermometer điện tử', 'Equipment', 'Cái', 5, 2, 150000, 'Omron Healthcare', '2027-01-01', 'Phòng y tế'),
('Khẩu trang y tế', 'PPE', 'Hộp', 20, 5, 75000, 'Công ty TNHH DEF', '2025-06-30', 'Kho vật tư');

-- Insert medical events
INSERT INTO medical_events (student_id, event_type, event_date, description, symptoms, severity, treatment_given, medication_given, parent_notified, requires_followup, followup_notes, handled_by) VALUES
(1, 'accident', '2024-11-10 10:30:00', 'Học sinh bị ngã khi chạy trong giờ ra chơi', 'Đau đầu gối phải, có vết xước nhỏ', 'low', 'Vệ sinh vết thương, băng bó', 'Betadine', TRUE, FALSE, NULL, 2),
(2, 'illness', '2024-11-08 14:15:00', 'Học sinh có dấu hiệu khó thở trong giờ học thể dục', 'Khó thở, thở khò khè', 'medium', 'Cho ngồi nghỉ, sử dụng thuốc xịt hen suyễn', 'Ventolin 2 nhát', TRUE, TRUE, 'Cần theo dõi thêm, khuyên nghỉ thể dục 1 tuần', 2),
(3, 'illness', '2024-11-12 09:45:00', 'Học sinh sốt cao trong giờ học', 'Sốt 39°C, mệt mỏi, đau đầu', 'medium', 'Đo nhiệt độ, cho nghỉ ngơi, liên hệ phụ huynh', 'Paracetamol 500mg', TRUE, TRUE, 'Phụ huynh đón về, khuyên đi khám bác sĩ', 2);

-- Insert health checkups
INSERT INTO health_checkups (checkup_name, checkup_type, grade_levels, scheduled_date, checkup_items, status, created_by) VALUES
('Kiểm tra sức khỏe định kỳ học kỳ 1', 'semester', '["6", "7", "8", "9"]', '2024-11-20', '["height", "weight", "vision", "hearing", "dental", "blood_pressure"]', 'planned', 2),
('Kiểm tra sức khỏe đầu năm học', 'annual', '["6", "7", "8", "9", "10", "11", "12"]', '2024-09-15', '["height", "weight", "bmi", "vision", "hearing", "dental", "blood_pressure", "heart_rate"]', 'completed', 2);

-- Insert health checkup records
INSERT INTO health_checkup_records (checkup_id, student_id, checkup_date, height, weight, bmi, vision_left, vision_right, hearing_status, dental_status, blood_pressure, heart_rate, temperature, other_findings, recommendations, requires_followup, parent_notified, examiner_id) VALUES
(2, 1, '2024-09-16', 125.5, 28.2, 17.9, '10/10', '10/10', 'Bình thường', 'Tốt, không sâu răng', '110/70', 85, 36.5, 'Sức khỏe tốt', 'Duy trì chế độ ăn uống và tập luyện', FALSE, TRUE, 2),
(2, 2, '2024-09-16', 135.2, 32.8, 17.9, '8/10', '8/10', 'Bình thường', 'Có 1 răng sâu nhẹ', '105/65', 78, 36.3, 'Cận thị nhẹ, cần theo dõi', 'Khám mắt chuyên khoa, điều trị răng sâu', TRUE, TRUE, 2),
(2, 3, '2024-09-16', 122.0, 25.5, 17.1, '10/10', '10/10', 'Bình thường', 'Tốt', '108/68', 82, 36.4, 'Sức khỏe bình thường', 'Tiếp tục duy trì', FALSE, TRUE, 2);

-- Insert notifications
INSERT INTO notifications (recipient_id, student_id, notification_type, title, content, is_read, requires_response, response_deadline, parent_response, response_date) VALUES
(3, 1, 'vaccination_consent', 'Đồng ý tiêm chủng vắc xin cúm mùa', 'Kính gửi quý phụ huynh,\nTrường tổ chức tiêm chủng vắc xin cúm mùa cho học sinh. Xin quý phụ huynh xác nhận đồng ý cho con em mình tham gia.\n\nThời gian: 15/11/2024\nĐịa điểm: Phòng y tế trường\n\nXin phản hồi trước ngày 13/11/2024.', TRUE, TRUE, '2024-11-13', 'Tôi đồng ý cho con tham gia tiêm chủng', '2024-11-11 08:30:00'),

(4, 3, 'vaccination_consent', 'Đồng ý tiêm chủng vắc xin HPV', 'Kính gửi quý phụ huynh,\nTrường tổ chức tiêm chủng vắc xin HPV phòng ngừa ung thư cổ tử cung cho học sinh nữ. Xin quý phụ huynh xác nhận đồng ý.\n\nThời gian: 20/11/2024\nXin phản hồi trước ngày 18/11/2024.', FALSE, TRUE, '2024-11-18', NULL, NULL),

(3, 1, 'medical_event', 'Thông báo sự cố y tế', 'Kính gửi quý phụ huynh,\nCon em đã có một sự cố nhỏ tại trường:\n\nThời gian: 10/11/2024 lúc 10:30\nSự việc: Bị ngã khi chạy trong giờ ra chơi\nTình trạng: Đau đầu gối phải, có vết xước nhỏ\nXử lý: Đã vệ sinh vết thương và băng bó\n\nCon em hiện tại đã ổn định. Xin quý phụ huynh theo dõi thêm tại nhà.', TRUE, FALSE, NULL, NULL, NULL),

(4, 2, 'checkup_notice', 'Thông báo kiểm tra sức khỏe định kỳ', 'Kính gửi quý phụ huynh,\nTrường thông báo lịch kiểm tra sức khỏe định kỳ học kỳ 1:\n\nThời gian: 20/11/2024\nĐịa điểm: Phòng y tế trường\nNội dung kiểm tra: Chiều cao, cân nặng, thị lực, thính lực, răng miệng, huyết áp\n\nXin quý phụ huynh cho con đến trường đúng giờ.', FALSE, FALSE, NULL, NULL, NULL);

-- Insert school information
INSERT INTO school_info (school_name, school_address, phone, email, website, principal_name, health_room_location, emergency_procedures, school_year, total_students, updated_by) VALUES
('Trường THCS Thanh Hóa', '123 Đường Trần Phú, TP. Thanh Hóa, Thanh Hóa', '0237-3851234', 'info@truongthanhoa.edu.vn', 'www.truongthanhoa.edu.vn', 'Nguyễn Văn Đức', 'Tầng 1, Tòa nhà chính', 'Trong trường hợp khẩn cấp:\n1. Gọi 115 (Cấp cứu)\n2. Liên hệ phòng y tế: 0237-3851235\n3. Thông báo Ban Giám hiệu\n4. Liên hệ phụ huynh', '2024-2025', 1250, 1); 