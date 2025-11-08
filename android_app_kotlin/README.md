# School Health Management System - Database Design

## 📋 Overview

This is a comprehensive database design for a school health management system (**Phần mềm quản lý y tế học đường**) with exactly **14 tables** that covers all the requirements mentioned.

## 🗄️ Database Schema Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    SCHOOL HEALTH MANAGEMENT SYSTEM          │
│                           (14 Tables)                       │
└─────────────────────────────────────────────────────────────┘

┌───────────────┐    ┌─────────────────┐    ┌──────────────────┐
│     users     │────│    students     │────│  health_records  │
│  (All users)  │    │  (Student info) │    │ (Health profiles)│
└───────────────┘    └─────────────────┘    └──────────────────┘
        │                      │                      
        │                      ├──────────────────────────────┐
        │                      │                              │
        │                      ▼                              ▼
        │            ┌─────────────────┐         ┌─────────────────┐
        │            │ medical_events  │         │student_medications│
        │            │ (Incidents)     │         │(Parent-sent meds)│
        │            └─────────────────┘         └─────────────────┘
        │                      │                              │
        │                      │                              │
        │                      ▼                              ▼
        │            ┌─────────────────┐         ┌─────────────────┐
        │            │ notifications   │         │  medications    │
        │            │(Parent comms)   │         │ (Medicine DB)   │
        │            └─────────────────┘         └─────────────────┘
        │                      
        │                      
        ▼                      
┌─────────────────┐    ┌─────────────────┐    ┌──────────────────┐
│vaccination_records│   │health_checkups │    │health_checkup_   │
│ (Vaccination     │   │(Checkup plans)  │────│    records       │
│   history)       │   └─────────────────┘    │(Checkup results) │
└─────────────────┘                           └──────────────────┘
        │                      
        │                      
        ▼                      
┌─────────────────┐    ┌─────────────────┐    ┌──────────────────┐
│  vaccinations   │    │medical_supplies │    │   school_info    │
│ (Vaccine types) │    │(Medical inventory)   │ (School details) │
└─────────────────┘    └─────────────────┘    └──────────────────┘
                                               
                       ┌─────────────────┐    
                       │system_settings  │    
                       │(Configuration)  │    
                       └─────────────────┘    
```

## 📁 File Structure

```
📦 school-health-management-db/
├── 📄 database_design.sql          # Complete database schema (14 tables)
├── 📄 sample_data.sql              # Vietnamese sample data
├── 📄 database_documentation.md    # Detailed documentation
└── 📄 README.md                    # This file
```

## ✅ Requirements Coverage

| Requirement | Database Solution | Status |
|-------------|------------------|---------|
| **Homepage & School Info** | `school_info` table | ✅ |
| **Health Profile Declaration** | `health_records` table | ✅ |
| **Parent Medication Submission** | `student_medications` table | ✅ |
| **Medical Event Processing** | `medical_events` table | ✅ |
| **Medical Supply Management** | `medications` + `medical_supplies` | ✅ |
| **Vaccination Workflow** | `vaccinations` + `vaccination_records` + `notifications` | ✅ |
| **Health Checkup Workflow** | `health_checkups` + `health_checkup_records` + `notifications` | ✅ |
| **User & History Management** | `users` + all related tables | ✅ |
| **Dashboard & Reports** | All tables provide rich analytics data | ✅ |

## 🔄 Key Workflows Supported

### 1. Vaccination Process
```sql
-- 1. Send consent notification
INSERT INTO notifications (recipient_id, notification_type, title, content, requires_response, response_deadline)

-- 2. Get students with consent
SELECT s.* FROM students s 
JOIN vaccination_records vr ON s.student_id = vr.student_id 
WHERE vr.parent_consent = TRUE AND vr.status = 'scheduled'

-- 3. Record vaccination
UPDATE vaccination_records SET 
    vaccination_date = CURRENT_DATE,
    administrator = 'Nurse Name',
    status = 'completed'

-- 4. Monitor side effects
UPDATE vaccination_records SET side_effects = 'Description' WHERE ...
```

### 2. Health Checkup Process
```sql
-- 1. Plan checkup
INSERT INTO health_checkups (checkup_name, checkup_type, grade_levels, scheduled_date)

-- 2. Send notifications to parents
INSERT INTO notifications (notification_type, title, content) 
SELECT 'checkup_notice', 'Health Checkup Notice', '...'

-- 3. Record results
INSERT INTO health_checkup_records (checkup_id, student_id, height, weight, vision_left, ...)

-- 4. Flag follow-ups
UPDATE health_checkup_records SET requires_followup = TRUE, 
    followup_scheduled_date = '2024-12-01' WHERE vision_left < '8/10'
```

### 3. Medical Event Handling
```sql
-- 1. Record incident
INSERT INTO medical_events (student_id, event_type, event_date, description, severity)

-- 2. Document treatment
UPDATE medical_events SET treatment_given = '...', medication_given = '...'

-- 3. Notify parents
INSERT INTO notifications (recipient_id, notification_type, title, content)

-- 4. Track follow-up if needed
UPDATE medical_events SET requires_followup = TRUE, followup_notes = '...'
```

## 📊 Sample Queries for Dashboard/Reports

### Vaccination Coverage
```sql
SELECT 
    v.vaccination_name,
    COUNT(CASE WHEN vr.status = 'completed' THEN 1 END) as completed,
    COUNT(CASE WHEN vr.status = 'scheduled' THEN 1 END) as scheduled,
    COUNT(*) as total
FROM vaccinations v
LEFT JOIN vaccination_records vr ON v.vaccination_id = vr.vaccination_id
GROUP BY v.vaccination_id, v.vaccination_name;
```

### Medical Events by Month
```sql
SELECT 
    DATE_FORMAT(event_date, '%Y-%m') as month,
    event_type,
    COUNT(*) as event_count
FROM medical_events 
WHERE event_date >= '2024-01-01'
GROUP BY month, event_type
ORDER BY month DESC;
```

### Students Requiring Follow-up
```sql
SELECT 
    s.full_name,
    s.class_name,
    hcr.checkup_date,
    hcr.recommendations,
    hcr.followup_scheduled_date
FROM students s
JOIN health_checkup_records hcr ON s.student_id = hcr.student_id
WHERE hcr.requires_followup = TRUE 
    AND hcr.followup_scheduled_date >= CURRENT_DATE;
```

## 🚀 Getting Started

1. **Create Database**
   ```sql
   CREATE DATABASE school_health_management;
   USE school_health_management;
   ```

2. **Run Schema**
   ```bash
   mysql -u username -p school_health_management < database_design.sql
   ```

3. **Load Sample Data**
   ```bash
   mysql -u username -p school_health_management < sample_data.sql
   ```

## 🔒 Security Features

- **Password Hashing**: Secure password storage
- **Role-Based Access**: Admin, health staff, parent, teacher roles
- **Audit Trails**: Created/updated timestamps
- **Data Integrity**: Foreign key constraints
- **Soft Deletes**: `is_active` flags for data preservation

## 📈 Performance Optimizations

- **Strategic Indexes**: On frequently queried columns
- **Normalized Design**: Prevents data duplication
- **Efficient Relationships**: Proper foreign key structure
- **Query Optimization**: Sample queries included

## 🌟 Key Features

- ✅ **Complete Workflow Support**: From notification to follow-up
- ✅ **Parent Communication**: Consent requests, event notifications
- ✅ **Inventory Management**: Medications and medical supplies
- ✅ **Comprehensive Health Records**: All required health information
- ✅ **Analytics Ready**: Rich data structure for reports
- ✅ **Vietnamese Context**: Sample data in Vietnamese
- ✅ **Scalable Design**: Supports growth and additional features

---

**Database Designer**: AI Assistant  
**Total Tables**: 14  
**Vietnamese Sample Data**: ✅  
**Documentation**: Complete