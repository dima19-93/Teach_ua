USE teachua;

SET FOREIGN_KEY_CHECKS = 0;

create table `archive` (`id` bigint not null auto_increment, `class_name` varchar(255) not null, `data` TEXT not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `categories` (`id` bigint not null auto_increment, `background_color` varchar(255), `name` varchar(255) not null, `tag_background_color` varchar(255), tag_text_color varchar(255), `url_logo` varchar(255), primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `centers` (`id` bigint not null auto_increment, `address` varchar(255), `description` varchar(255), `email` varchar(255), `latitude` float(53), `longitude` float(53), `name` varchar(255) not null, `phones` varchar(255), `social_links` varchar(255), `url_logo` varchar(255), `url_web` varchar(255), `user_id` bigint, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `cities` (`id` bigint not null auto_increment, `latitude` float(53), `longitude` float(53), `name` varchar(255) not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `club_category` (`club_id` bigint not null, `category_id` bigint not null, primary key (`club_id`, `category_id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `clubs` (`id` bigint not null auto_increment, `address` varchar(255), `age_from` integer, `age_to` integer, `description` varchar(255), `is_approved` bit, `latitude` float(53), `longitude` float(53), `name` varchar(255) not null, `rating` float(53), `url_background` varchar(255), `url_logo` varchar(255), `url_web` varchar(255), `work_time` varchar(255), `center_id` bigint, `city_id` bigint not null, `district_id` bigint not null, `station_id` bigint not null, `user_id` bigint, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `districts` (`id` bigint not null auto_increment, `name` varchar(255) not null, `city_id` bigint not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `feedbacks` (`id` bigint not null auto_increment, `date` datetime(6), `rate` float(23) not null, text varchar(255), `user_name` varchar(255), `club_id` bigint, `user_id` bigint, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin; 
create table `news` (`id` bigint not null auto_increment, date datetime(6), description varchar(255), title varchar(255) not null, url_title_logo varchar(255), primary key (id)) engine=InnoDB  DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `roles` (`id` integer not null auto_increment, `name` varchar(255) not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `stations` (`id` bigint not null auto_increment, `name` varchar(255) not null, `city_id` bigint not null, `district_id` bigint not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
create table `users` (`id` bigint not null auto_increment, `email` varchar(255) not null, `name` varchar(255), `password` varchar(255) not null, `role_id` integer not null, primary key (`id`)) engine=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

alter table `users` add constraint UK_users_email unique (email);
alter table `centers` add constraint FK_centers_users foreign key (`user_id`) references users (`id`);
alter table `club_category` add constraint FK_club_category_categories foreign key (`category_id`) references categories (`id`);
alter table `club_category` add constraint FK_club_category_clubs foreign key (`club_id`) references clubs (`id`);
alter table `clubs` add constraint FK_clubs_centers foreign key (`center_id`) references centers (`id`);
alter table `clubs` add constraint FK_clubs_cities foreign key (`city_id`) references cities (`id`);
alter table `clubs` add constraint FK_clubs_districts foreign key (`district_id`) references districts (`id`);
alter table `clubs` add constraint FK_clubs_stations foreign key (`station_id`) references stations (`id`);
alter table `clubs` add constraint FK_clubs_users foreign key (`user_id`) references users (`id`);
alter table `districts` add constraint FK_districts_cities foreign key (`city_id`) references cities (`id`);
alter table `feedbacks` add constraint FK_feedbacks_clubs foreign key (`club_id`) references clubs (`id`);
alter table `feedbacks` add constraint FK_feedbacks_users foreign key (`user_id`) references users (`id`);
alter table `stations` add constraint FK_stations_cities foreign key (`city_id`) references cities (`id`);
alter table `stations` add constraint FK_stations_districts foreign key (`district_id`) references districts (`id`);
alter table `users` add constraint FK_users_roles foreign key (`role_id`) references roles (`id`);

-- Roles
insert ignore into `roles`(id, name) values (1, 'ROLE_ADMIN');
insert ignore into `roles`(id, name) values (2, 'ROLE_USER');

-- Users
insert ignore into `users`(id, email, password, role_id) values (1, 'admin@teachua.com', 'hashed_password1', 1);
insert ignore into `users`(id, email, password, role_id) values (2, 'user1@teachua.com', 'hashed_password2', 2);
insert ignore into `users`(id, email, password, role_id) values (3, 'user2@teachua.com', 'hashed_password3', 2);

-- Cities
insert ignore into `cities`(id, name, latitude, longitude) values (1, 'Київ', 50.4501, 30.5234);
insert ignore into `cities`(id, name, latitude, longitude) values (2, 'Харків', 49.9935, 36.2304);
insert ignore into `cities`(id, name, latitude, longitude) values (3, 'Дніпро', 48.4795, 35.0072);
insert ignore into `cities`(id, name, latitude, longitude) values (4, 'Одеса', 46.4825, 30.7233);
insert ignore into `cities`(id, name, latitude, longitude) values (5, 'Запоріжжя', 47.8228, 35.1903);
insert ignore into `cities`(id, name, latitude, longitude) values (6, 'Луганськ', 48.5740, 39.3078);
insert ignore into `cities`(id, name, latitude, longitude) values (7, 'Донецьк', 48.0159, 37.8028);
insert ignore into `cities`(id, name, latitude, longitude) values (8, 'Львів', 49.8397, 24.0297);
insert ignore into `cities`(id, name, latitude, longitude) values (9, 'Рівне', 50.6199, 26.2516);

-- Categories
insert ignore into `categories`(id, name) values (1, 'Спорт');
insert ignore into `categories`(id, name) values (2, 'Мистецтво');
insert ignore into `categories`(id, name) values (3, 'Наука');
insert ignore into `categories`(id, name) values (4, 'Танці');
insert ignore into `categories`(id, name) values (5, 'Музика');
insert ignore into `categories`(id, name) values (6, 'ІТ');
insert ignore into `categories`(id, name) values (7, 'Іноземні мови');
insert ignore into `categories`(id, name) values (8, 'Література');
insert ignore into `categories`(id, name) values (9, 'Театр');

-- Districts
insert ignore into `districts`(id, name, city_id) values (1, 'No District', 1);
insert ignore into `districts`(id, name, city_id) values (2, 'No District', 2);
insert ignore into `districts`(id, name, city_id) values (3, 'No District', 3);
insert ignore into `districts`(id, name, city_id) values (4, 'No District', 4);
insert ignore into `districts`(id, name, city_id) values (5, 'No District', 5);
insert ignore into `districts`(id, name, city_id) values (6, 'No District', 6);
insert ignore into `districts`(id, name, city_id) values (7, 'No District', 7);
insert ignore into `districts`(id, name, city_id) values (8, 'No District', 8);
insert ignore into `districts`(id, name, city_id) values (9, 'No District', 9);

-- Stations
insert ignore into `stations`(id, name, city_id, district_id) values (1, 'No Station', 1, 1);
insert ignore into `stations`(id, name, city_id, district_id) values (2, 'No Station', 2, 2);
insert ignore into `stations`(id, name, city_id, district_id) values (3, 'No Station', 3, 3);
insert ignore into `stations`(id, name, city_id, district_id) values (4, 'No Station', 4, 4);
insert ignore into `stations`(id, name, city_id, district_id) values (5, 'No Station', 5, 5);
insert ignore into `stations`(id, name, city_id, district_id) values (6, 'No Station', 6, 6);
insert ignore into `stations`(id, name, city_id, district_id) values (7, 'No Station', 7, 7);
insert ignore into `stations`(id, name, city_id, district_id) values (8, 'No Station', 8, 8);
insert ignore into `stations`(id, name, city_id, district_id) values (9, 'No Station', 9, 9);


insert ignore into `roles`(id, name) values (1, 'ROLE_ADMIN');
insert ignore into `roles`(id, name) values (2, 'ROLE_USER');

-- Users
insert ignore into `users`(id, email, password, role_id) values (1, 'admin@teachua.com', 'hashed_password1', 1);
insert ignore into `users`(id, email, password, role_id) values (2, 'user1@teachua.com', 'hashed_password2', 2);
insert ignore into `users`(id, email, password, role_id) values (3, 'user2@teachua.com', 'hashed_password3', 2);

-- Cities
insert ignore into `cities`(id, name, latitude, longitude) values (1, 'Київ', 50.4501, 30.5234);
insert ignore into `cities`(id, name, latitude, longitude) values (2, 'Харків', 49.9935, 36.2304);
insert ignore into `cities`(id, name, latitude, longitude) values (3, 'Дніпро', 48.4795, 35.0072);
insert ignore into `cities`(id, name, latitude, longitude) values (4, 'Одеса', 46.4825, 30.7233);
insert ignore into `cities`(id, name, latitude, longitude) values (5, 'Запоріжжя', 47.8228, 35.1903);
insert ignore into `cities`(id, name, latitude, longitude) values (6, 'Луганськ', 48.5740, 39.3078);
insert ignore into `cities`(id, name, latitude, longitude) values (7, 'Донецьк', 48.0159, 37.8028);
insert ignore into `cities`(id, name, latitude, longitude) values (8, 'Львів', 49.8397, 24.0297);
insert ignore into `cities`(id, name, latitude, longitude) values (9, 'Рівне', 50.6199, 26.2516);

-- Categories
insert ignore into `categories`(id, name) values (1, 'Спорт');
insert ignore into `categories`(id, name) values (2, 'Мистецтво');
insert ignore into `categories`(id, name) values (3, 'Наука');
insert ignore into `categories`(id, name) values (4, 'Танці');
insert ignore into `categories`(id, name) values (5, 'Музика');
insert ignore into `categories`(id, name) values (6, 'ІТ');
insert ignore into `categories`(id, name) values (7, 'Іноземні мови');
insert ignore into `categories`(id, name) values (8, 'Література');
insert ignore into `categories`(id, name) values (9, 'Театр');

-- Districts
insert ignore into `districts`(id, name, city_id) values (1, 'No District', 1);
insert ignore into `districts`(id, name, city_id) values (2, 'No District', 2);
insert ignore into `districts`(id, name, city_id) values (3, 'No District', 3);
insert ignore into `districts`(id, name, city_id) values (4, 'No District', 4);
insert ignore into `districts`(id, name, city_id) values (5, 'No District', 5);
insert ignore into `districts`(id, name, city_id) values (6, 'No District', 6);
insert ignore into `districts`(id, name, city_id) values (7, 'No District', 7);
insert ignore into `districts`(id, name, city_id) values (8, 'No District', 8);
insert ignore into `districts`(id, name, city_id) values (9, 'No District', 9);

-- Stations
insert ignore into `stations`(id, name, city_id, district_id) values (1, 'No Station', 1, 1);
insert ignore into `stations`(id, name, city_id, district_id) values (2, 'No Station', 2, 2);
insert ignore into `stations`(id, name, city_id, district_id) values (3, 'No Station', 3, 3);
insert ignore into `stations`(id, name, city_id, district_id) values (4, 'No Station', 4, 4);
insert ignore into `stations`(id, name, city_id, district_id) values (5, 'No Station', 5, 5);
insert ignore into `stations`(id, name, city_id, district_id) values (6, 'No Station', 6, 6);
insert ignore into `stations`(id, name, city_id, district_id) values (7, 'No Station', 7, 7);
insert ignore into `stations`(id, name, city_id, district_id) values (8, 'No Station', 8, 8);
insert ignore into `stations`(id, name, city_id, district_id) values (9, 'No Station', 9, 9);

SET FOREIGN_KEY_CHECKS = 1;
