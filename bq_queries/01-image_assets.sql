# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CREATE SCHEMA IF NOT EXISTS `{bq_dataset}_bq`;
CREATE OR REPLACE TABLE `{bq_dataset}_bq.image_assets`
AS
WITH count_image_assets AS (
  SELECT
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_images
  FROM
    `{bq_dataset}.assetgroupasset`
  WHERE asset_type = 'IMAGE'
  GROUP BY 1, 2
),
count_logos AS (
  SELECT 
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_logos
  FROM
    `{bq_dataset}.assetgroupasset`
  WHERE asset_sub_type = 'LOGO'
  GROUP BY 1, 2
),
map_assets_account_campaign AS (
  SELECT
    AGA.campaign_id,
    AGA.asset_group_id,
    A.image_width,
    A.image_height
  FROM `{bq_dataset}.assetgroupasset` as AGA
  LEFT JOIN `{bq_dataset}.asset` as A
    ON AGA.account_id = A.account_id
    AND AGA.asset_id = A.asset_id
),
count_rectangular_assets AS (
  SELECT
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_rectangular
  FROM
    map_assets_account_campaign
  WHERE image_width = 600
    AND image_height IN (300,314)
  GROUP BY 1, 2
),
count_square_300 AS (
  SELECT
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_square
  FROM map_assets_account_campaign
  WHERE image_width = image_height
    AND image_width IN (300,314)
  GROUP BY 1, 2
),
count_square_logos AS (
  SELECT
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_square_logos
  FROM map_assets_account_campaign
  WHERE image_width = image_height
    AND image_width = 128
  GROUP BY 1, 2
),
count_rectangular_logos AS (
  SELECT
    campaign_id,
    asset_group_id,
    COUNT(*) AS count_rectangular_logos
  FROM map_assets_account_campaign
  WHERE image_width = 1200
    AND image_height = 628
  GROUP BY 1, 2
)
SELECT 
  AGS.account_id,
  AGS.account_name,
  AGS.campaign_id,
  AGS.campaign_name,
  AGS.asset_group_id,
  AGS.asset_group_name,
  CIA.count_images,
  CL.count_logos,
  CRA.count_rectangular,
  CSN.count_square,
  CSL.count_square_logos,
  CRL.count_rectangular_logos
FROM `{bq_dataset}.assetgroupsummary` AS AGS
LEFT JOIN count_image_assets AS CIA
  ON CIA.campaign_id = AGS.campaign_id
  AND CIA.asset_group_id = AGS.asset_group_id
LEFT JOIN count_logos AS CL
  ON CL.campaign_id = AGS.campaign_id
  AND CL.asset_group_id = AGS.asset_group_id
LEFT JOIN count_rectangular_assets AS CRA
  ON CRA.campaign_id = AGS.campaign_id
  AND CRA.asset_group_id = AGS.asset_group_id
LEFT JOIN count_square_300 AS CSN
  ON CSN.campaign_id = AGS.campaign_id
  AND CSN.asset_group_id = AGS.asset_group_id
LEFT JOIN count_square_logos AS CSL
  ON CSL.campaign_id = AGS.campaign_id
  AND CSL.asset_group_id = AGS.asset_group_id
LEFT JOIN count_rectangular_logos AS CRL
  ON CRL.campaign_id = AGS.campaign_id
  AND CRL.asset_group_id = AGS.asset_group_id
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
