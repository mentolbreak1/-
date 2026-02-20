-- ПРОВЕРОЧНЫЕ ЗАПРОСЫ
-- База данных: demo_2026_zayats

-- 1. Проверка ссылочной целостности
-- Студенты без групп
SELECT COUNT(*) as students_without_groups 
FROM students 
WHERE group_id IS NULL;

-- Оценки без студентов
SELECT COUNT(*) as grades_without_students
FROM grades g
LEFT JOIN students s ON g.student_id = s.id
WHERE s.id IS NULL;

-- 2. Статистика по группам
SELECT 
    g.group_name,
    COUNT(DISTINCT s.id) as student_count,
    ROUND(AVG(gr.grade_value)::numeric, 2) as avg_grade
FROM groups g
LEFT JOIN students s ON g.id = s.group_id
LEFT JOIN grades gr ON s.id = gr.student_id
GROUP BY g.id, g.group_name
ORDER BY avg_grade DESC NULLS LAST;

-- 3. Преподаватели и их нагрузка
SELECT 
    t.last_name || ' ' || t.first_name as teacher,
    t.department,
    COUNT(DISTINCT gr.subject_id) as subjects_count,
    COUNT(gr.id) as grades_count
FROM teachers t
LEFT JOIN grades gr ON t.id = gr.teacher_id
GROUP BY t.id
ORDER BY grades_count DESC;

-- 4. Успеваемость по предметам
SELECT 
    sub.subject_name,
    sub.department,
    COUNT(DISTINCT gr.student_id) as students_count,
    ROUND(AVG(gr.grade_value)::numeric, 2) as avg_grade,
    MIN(gr.grade_value) as min_grade,
    MAX(gr.grade_value) as max_grade
FROM subjects sub
LEFT JOIN grades gr ON sub.id = gr.subject_id
GROUP BY sub.id
ORDER BY avg_grade DESC NULLS LAST;

-- 5. Динамика успеваемости по годам
SELECT 
    EXTRACT(YEAR FROM grade_date) as year,
    COUNT(*) as total_grades,
    ROUND(AVG(grade_value)::numeric, 2) as avg_grade,
    COUNT(CASE WHEN grade_value = 5 THEN 1 END) as excellent_count,
    COUNT(CASE WHEN grade_value = 2 THEN 1 END) as poor_count
FROM grades
GROUP BY EXTRACT(YEAR FROM grade_date)
ORDER BY year;
