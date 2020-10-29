SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
SET time_zone = "+02:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE OR REPLACE VIEW new_news AS
SELECT node.nid                                 as old_id,
       (node.nid - 1596)                        as id,
       (1)                                      as category_id,
       (node.nid)                               as seo_id,
       node_field_data.title                    as title_ru,
       (null)                                   as title_en,
       node__body.body_value                    as description_ru,
       (null)                                   as description_en,
       (null)                                   as main_image,
       (1)                                      as status,
       (FROM_UNIXTIME(node_field_data.created)) as date_publication,
       (SUBSTR(url_alias.alias,2))                          as slug
FROM node
         INNER JOIN
     node_field_data,
     node__body,
     url_alias
where node.nid = node_field_data.nid
  and node.type = 'article'
  and node.nid = node__body.entity_id
  and CONCAT('/node/', node.nid) = url_alias.source
ORDER BY node.nid;

CREATE OR REPLACE VIEW new_urls_news AS
SELECT ('App\\Models\\News') as model,
       (node.nid - 1596)     as model_id,
       (SUBSTR(url_alias.alias,2))     as full_url
FROM url_alias
         INNER JOIN
     node
where CONCAT('/node/', node.nid) = url_alias.source
  and node.type = 'article';
