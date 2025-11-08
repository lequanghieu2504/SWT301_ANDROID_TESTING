# School Health Management System - Database Design Documentation

## Overview
This database design consists of **14 tables** to support a comprehensive school health management system. The design follows normalization principles and includes proper relationships, indexes, and constraints.

## Database Tables and Their Purpose

### 1. Core User Management

#### `users` table
- **Purpose**: Manages all system users (admin, health staff, parents, teachers)
- **Key Features**: Role-based access control, secure password storage
- **Relationships**: Referenced by students (parent_id), health records, medical events, etc.

#### `students` table  
- **Purpose**: Store student information and link to parents
- **Key Features**: Unique student codes, class/grade tracking, emergency contacts
- **Relationships**: Links to parent through `parent_id`, central to all health-related tables

### 2. Health Records Management

#### `health_records` table
- **Purpose**: Store comprehensive health profiles submitted by parents
- **Coverage**: 
  - ✅ Allergies (dị ứng)
  - ✅ Chronic diseases (bệnh mãn tính) 
  - ✅ Medical history (tiền sử điều trị)
  - ✅ Vision status (thị lực)
  - ✅ Hearing status (thính lực)
  - ✅ Physical measurements (height, weight, BMI, blood pressure)

### 3. Vaccination Management

#### `vaccinations` table
- **Purpose**: Master list of available vaccines
- **Features**: Tracks recommended age, mandatory status, descriptions

#### `vaccination_records` table
- **Purpose**: Complete vaccination workflow management
- **Workflow Support**:
  - ✅ Parent consent tracking (`parent_consent`)
  - ✅ Scheduling (`status: scheduled`)
  - ✅ Administration tracking (`vaccination_date`, `administrator`)
  - ✅ Post-vaccination monitoring (`side_effects`, follow-up notes)

### 4. Medical Event Management

#### `medical_events` table
- **Purpose**: Record and handle medical incidents at school
- **Event Types**: Accidents, illnesses, injuries, emergencies, disease outbreaks
- **Features**:
  - ✅ Severity classification
  - ✅ Treatment documentation
  - ✅ Parent notification tracking
  - ✅ Follow-up requirement flags

### 5. Medication Management

#### `medications` table
- **Purpose**: Master medication database
- **Features**: Drug information, storage requirements, contraindications

#### `student_medications` table
- **Purpose**: Track medications sent by parents for students
- **Features**:
  - ✅ Dosage and frequency tracking
  - ✅ Quantity monitoring (provided vs remaining)
  - ✅ Parent-provided medication flag
  - ✅ Administration scheduling

#### `medical_supplies` table
- **Purpose**: Inventory management for medical supplies
- **Features**: Stock tracking, expiry monitoring, supplier information

### 6. Health Checkup Management

#### `health_checkups` table
- **Purpose**: Plan and organize periodic health checkups
- **Features**: Schedule checkups by grade level, define checkup items

#### `health_checkup_records` table
- **Purpose**: Store individual student checkup results
- **Workflow Support**:
  - ✅ Comprehensive health measurements
  - ✅ Abnormality detection (`requires_followup`)
  - ✅ Parent notification (`parent_notified`)
  - ✅ Consultation scheduling (`followup_scheduled_date`)

### 7. Communication System

#### `notifications` table
- **Purpose**: Handle all parent-school communications
- **Notification Types**:
  - ✅ Vaccination consent requests
  - ✅ Health checkup notices  
  - ✅ Medical event alerts
  - ✅ Medication reminders
- **Features**: Response tracking, deadlines, read status

### 8. System Configuration

#### `school_info` table
- **Purpose**: Store school information for homepage and system
- **Content**: School details, emergency procedures, contact information

#### `system_settings` table
- **Purpose**: Configurable system parameters
- **Examples**: Reminder schedules, stock thresholds, default checkup items

## How the Design Addresses Requirements

### ✅ Homepage & School Information
- `school_info` table stores all school information
- Can be extended with additional tables for health documents and blog posts

### ✅ Parent Health Profile Declaration  
- `health_records` table captures all required health information
- Linked to students and can be updated by parents (tracked via `created_by`)

### ✅ Parent Medication Submission
- `student_medications` table tracks parent-provided medications
- Includes dosage, frequency, quantity, and special instructions
- Supports quantity tracking for proper administration

### ✅ Medical Event Processing
- `medical_events` table handles all types of health incidents
- Tracks treatment, severity, parent notification, and follow-up needs
- Links to staff member who handled the event

### ✅ Medical Supply Management
- `medications` and `medical_supplies` tables for inventory
- Stock level monitoring and expiry tracking
- Used in conjunction with medical event treatment

### ✅ Vaccination Workflow
- Complete workflow from consent to post-vaccination monitoring:
  1. **Consent**: `notifications` table for consent requests
  2. **Student List**: Query `vaccination_records` with `status='scheduled'`
  3. **Administration**: Update records with vaccination details
  4. **Monitoring**: Track side effects and follow-up

### ✅ Health Checkup Workflow  
- Complete workflow from notification to follow-up:
  1. **Notification**: `notifications` for checkup notices
  2. **Student List**: `health_checkups` with grade-level filtering
  3. **Examination**: `health_checkup_records` for results
  4. **Follow-up**: Consultation scheduling for abnormal findings

### ✅ User Profile & History Management
- `users` table for profile management
- All health-related tables link to students for complete history
- Audit trails with `created_at`, `updated_at` timestamps

### ✅ Dashboard & Reporting
- Rich data structure supports various analytics:
  - Vaccination coverage rates
  - Health checkup completion status  
  - Medical event trends
  - Medication inventory levels
  - Parent response rates

## Database Relationships

```
users (1) -----> (n) students
students (1) --> (1) health_records
students (1) --> (n) vaccination_records  
students (1) --> (n) medical_events
students (1) --> (n) student_medications
students (1) --> (n) health_checkup_records
students (1) --> (n) notifications

vaccinations (1) --> (n) vaccination_records
medications (1) --> (n) student_medications
health_checkups (1) --> (n) health_checkup_records
```

## Performance Considerations

### Indexes Created:
- Student-based queries (most common)
- Date-based filtering for events and checkups
- Parent notification queries
- Class/grade-based filtering

### Scalability Features:
- Soft deletes using `is_active` flags
- Timestamp tracking for audit trails
- Configurable system settings
- Normalized design prevents data duplication

## Security Considerations

1. **Password Security**: Hashed passwords in `users` table
2. **Role-Based Access**: User roles control feature access
3. **Audit Trails**: Created/updated timestamps and user tracking
4. **Data Integrity**: Foreign key constraints maintain consistency

This database design provides a solid foundation for the school health management system while maintaining flexibility for future enhancements and ensuring data integrity. 