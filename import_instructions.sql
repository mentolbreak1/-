-- ИНСТРУКЦИЯ ПО ИМПОРТУ ДАННЫХ
-- База данных: demo_2026_zayats
-- Выполнять в pgAdmin в порядке очередности

-- 1. Импорт групп
COPY groups(group_name, course_number, faculty, department)
FROM 'C:\путь_к_файлу\groups.csv'  -- ЗАМЕНИТЕ НА СВОЙ ПУТЬ
DELIMITER ';'
CSV HEADER;

-- 2. Импорт студентов
COPY students(first_name, last_name, middle_name, birth_date, email, phone, enrollment_date, group_id)
FROM 'C:\путь_к_файлу\students.csv'  -- ЗАМЕНИТЕ НА СВОЙ ПУТЬ
DELIMITER ';'
CSV HEADER;

-- 3. Импорт преподавателей
COPY teachers(first_name, last_name, middle_name, email, phone, department, position)
FROM 'C:\путь_к_файлу\teachers.csv'  -- ЗАМЕНИТЕ НА СВОЙ ПУТЬ
DELIMITER ';'
CSV HEADER;

-- 4. Импорт предметов
COPY subjects(subject_name, description, hours_total, department)
FROM 'C:\путь_к_файлу\subjects.csv'  -- ЗАМЕНИТЕ НА СВОЙ ПУТЬ
DELIMITER ';'
CSV HEADER;

-- 5. Импорт оценок
COPY grades(student_id, subject_id, teacher_id, grade_date, grade_value, grade_type)
FROM 'C:\путь_к_файлу\grades.csv'  -- ЗАМЕНИТЕ НА СВОЙ ПУТЬ
DELIMITER ';'
CSV HEADER;

-- Проверка после импорта
SELECT 'students' as table_name, COUNT(*) as count FROM students
UNION ALL
SELECT 'groups', COUNT(*) FROM groups
UNION ALL
SELECT 'teachers', COUNT(*) FROM teachers
UNION ALL
SELECT 'subjects', COUNT(*) FROM subjects
UNION ALL
SELECT 'grades', COUNT(*) FROM grades;
