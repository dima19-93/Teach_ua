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


insert into `roles`(id, name) values (1, 'ROLE_ADMIN');
insert into `roles`(id, name) values (2, 'ROLE_USER');


insert into `users`(id, email, password, name, role_id) values (1, 'admin@gmail.com', '$2y$12$iod5PRHZaYrIO6L3onnnk.Mhx9Hc1lb2ehBi0hRvPDD83u6OM/b66', 'admin', 1);
insert into `users`(id, email, password, name, role_id) values (2, 'user@gmail.com', '$2y$12$aDvzOnearRd4eulVJID3pOufutAIXVU5i1GKhgpXuvyVmktuSAmqe', 'user', 2);
insert into `users`(id, email, password, name, role_id) values (3, 'user2@gmail.com', '$2y$12$aDvzOnearRd4eulVJID3pOufutAIXVU5i1GKhgpXuvyVmktuSAmqe', 'user2', 2);


insert into `cities`(id, name, latitude, longitude) values (1, 'Київ', 50.4501, 30.5234);
insert into `cities`(id, name, latitude, longitude) values (2, 'Харків', 49.9935, 36.2304);
insert into `cities`(id, name, latitude, longitude) values (3, 'Дніпро', 48.479512881488375, 35.00721554865378);
insert into `cities`(id, name, latitude, longitude) values (4, 'Одеса', 46.4825, 30.7233);
insert into `cities`(id, name, latitude, longitude) values (5, 'Запоріжжя', 47.8228900, 35.1903100);
insert into `cities`(id, name, latitude, longitude) values (6, 'Луганськ', 48.5740, 39.3078);
insert into `cities`(id, name, latitude, longitude) values (7, 'Донецьк', 48.0159, 37.8028);
insert into `cities`(id, name, latitude, longitude) values (8, 'Львів', 49.8397, 24.0297);
insert into `cities`(id, name, latitude, longitude) values (9, 'Рівне', 50.6199, 26.2516);


insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (1, 'спортивні секції', '/static/images/categories/sport.svg', '#1890FF', '#1890FF', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (2, 'Танці', '/static/images/categories/dance.svg', '#531DAB', '#F9F0FF', '#531DAB');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (3, 'студії раннього розвитку', '/static/images/categories/improvement.svg', '#73D13D', '#73D13D', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (4, 'програмування, робототехніка, STEM', '/static/images/categories/programming.svg', '#597EF7', '#597EF7', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (5, 'художні студії, мистецтво, дизайн', '/static/images/categories/art.svg', '#9254DE', '#9254DE', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (6, 'вокальна студії, музика, музичні інструменти', '/static/images/categories/music.svg', '#FF7A45', '#FF7A45', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (7, 'акторська майстерність, театр', '/static/images/categories/theatre.svg', '#FF4D4F', '#FF4D4F', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (8, 'особистісний розвиток', '/static/images/categories/self-improvement.svg', '#FADB14', '#FFF9D4', '#D46B08');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (9, 'журналістика, дитяче телебачення, монтаж відео, влогів', '/static/images/categories/tv.svg', '#13C2C2', '#13C2C2', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (10, 'інше', '/static/images/categories/other.svg', '#FFA940', '#FFA940', '#fff');
insert into `categories`(id, name, url_logo, background_color, tag_background_color, tag_text_color) values (11, 'центр розвитку', '/static/images/categories/center.svg', '#F759AB', '#F759AB', '#fff');


insert into `centers`(id, name, email, address, phones, social_links, description, latitude, longitude, url_logo, url_web, user_id) values (1, 'center1', 'center1@gameil.com', 'center_address1', '+380000000001', 'some_links', 'center1_description', 49.73259434488975, 23.997036169252326, 'https://www.logodesign.net/images/minimal-logo.png', '#', 2);
insert into `centers`(id, name, email, address, phones, social_links, description, latitude, longitude, url_logo, url_web, user_id) values (2, 'Творчий край', 'center2@gameil.com', 'center_address2', '+380000000002', 'some_links', 'center2_description', 49.23259434488972, 23.297036169252322, 'https://www.logodesign.net/images/illustration-logo.png', '#', 3);

insert into `news`(title, description, date, url_title_logo) values ('title1', 'description1', '2021-02-15 16:06:36.21', 'https://vechirniy.kyiv.ua/data/news/full/58cbc15d9f4cb.jpg');
insert into `news`(title, description, date, url_title_logo) values ('title2', 'description2', '2021-02-15 16:06:36.21', 'https://cpo.in.ua/articles/technik/DSC00014.JPG');
insert into `news`(title, description, date, url_title_logo) values ('title3', 'description3', '2021-02-15 16:06:36.21', 'https://fti.dp.ua/dsit/wp-content/uploads/sites/2/2020/02/sci-tech-talks-1-1080x608.jpg');


insert into `districts`(id, name, city_id) values (1, 'No District', 1);
insert into `districts`(id, name, city_id) values (2, 'No District', 2);
insert into `districts`(id, name, city_id) values (3, 'No District', 3);
insert into `districts`(id, name, city_id) values (4, 'No District', 4);
insert into `districts`(id, name, city_id) values (5, 'No District', 5);
insert into `districts`(id, name, city_id) values (6, 'No District', 6);
insert into `districts`(id, name, city_id) values (7, 'No District', 7);
insert into `districts`(id, name, city_id) values (8, 'No District', 8);
insert into `districts`(id, name, city_id) values (9, 'No District', 9);


insert into `stations`(id, name, city_id, district_id) values (1, 'No Station', 1, 1);
insert into `stations`(id, name, city_id, district_id) values (2, 'No Station', 2, 2);
insert into `stations`(id, name, city_id, district_id) values (3, 'No Station', 3, 3);
insert into `stations`(id, name, city_id, district_id) values (4, 'No Station', 4, 4);
insert into `stations`(id, name, city_id, district_id) values (5, 'No Station', 5, 5);
insert into `stations`(id, name, city_id, district_id) values (6, 'No Station', 6, 6);
insert into `stations`(id, name, city_id, district_id) values (7, 'No Station', 7, 7);
insert into `stations`(id, name, city_id, district_id) values (8, 'No Station', 8, 8);
insert into `stations`(id, name, city_id, district_id) values (9, 'No Station', 9, 9);


insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (1, 6, 9, 'Довкілля крізь призму української мови 1', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 50.4501, 30.5234, 1, 1, 1, 2, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut', 2, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (2, 7, 10, 'Довкілля крізь призму української мови 2', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_1.jpg', '09:00-16:00', 49.9935, 36.2304, 2, 2, 2, 2, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 3, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (3, 11, 16, 'Довкілля крізь призму української мови 3', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_3.jpg', '09:00-16:00', 48.4795, 35.0072, 3, 3, 3, 1, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 1, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (4, 6, 9, 'Довкілля крізь призму української мови 4', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_4.jpg', '09:00-16:00', 46.4825, 30.7233, 4, 4, 4, null, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 5, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (5, 5, 10, 'Довкілля крізь призму української мови 5', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 47.8228, 35.1903, 5, 5, 5, null, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 1, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (6, 5, 10, 'Довкілля крізь призму української мови 6', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 48.5740, 39.3078, 6, 6, 6, null, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 3, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (7, 5, 10, 'Довкілля крізь призму української мови 7', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 48.0159, 37.8028, 7, 7, 7, null, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 1, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (8, 5, 10, 'Довкілля крізь призму української мови 8', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 49.8397, 24.0297, 8, 8, 8, null, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 3.0, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (9, 5, 10, 'Довкілля крізь призму української мови 9', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 50.6199, 26.2516, 9, 9, 9, 1, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ...', 5, true);
insert into `clubs`(id, age_from, age_to, name, address, url_logo, url_web, url_background, work_time, latitude, longitude, station_id, district_id, city_id, center_id, user_id, description, rating, is_approved) values (10, 5, 10, 'Довкілля крізь призму української мови 10', 'вул. Університетська 52', '#', '#', 'dev/static/images/club/bg_2.png', '09:00-16:00', 50.4501, 30.5234, 1, 1, 1, null, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut', 1, true);


insert into `feedbacks`(rate, date, text, user_id, club_id) values (5, '2021-02-15 16:06:36.21', 'nice club', 1, 1);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (3, '2021-02-15 16:06:36.21', ' ', 1, 1);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (5, '2021-02-15 16:06:36.21', 'nice club', 2, 2);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (4, '2021-02-15 16:06:36.21', 'nice club', 3, 3);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (5, '2021-02-15 16:06:36.21', 'nice club', 1, 4);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (4, '2021-02-15 16:06:36.21', 'nice club', 2, 5);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (5, '2021-02-15 16:06:36.21', 'nice club', 3, 6);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (4, '2021-02-15 16:06:36.21', 'nice club', 1, 7);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (5, '2021-02-15 16:06:36.21', 'nice club', 2, 8);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (2, '2021-02-15 16:06:36.21', 'bad club', 3, 9);
insert into `feedbacks`(rate, date, text, user_id, club_id) values (1, '2021-02-15 16:06:36.21', 'bad club', 1, 10);


insert into `club_category`(club_id, category_id) VALUES (1, 2);
insert into `club_category`(club_id, category_id) VALUES (1, 8);
insert into `club_category`(club_id, category_id) VALUES (1, 3);
insert into `club_category`(club_id, category_id) VALUES (2, 2);
insert into `club_category`(club_id, category_id) VALUES (3, 2);
insert into `club_category`(club_id, category_id) VALUES (4, 3);
insert into `club_category`(club_id, category_id) VALUES (5, 1);
insert into `club_category`(club_id, category_id) VALUES (6, 4);
insert into `club_category`(club_id, category_id) VALUES (7, 5);
insert into `club_category`(club_id, category_id) VALUES (8, 9);
insert into `club_category`(club_id, category_id) VALUES (9, 1);
insert into `club_category`(club_id, category_id) VALUES (10, 3);


SET FOREIGN_KEY_CHECKS = 1;
