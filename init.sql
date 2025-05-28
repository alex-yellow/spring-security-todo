-- Роли пользователей
CREATE TABLE roles (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(50) UNIQUE NOT NULL
);

-- Пользователи
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(100) UNIQUE NOT NULL,
                       password VARCHAR(100) NOT NULL
);

-- Связь пользователь-роли
CREATE TABLE user_roles (
                            user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
                            role_id INTEGER REFERENCES roles(id) ON DELETE CASCADE,
                            PRIMARY KEY (user_id, role_id)
);

-- Задачи
CREATE TABLE tasks (
                       id SERIAL PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       description TEXT,
                       completed BOOLEAN DEFAULT FALSE,
                       user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

-- Добавление ролей
INSERT INTO roles (name) VALUES
                             ('ROLE_USER'),
                             ('ROLE_ADMIN');

-- Добавление пользователей (пароли пока простые, будут заменены Spring Security)
INSERT INTO users (username, password) VALUES
                                           ('admin', 'admin123'),
                                           ('user', 'user123');

-- Назначение ролей
INSERT INTO user_roles (user_id, role_id) VALUES
                                              (1, 2), -- admin -> ROLE_ADMIN
                                              (2, 1); -- user -> ROLE_USER

-- Пример задач
INSERT INTO tasks (title, description, completed, user_id) VALUES
                                                               ('Setup Spring Boot Project', 'Initialize project structure and dependencies.', false, 1),
                                                               ('Create Security Config', 'Configure Spring Security for login', false, 2);