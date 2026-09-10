USE teachua;

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


insert into `centers`(id, name, email, address, phones, social_links, description, latitude, longitude, url_logo, url_web, user_id) values (1, 'center1', 'center1@gameil.com', 'center_address1', '+380000000001', 'some_links', 'center1_description', 49.73259434488975, 23.997036169252326, 'https://logodesign.net', '#', 2);
insert into `centers`(id, name, email, address, phones, social_links, description, latitude, longitude, url_logo, url_web, user_id) values (2, 'Творчий край', 'center2@gameil.com', 'center_address2', '+380000000002', 'some_links', 'center2_description', 49.23259434488972, 23.297036169252322, 'https://logodesign.net', '#', 3);

insert into `news`(title, description, date, url_title_logo) values ('title1', 'description1', '2021-02-15 16:06:36.21', 'https://vechirniy.kyiv.ua');
insert into `news`(title, description, date, url_title_logo) values ('title2', 'description2', '2021-02-15 16:06:36.21', 'https://cpo.in.ua');
