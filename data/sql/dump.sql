-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 23, 2020 at 02:54 PM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `e_commerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `deleted_at`) VALUES
(2, 'Apple', NULL),
(3, 'Dell', NULL),
(4, 'Sony', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `deleted_at`) VALUES
(1, 'Informatique', NULL),
(2, 'Audio', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `command`
--

CREATE TABLE `command` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `crated_at` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20200922141530', '2020-10-12 08:50:16', 26),
('DoctrineMigrations\\Version20200922152039', '2020-10-12 08:50:16', 35),
('DoctrineMigrations\\Version20201012084623', '2020-10-12 08:50:16', 76),
('DoctrineMigrations\\Version20201012094201', '2020-10-12 09:42:09', 152);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `command_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture_first` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture_second` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture_third` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_ht` double NOT NULL,
  `price_ttc` double NOT NULL,
  `crated_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `brand_id`, `name`, `description`, `picture_first`, `picture_second`, `picture_third`, `price_ht`, `price_ttc`, `crated_at`, `updated_at`, `deleted_at`) VALUES
(2, 2, 'Macbook PRO 13``', '<p>Vestibulum orci ex, commodo quis mauris ut, molestie dictum est. Aenean sit amet augue at lectus feugiat pulvinar at ac est. Pellentesque molestie odio vel metus fermentum, et pulvinar diam efficitur. Duis tempus varius aliquet. Fusce tempus et lectus quis dignissim. Nulla efficitur urna eget enim ultrices consectetur. Quisque porta a elit a laoreet. Quisque id nisi purus. In hac habitasse platea dictumst. In nec ipsum pretium lacus varius luctus in quis risus. Etiam sed aliquam erat. Ut eget lectus volutpat, venenatis tellus vel, convallis lectus.</p><p>Nam eget felis metus. Pellentesque elit lorem, finibus eu ornare sed, rhoncus in ipsum. Vestibulum efficitur lacus odio, et volutpat justo euismod ut. Ut mauris sapien, laoreet eget risus ac, consectetur lobortis nunc. Vivamus vel odio ex. Fusce ligula nibh, pellentesque dictum imperdiet sit amet, laoreet faucibus orci. Suspendisse at nibh ac ex vulputate pulvinar. Donec vel rutrum sem. Vivamus sed mauris cursus, finibus risus sit amet, interdum nibh. Praesent dapibus dui mauris, ac vestibulum sem commodo at.</p><p>Morbi et congue massa. Sed sit amet malesuada libero. Vestibulum volutpat urna vitae sapien blandit, vel congue neque posuere. Nulla in luctus nunc. Maecenas gravida elementum elit tristique finibus. Vestibulum vel lacinia metus. Phasellus pellentesque ligula commodo nunc ullamcorper, sed cursus neque commodo. Donec a vehicula arcu. Quisque semper massa lorem, non consectetur magna feugiat at. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse massa erat, ullamcorper nec ultricies eu, posuere et metus. Sed sed venenatis risus, eget egestas tortor. Proin nisl eros, molestie ut pulvinar ut, congue in nisi. Aenean interdum fermentum consectetur.</p>', 'images.jpeg', 'images.jpeg', 'images.jpeg', 1300, 1500, '2020-11-03 10:54:40', '2020-11-23 14:33:55', NULL),
(3, 2, 'Mac Mini', '<p>Vestibulum orci ex, commodo quis mauris ut, molestie dictum est. Aenean sit amet augue at lectus feugiat pulvinar at ac est. Pellentesque molestie odio vel metus fermentum, et pulvinar diam efficitur. Duis tempus varius aliquet. Fusce tempus et lectus quis dignissim. Nulla efficitur urna eget enim ultrices consectetur. Quisque porta a elit a laoreet. Quisque id nisi purus. In hac habitasse platea dictumst. In nec ipsum pretium lacus varius luctus in quis risus. Etiam sed aliquam erat. Ut eget lectus volutpat, venenatis tellus vel, convallis lectus.</p><p>Nam eget felis metus. Pellentesque elit lorem, finibus eu ornare sed, rhoncus in ipsum. Vestibulum efficitur lacus odio, et volutpat justo euismod ut. Ut mauris sapien, laoreet eget risus ac, consectetur lobortis nunc. Vivamus vel odio ex. Fusce ligula nibh, pellentesque dictum imperdiet sit amet, laoreet faucibus orci. Suspendisse at nibh ac ex vulputate pulvinar. Donec vel rutrum sem. Vivamus sed mauris cursus, finibus risus sit amet, interdum nibh. Praesent dapibus dui mauris, ac vestibulum sem commodo at.</p><p>Morbi et congue massa. Sed sit amet malesuada libero. Vestibulum volutpat urna vitae sapien blandit, vel congue neque posuere. Nulla in luctus nunc. Maecenas gravida elementum elit tristique finibus. Vestibulum vel lacinia metus. Phasellus pellentesque ligula commodo nunc ullamcorper, sed cursus neque commodo. Donec a vehicula arcu. Quisque semper massa lorem, non consectetur magna feugiat at. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse massa erat, ullamcorper nec ultricies eu, posuere et metus. Sed sed venenatis risus, eget egestas tortor. Proin nisl eros, molestie ut pulvinar ut, congue in nisi. Aenean interdum fermentum consectetur.</p>', '400-320-5fa13ec5b51e8.png', '400-320-5fa13ec5b53e2.png', '400-320-5fa13ec5b5586.png', 500, 600, '2020-11-03 11:28:05', '2020-11-23 14:35:46', NULL),
(4, 4, 'Jabra', '<p><i>Vestibulum orci ex, commodo quis mauris ut, molestie dictum est. Aenean sit amet augue at lectus feugiat pulvinar at ac est. Pellentesque molestie odio vel metus fermentum, et pulvinar diam efficitur. Duis tempus varius aliquet. Fusce tempus et lectus quis dignissim. Nulla efficitur urna eget enim ultrices consectetur. Quisque porta a elit a laoreet. Quisque id nisi purus. In hac habitasse platea dictumst. In nec ipsum pretium lacus varius luctus in quis risus. Etiam sed aliquam erat. Ut eget lectus volutpat, venenatis tellus vel, convallis lectus.</i></p><p>Nam eget felis metus. Pellentesque elit lorem, finibus eu ornare sed, rhoncus in ipsum. Vestibulum efficitur lacus odio, et volutpat justo euismod ut. Ut mauris sapien, laoreet eget risus ac, consectetur lobortis nunc. Vivamus vel odio ex. Fusce ligula nibh, pellentesque dictum imperdiet sit amet, laoreet faucibus orci. Suspendisse at nibh ac ex vulputate pulvinar. Donec vel rutrum sem. Vivamus sed mauris cursus, finibus risus sit amet, interdum nibh. Praesent dapibus dui mauris, ac vestibulum sem commodo at.</p><p>Morbi et congue massa. Sed sit amet malesuada libero. Vestibulum volutpat urna vitae sapien blandit, vel congue neque posuere. Nulla in luctus nunc. Maecenas gravida elementum elit tristique finibus. Vestibulum vel lacinia metus. Phasellus pellentesque ligula commodo nunc ullamcorper, sed cursus neque commodo. Donec a vehicula arcu. Quisque semper massa lorem, non consectetur magna feugiat at. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse massa erat, ullamcorper nec ultricies eu, posuere et metus. Sed sed venenatis risus, eget egestas tortor. Proin nisl eros, molestie ut pulvinar ut, congue in nisi. Aenean interdum fermentum consectetur.</p>', 'Example-5fa13f4acf714.jpeg', 'Example-5fa13f4acf948.jpeg', 'Example-5fa13f4acfb22.jpeg', 50, 60, '2020-11-03 11:30:18', '2020-11-23 14:36:20', NULL),
(5, 2, 'dfgfddfg', 'fgdfgdfdgfgd', 'Example-5fa13fc3403c0.jpeg', NULL, NULL, 5, 5, '2020-11-03 11:32:19', NULL, '2020-11-03 11:36:28'),
(6, 2, 'Bose', '<p>Vestibulum orci ex, commodo quis mauris ut, molestie dictum est. Aenean sit amet augue at lectus feugiat pulvinar at ac est. Pellentesque molestie odio vel metus fermentum, et pulvinar diam efficitur. Duis tempus varius aliquet. Fusce tempus et lectus quis dignissim. Nulla efficitur urna eget enim ultrices consectetur. Quisque porta a elit a laoreet. Quisque id nisi purus. In hac habitasse platea dictumst. In nec ipsum pretium lacus varius luctus in quis risus. Etiam sed aliquam erat. Ut eget lectus volutpat, venenatis tellus vel, convallis lectus.</p><p>Nam eget felis metus. Pellentesque elit lorem, finibus eu ornare sed, rhoncus in ipsum. Vestibulum efficitur lacus odio, et volutpat justo euismod ut. Ut mauris sapien, laoreet eget risus ac, consectetur lobortis nunc. Vivamus vel odio ex. Fusce ligula nibh, pellentesque dictum imperdiet sit amet, laoreet faucibus orci. Suspendisse at nibh ac ex vulputate pulvinar. Donec vel rutrum sem. Vivamus sed mauris cursus, finibus risus sit amet, interdum nibh. Praesent dapibus dui mauris, ac vestibulum sem commodo at.</p><p>Morbi et congue massa. Sed sit amet malesuada libero. Vestibulum volutpat urna vitae sapien blandit, vel congue neque posuere. Nulla in luctus nunc. Maecenas gravida elementum elit tristique finibus. Vestibulum vel lacinia metus. Phasellus pellentesque ligula commodo nunc ullamcorper, sed cursus neque commodo. Donec a vehicula arcu. Quisque semper massa lorem, non consectetur magna feugiat at. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse massa erat, ullamcorper nec ultricies eu, posuere et metus. Sed sed venenatis risus, eget egestas tortor. Proin nisl eros, molestie ut pulvinar ut, congue in nisi. Aenean interdum fermentum consectetur.</p>', '400-320-5fbbb9a9ad7f9.png', '400-320-5fbbb9a9ada0f.png', '400-320-5fbbb9a9adba7.png', 5600, 8500, '2020-11-23 13:31:21', '2020-11-23 14:44:57', NULL),
(7, 2, 'test', '<p>Vestibulum orci ex, commodo quis mauris ut, molestie dictum est. Aenean sit amet augue at lectus feugiat pulvinar at ac est. Pellentesque molestie odio vel metus fermentum, et pulvinar diam efficitur. Duis tempus varius aliquet. Fusce tempus et lectus quis dignissim. Nulla efficitur urna eget enim ultrices consectetur. Quisque porta a elit a laoreet. Quisque id nisi purus. In hac habitasse platea dictumst. In nec ipsum pretium lacus varius luctus in quis risus. Etiam sed aliquam erat. Ut eget lectus volutpat, venenatis tellus vel, convallis lectus.</p><p>Nam eget felis metus. Pellentesque elit lorem, finibus eu ornare sed, rhoncus in ipsum. Vestibulum efficitur lacus odio, et volutpat justo euismod ut. Ut mauris sapien, laoreet eget risus ac, consectetur lobortis nunc. Vivamus vel odio ex. Fusce ligula nibh, pellentesque dictum imperdiet sit amet, laoreet faucibus orci. Suspendisse at nibh ac ex vulputate pulvinar. Donec vel rutrum sem. Vivamus sed mauris cursus, finibus risus sit amet, interdum nibh. Praesent dapibus dui mauris, ac vestibulum sem commodo at.</p><p>Morbi et congue massa. Sed sit amet malesuada libero. Vestibulum volutpat urna vitae sapien blandit, vel congue neque posuere. Nulla in luctus nunc. Maecenas gravida elementum elit tristique finibus. Vestibulum vel lacinia metus. Phasellus pellentesque ligula commodo nunc ullamcorper, sed cursus neque commodo. Donec a vehicula arcu. Quisque semper massa lorem, non consectetur magna feugiat at. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse massa erat, ullamcorper nec ultricies eu, posuere et metus. Sed sed venenatis risus, eget egestas tortor. Proin nisl eros, molestie ut pulvinar ut, congue in nisi. Aenean interdum fermentum consectetur.</p>', '400-320-5fbbba8fe00e9.png', NULL, NULL, 5, 6, '2020-11-23 13:35:11', NULL, '2020-11-23 14:36:30');

-- --------------------------------------------------------

--
-- Table structure for table `product_sub_category`
--

CREATE TABLE `product_sub_category` (
  `product_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sub_category`
--

INSERT INTO `product_sub_category` (`product_id`, `sub_category_id`) VALUES
(2, 2),
(3, 2),
(4, 1),
(5, 1),
(6, 1),
(6, 2),
(7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `category_id`, `name`, `deleted_at`) VALUES
(1, 2, 'Son', NULL),
(2, 1, 'PC', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `stripe_customer_id`) VALUES
(1, 'jyjebicy@mailinator.com', '[\"ROLE_CUSTOMER\",\"ROLE_ADMIN\"]', 'Suscipit elit corpo', 'Hayes', 'Alvarez', NULL),
(2, 'gopupur@mailinator.com', '[\"ROLE_ADMIN\"]', 'Pa$$w0rd!qcxwwxc', 'Jeanette', 'Page', NULL),
(3, 'zozof@mailinator.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$vtt4tfGpZ1huwmHNElic1A$UQiOUAjV6mZG3lzT14jkWrKFU5IQ0qOGDh4DiCLoYSk', 'Wade', 'Robles', NULL),
(4, 'xobyz@mailinator.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$eym3eJEEjAWQVKe7BHE6Kw$3tMs95iRDe5149tGb4oNpiJeEr70o6DIjyjeKxsT7lQ', 'Ishmael', 'Chambers', NULL),
(5, 'xobyz2@mailinator.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$hiDX5v5gSTSSTg64I+lgLg$0eSrBmAEk0EuhlQZN8/7GEboeH39xJ+OxgQDj1y3VFM', 'Jean', 'Durmeson', NULL),
(6, 'aaaa@google.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$qbgYjzAhC4ENqAAwzYOEYQ$5zhJw12Xh4IvBqSA2mG2NaHlZ16cg09WMRuSwgXHYSU', 'AAA', 'AAA', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `command`
--
ALTER TABLE `command`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8ECAEAD4A76ED395` (`user_id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1B251E33E1689A` (`command_id`),
  ADD KEY `IDX_1F1B251E4584665A` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD44F5D008` (`brand_id`);

--
-- Indexes for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  ADD PRIMARY KEY (`product_id`,`sub_category_id`),
  ADD KEY `IDX_3147D5F34584665A` (`product_id`),
  ADD KEY `IDX_3147D5F3F7BFE87C` (`sub_category_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4B3656604584665A` (`product_id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BCE3F79812469DE2` (`category_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `command`
--
ALTER TABLE `command`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `command`
--
ALTER TABLE `command`
  ADD CONSTRAINT `FK_8ECAEAD4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_1F1B251E33E1689A` FOREIGN KEY (`command_id`) REFERENCES `command` (`id`),
  ADD CONSTRAINT `FK_1F1B251E4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD44F5D008` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`);

--
-- Constraints for table `product_sub_category`
--
ALTER TABLE `product_sub_category`
  ADD CONSTRAINT `FK_3147D5F34584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_3147D5F3F7BFE87C` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `FK_4B3656604584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `FK_BCE3F79812469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
