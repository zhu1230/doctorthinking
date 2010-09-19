CREATE TABLE `activities` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `public` tinyint(1) default '1',
  `item_id` int(11) default NULL,
  `item_type` varchar(255) collate utf8_unicode_ci default NULL,
  `action` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `user_id` int(11) default NULL,
  `group_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `attachment_miscs` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `content_type` varchar(255) collate utf8_unicode_ci default NULL,
  `filename` varchar(255) collate utf8_unicode_ci default NULL,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `thumbnail` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `owner_id` int(11) default NULL,
  `owner_type` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `content_type` varchar(255) collate utf8_unicode_ci default NULL,
  `filename` varchar(255) collate utf8_unicode_ci default NULL,
  `thumbnail` varchar(255) collate utf8_unicode_ci default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `fuzhu_detail_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `attendances` (
  `id` int(11) NOT NULL auto_increment,
  `attendee_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bingli_comments` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `thetime` datetime NOT NULL,
  `uphold` int(11) NOT NULL default '0',
  `bingli_info_id` int(11) default NULL,
  `user_id` int(11) NOT NULL default '0',
  `keshi_id` int(11) NOT NULL default '0',
  `catelog_id` int(11) NOT NULL default '0',
  `attachment_has` varchar(255) collate utf8_unicode_ci default '0',
  `content` text collate utf8_unicode_ci NOT NULL,
  `denial` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bingli_infos` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `thetime` datetime NOT NULL,
  `rank_num` int(11) NOT NULL default '0',
  `bingli_id` int(11) NOT NULL default '0',
  `keshi_id` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `catelog_id` int(11) NOT NULL default '0',
  `bingli_comments_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bingli_infos_tags` (
  `tag_id` int(11) NOT NULL default '0',
  `bingli_info_id` int(11) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bingli_infos_users` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `bingli_info_id` int(11) NOT NULL,
  `desc` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `binglis` (
  `id` int(11) NOT NULL auto_increment,
  `sex` int(11) NOT NULL default '0',
  `age` int(11) default '0',
  `marriage` tinyint(1) NOT NULL default '0',
  `yibanqingkuang` text collate utf8_unicode_ci NOT NULL,
  `zhuyaozhengzhuang` text collate utf8_unicode_ci NOT NULL,
  `xianbingshi` text collate utf8_unicode_ci NOT NULL,
  `jiwang` text collate utf8_unicode_ci NOT NULL,
  `fuzhu_has` varchar(255) collate utf8_unicode_ci default NULL,
  `chubu_has` varchar(255) collate utf8_unicode_ci default NULL,
  `yiwen_has` varchar(255) collate utf8_unicode_ci default NULL,
  `buchong` text collate utf8_unicode_ci NOT NULL,
  `final` varchar(255) collate utf8_unicode_ci default '',
  `attachment_has` varchar(255) collate utf8_unicode_ci default NULL,
  `zhusu` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `tigejiancha` text collate utf8_unicode_ci,
  `yibanbuchong` text collate utf8_unicode_ci,
  `zongbuchong` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blog_mirrors` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blog_post_topics` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `parent_id` int(11) default NULL,
  `default` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blog_post_topics_blog_posts` (
  `blog_post_id` int(11) default NULL,
  `blog_post_topic_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blog_posts` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `parent_id` int(11) default NULL,
  `published` tinyint(1) default NULL,
  `featured` tinyint(1) default NULL,
  `summary` text collate utf8_unicode_ci,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `published_at` datetime default NULL,
  `guid` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `views` int(11) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `book_reviews` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `release_date` varchar(255) collate utf8_unicode_ci default NULL,
  `publisher` varchar(255) collate utf8_unicode_ci default NULL,
  `website` varchar(255) collate utf8_unicode_ci default NULL,
  `buy_link` varchar(255) collate utf8_unicode_ci default NULL,
  `review` text collate utf8_unicode_ci,
  `user_id` int(11) default NULL,
  `image_url` varchar(255) collate utf8_unicode_ci default NULL,
  `featured` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bug_reports` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `browser` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `description` text collate utf8_unicode_ci,
  `module` varchar(255) collate utf8_unicode_ci default NULL,
  `resolved` tinyint(1) default '0',
  `comment` text collate utf8_unicode_ci,
  `resolution_date` date default NULL,
  `priority` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `catelogs` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `information` varchar(45) collate utf8_unicode_ci default NULL,
  `parent_id` int(11) NOT NULL default '0',
  `keshi_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `chubu_details` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `bingli_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `classified_categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `classifieds` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `description` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `classified_category_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(50) collate utf8_unicode_ci default '',
  `comment` varchar(255) collate utf8_unicode_ci default '',
  `commentable_id` int(11) NOT NULL default '0',
  `commentable_type` varchar(15) collate utf8_unicode_ci NOT NULL default '',
  `user_id` int(11) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_comments_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `config_settings` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `countries` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `abbreviation` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `domain_themes` (
  `id` int(11) NOT NULL auto_increment,
  `uri` varchar(255) collate utf8_unicode_ci default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_domain_themes_on_uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `photo_id` int(11) default NULL,
  `description` text collate utf8_unicode_ci,
  `event_type` varchar(255) collate utf8_unicode_ci default NULL,
  `start_time` datetime default NULL,
  `end_time` datetime default NULL,
  `location` varchar(255) collate utf8_unicode_ci default NULL,
  `street` varchar(255) collate utf8_unicode_ci default NULL,
  `city` varchar(255) collate utf8_unicode_ci default NULL,
  `website` varchar(255) collate utf8_unicode_ci default NULL,
  `phone` varchar(255) collate utf8_unicode_ci default NULL,
  `organized_by` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `ey_modules` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `active` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `bingli_info_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `feeds` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `follows` (
  `id` int(11) NOT NULL auto_increment,
  `follower_id` int(11) default NULL,
  `followee_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `forum_posts` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `parent_id` int(11) default NULL,
  `forum_topic_id` int(11) default NULL,
  `featured` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `views` int(11) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `forum_topics` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `description` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `friendships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `friend_id` int(11) default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `fuzhu_details` (
  `id` int(11) NOT NULL auto_increment,
  `fuzhu_type_id` int(11) default NULL,
  `content` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `bingli_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `fuzhu_pics` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `fuzhu_detail_id` int(11) NOT NULL,
  `pic_type` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `fuzhu_types` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `parent_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `photo_id` int(11) default NULL,
  `creator_id` int(11) default NULL,
  `featured` tinyint(1) default NULL,
  `announcements` text collate utf8_unicode_ci,
  `private` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `html_contents` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `ideas` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `invites` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `message` text collate utf8_unicode_ci,
  `invite_code` varchar(255) collate utf8_unicode_ci default NULL,
  `accepted` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `job_posts` (
  `id` int(11) NOT NULL auto_increment,
  `job_title` varchar(255) collate utf8_unicode_ci default NULL,
  `job_id` varchar(255) collate utf8_unicode_ci default NULL,
  `company` varchar(255) collate utf8_unicode_ci default NULL,
  `website` varchar(255) collate utf8_unicode_ci default NULL,
  `contact_name` varchar(255) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `featured` tinyint(1) default NULL,
  `end_date` date default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `keshis` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `reserve` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `likes` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `likable_id` int(11) NOT NULL,
  `likable_type` varchar(255) collate utf8_unicode_ci NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_likable_type` (`likable_type`,`likable_id`),
  KEY `fk_likes_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `links` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `meeting_tags` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `meetings` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `thetime` datetime default NULL,
  `arrange_time` datetime default NULL,
  `content` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `richeng` varchar(255) collate utf8_unicode_ci default NULL,
  `chuxi` varchar(255) collate utf8_unicode_ci default NULL,
  `zhuban` varchar(255) collate utf8_unicode_ci default NULL,
  `xieban` varchar(255) collate utf8_unicode_ci default NULL,
  `keshi_id` int(11) default NULL,
  `type_id` int(11) default NULL,
  `address` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `group_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL auto_increment,
  `subject` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `sender_id` int(11) default NULL,
  `recipient_id` int(11) default NULL,
  `read` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `nav_items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `login_required` tinyint(1) default NULL,
  `login_allowed` tinyint(1) default NULL,
  `admin_required` tinyint(1) default NULL,
  `enabled` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `networks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `organization` varchar(255) collate utf8_unicode_ci default NULL,
  `website` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `admin_email` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `permalink` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `group_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `photo_albums` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `view_count` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `photos` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `group_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `location` varchar(255) collate utf8_unicode_ci default NULL,
  `parent_id` int(11) default NULL,
  `content_type` varchar(255) collate utf8_unicode_ci default NULL,
  `filename` varchar(255) collate utf8_unicode_ci default NULL,
  `thumbnail` varchar(255) collate utf8_unicode_ci default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `is_profile` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `views` int(11) default '0',
  `view_count` int(11) default NULL,
  `photo_album_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `question_details` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `bingli_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `replies` (
  `id` int(11) NOT NULL auto_increment,
  `body` text collate utf8_unicode_ci,
  `user_id` int(11) default NULL,
  `item_id` int(11) default NULL,
  `item_type` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `rolename` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `roles_users` (
  `role_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  KEY `index_roles_users_on_role_id` (`role_id`),
  KEY `index_roles_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `rss_feeds` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `url` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `is_blog` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) collate utf8_unicode_ci NOT NULL,
  `data` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) default NULL,
  `last_url_visited` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `states` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `abbreviation` varchar(255) collate utf8_unicode_ci default NULL,
  `country_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `status_posts` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `body` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `tagger_id` int(11) default NULL,
  `tagger_type` varchar(255) collate utf8_unicode_ci default NULL,
  `taggable_type` varchar(255) collate utf8_unicode_ci default NULL,
  `context` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `themes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `login` varchar(255) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `email_hash` varchar(255) collate utf8_unicode_ci default NULL,
  `first_name` varchar(255) collate utf8_unicode_ci default NULL,
  `last_name` varchar(255) collate utf8_unicode_ci default NULL,
  `sex` varchar(255) collate utf8_unicode_ci default NULL,
  `city` varchar(255) collate utf8_unicode_ci default NULL,
  `state_id` int(11) default NULL,
  `zip` varchar(255) collate utf8_unicode_ci default NULL,
  `country_id` int(11) default NULL,
  `phone` varchar(255) collate utf8_unicode_ci default NULL,
  `phone2` varchar(255) collate utf8_unicode_ci default NULL,
  `time_zone` varchar(255) collate utf8_unicode_ci default 'UTC',
  `about_me` text collate utf8_unicode_ci,
  `organization` varchar(255) collate utf8_unicode_ci default NULL,
  `skills` text collate utf8_unicode_ci,
  `occupation` text collate utf8_unicode_ci,
  `featured` tinyint(1) default '0',
  `show_blog_posts_on_home` tinyint(1) default '1',
  `use_gravatar` tinyint(1) default '0',
  `website` varchar(255) collate utf8_unicode_ci default NULL,
  `blog` varchar(255) collate utf8_unicode_ci default NULL,
  `blog_feed` varchar(255) collate utf8_unicode_ci default NULL,
  `flickr` varchar(255) collate utf8_unicode_ci default NULL,
  `flickr_username` varchar(255) collate utf8_unicode_ci default NULL,
  `linked_in_url` varchar(255) collate utf8_unicode_ci default NULL,
  `twitter_id` varchar(255) collate utf8_unicode_ci default NULL,
  `display_tweets` tinyint(1) default '0',
  `aim_name` varchar(255) collate utf8_unicode_ci default NULL,
  `gtalk_name` varchar(255) collate utf8_unicode_ci default NULL,
  `yahoo_messenger_name` varchar(255) collate utf8_unicode_ci default NULL,
  `msn_name` varchar(255) collate utf8_unicode_ci default NULL,
  `youtube_username` varchar(255) collate utf8_unicode_ci default NULL,
  `skype_name` varchar(255) collate utf8_unicode_ci default NULL,
  `facebook_url` varchar(255) collate utf8_unicode_ci default NULL,
  `facebook_id` int(11) default NULL,
  `resume_url` varchar(255) collate utf8_unicode_ci default NULL,
  `company_url` varchar(255) collate utf8_unicode_ci default NULL,
  `posts_count` int(11) default '0',
  `last_seen_at` datetime default NULL,
  `login_count` int(11) default '0',
  `crypted_password` varchar(40) collate utf8_unicode_ci default NULL,
  `salt` varchar(40) collate utf8_unicode_ci default NULL,
  `remember_token` varchar(255) collate utf8_unicode_ci default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) collate utf8_unicode_ci default NULL,
  `activated_at` datetime default NULL,
  `password_reset_code` varchar(40) collate utf8_unicode_ci default NULL,
  `enabled` tinyint(1) default '1',
  `is_active` tinyint(1) default '0',
  `identity_url` varchar(255) collate utf8_unicode_ci default NULL,
  `receive_emails` tinyint(1) default '1',
  `api_key` varchar(40) collate utf8_unicode_ci default '',
  `name` varchar(255) collate utf8_unicode_ci default '',
  `jifen` int(11) default '0',
  `bingli_infos_count` int(11) default '0',
  `bingli_comments_count` int(11) default '0',
  `keshi_id` int(11) default '0',
  `zhicheng` varchar(255) collate utf8_unicode_ci default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users_rank_bingli_comments` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `bingli_comment_id` int(11) NOT NULL,
  `rank_tag` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `thetime` datetime default '2008-04-26 11:43:52',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users_rank_bingli_infos` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `bingli_info_id` int(11) NOT NULL,
  `rank_tag` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `thetime` datetime default '2008-04-26 11:43:52',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `videos` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `wall_posts` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `group_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `sender_id` int(11) default NULL,
  `message` text collate utf8_unicode_ci,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `widget_layouts` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` int(11) default NULL,
  `widget_id` int(11) default NULL,
  `col_num` int(11) default NULL,
  `row_num` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `html_content_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `active` tinyint(1) default NULL,
  `protected` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `description` text collate utf8_unicode_ci,
  `profile` tinyint(1) default NULL,
  `ey_module_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20090116160747');

INSERT INTO schema_migrations (version) VALUES ('20090116161501');

INSERT INTO schema_migrations (version) VALUES ('20090116161755');

INSERT INTO schema_migrations (version) VALUES ('20090116162559');

INSERT INTO schema_migrations (version) VALUES ('20090116165201');

INSERT INTO schema_migrations (version) VALUES ('20090116171953');

INSERT INTO schema_migrations (version) VALUES ('20090116172007');

INSERT INTO schema_migrations (version) VALUES ('20090116173325');

INSERT INTO schema_migrations (version) VALUES ('20090116174907');

INSERT INTO schema_migrations (version) VALUES ('20090116191446');

INSERT INTO schema_migrations (version) VALUES ('20090116192816');

INSERT INTO schema_migrations (version) VALUES ('20090119154736');

INSERT INTO schema_migrations (version) VALUES ('20090119155135');

INSERT INTO schema_migrations (version) VALUES ('20090119160430');

INSERT INTO schema_migrations (version) VALUES ('20090119171424');

INSERT INTO schema_migrations (version) VALUES ('20090119171439');

INSERT INTO schema_migrations (version) VALUES ('20090120182623');

INSERT INTO schema_migrations (version) VALUES ('20090122190843');

INSERT INTO schema_migrations (version) VALUES ('20090129183023');

INSERT INTO schema_migrations (version) VALUES ('20090129192945');

INSERT INTO schema_migrations (version) VALUES ('20090203220718');

INSERT INTO schema_migrations (version) VALUES ('20090205221617');

INSERT INTO schema_migrations (version) VALUES ('20090206031415');

INSERT INTO schema_migrations (version) VALUES ('20090206034820');

INSERT INTO schema_migrations (version) VALUES ('20090206174233');

INSERT INTO schema_migrations (version) VALUES ('20090206185148');

INSERT INTO schema_migrations (version) VALUES ('20090206190209');

INSERT INTO schema_migrations (version) VALUES ('20090209185842');

INSERT INTO schema_migrations (version) VALUES ('20090209220152');

INSERT INTO schema_migrations (version) VALUES ('20090212221022');

INSERT INTO schema_migrations (version) VALUES ('20090212222534');

INSERT INTO schema_migrations (version) VALUES ('20090216173509');

INSERT INTO schema_migrations (version) VALUES ('20090216181231');

INSERT INTO schema_migrations (version) VALUES ('20090220180912');

INSERT INTO schema_migrations (version) VALUES ('20090226213342');

INSERT INTO schema_migrations (version) VALUES ('20090530170040');

INSERT INTO schema_migrations (version) VALUES ('20090606153236');

INSERT INTO schema_migrations (version) VALUES ('20090609211245');

INSERT INTO schema_migrations (version) VALUES ('20090710182653');

INSERT INTO schema_migrations (version) VALUES ('20090713185659');

INSERT INTO schema_migrations (version) VALUES ('20090810193828');

INSERT INTO schema_migrations (version) VALUES ('20091012011206');

INSERT INTO schema_migrations (version) VALUES ('20091013205203');

INSERT INTO schema_migrations (version) VALUES ('20091019212027');

INSERT INTO schema_migrations (version) VALUES ('20091026183009');

INSERT INTO schema_migrations (version) VALUES ('20091026184522');

INSERT INTO schema_migrations (version) VALUES ('20091106205213');

INSERT INTO schema_migrations (version) VALUES ('20091110220622');

INSERT INTO schema_migrations (version) VALUES ('20091124145508');

INSERT INTO schema_migrations (version) VALUES ('20091124145525');

INSERT INTO schema_migrations (version) VALUES ('20091125201654');

INSERT INTO schema_migrations (version) VALUES ('20091204193534');

INSERT INTO schema_migrations (version) VALUES ('20091229154645');

INSERT INTO schema_migrations (version) VALUES ('20100218042049');

INSERT INTO schema_migrations (version) VALUES ('20100226204420');

INSERT INTO schema_migrations (version) VALUES ('20100306050247');

INSERT INTO schema_migrations (version) VALUES ('20100309211720');

INSERT INTO schema_migrations (version) VALUES ('20100319185852');

INSERT INTO schema_migrations (version) VALUES ('20100319190001');

INSERT INTO schema_migrations (version) VALUES ('20100319192210');

INSERT INTO schema_migrations (version) VALUES ('20100319210113');

INSERT INTO schema_migrations (version) VALUES ('20100322161553');

INSERT INTO schema_migrations (version) VALUES ('20100326174110');

INSERT INTO schema_migrations (version) VALUES ('20100326201303');

INSERT INTO schema_migrations (version) VALUES ('20100326203119');

INSERT INTO schema_migrations (version) VALUES ('20100328160927');

INSERT INTO schema_migrations (version) VALUES ('20100330144427');

INSERT INTO schema_migrations (version) VALUES ('20100608195539');

INSERT INTO schema_migrations (version) VALUES ('20100618150950');

INSERT INTO schema_migrations (version) VALUES ('20100623185718');

INSERT INTO schema_migrations (version) VALUES ('20100628192855');

INSERT INTO schema_migrations (version) VALUES ('20100707160333');