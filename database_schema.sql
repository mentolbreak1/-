-- Скрипт создания базы данных demo_2026_zayats
-- СУБД: PostgreSQL

-- Создание базы данных
CREATE DATABASE demo_2026_zayats
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- Подключение к созданной базе данных
\c demo_2026_zayats;

-- Таблица groups (учебные группы)
CREATE TABLE IF NOT EXISTS groups (
    id SERIAL PRIMARY KEY,
    group_name VARCHAR(20) UNIQUE NOT NULL,
    course_number INTEGER NOT NULL CHECK (course_number > 0 AND course_number <= 4),
    faculty VARCHAR(100) NOT NULL,
    department VARCHAR(100)
);

-- Таблица students (студенты)
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    birth_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    enrollment_date DATE NOT NULL,
    group_id INTEGER REFERENCES groups(id) ON DELETE SET NULL
);

-- Таблица teachers (преподаватели)
CREATE TABLE IF NOT EXISTS teachers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL
);

-- Таблица subjects (предметы)
CREATE TABLE IF NOT EXISTS subjects (
    id SERIAL PRIMARY KEY,
    subject_name VARCHAR(200) UNIQUE NOT NULL,
    description TEXT,
    hours_total INTEGER NOT NULL CHECK (hours_total > 0),
    department VARCHAR(100) NOT NULL
);

-- Таблица grades (оценки)
CREATE TABLE IF NOT EXISTS grades (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    subject_id INTEGER NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
    teacher_id INTEGER NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
    grade_date DATE NOT NULL,
    grade_value INTEGER NOT NULL CHECK (grade_value >= 2 AND grade_value <= 5),
    grade_type VARCHAR(20) NOT NULL CHECK (grade_type IN ('экзамен', 'зачет', 'курсовая работа'))
);

-- Создание индексов для оптимизации запросов
CREATE INDEX idx_students_group ON students(group_id);
CREATE INDEX idx_grades_student ON grades(student_id);
CREATE INDEX idx_grades_subject ON grades(subject_id);
CREATE INDEX idx_grades_teacher ON grades(teacher_id);
CREATE INDEX idx_grades_date ON grades(grade_date);
