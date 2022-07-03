SELECT
    segments.date AS date,
    customer.id AS account_id,
    campaign.id AS campaign_id,
    campaign.name AS campaign_name,
    campaign.status AS campaign_status,
    campaign.start_date AS start_date,
    campaign.end_date AS end_date,
    campaign.url_expansion_opt_out AS url_expansion_opt_out,
    campaign.bidding_strategy_type AS bidding_strategy,
    campaign_budget.amount_micros AS budget_amount,
    campaign_budget.total_amount_micros AS total_budget,
    campaign_budget.type AS budget_type,
    campaign_budget.explicitly_shared AS is_shared_budget,
    campaign_budget.period AS budget_period,
    campaign.target_cpa.target_cpa_micros AS target_cpa,
    campaign.target_roas.target_roas AS target_roas,
    campaign.maximize_conversions.target_cpa AS max_conv_target_cpa,
    campaign.selective_optimization.conversion_actions AS selective_optimization_conversion_actions,
    bidding_strategy.currency_code AS currency,
    metrics.cost_micros AS cost,
    metrics.conversions AS conversions,
    metrics.impressions AS impressions,
    metrics.clicks AS clicks,
FROM campaign
WHERE campaign.advertising_channel_type = "PERFORMANCE_MAX"
    AND segments.date >= "{start_date}"
    AND segments.date <= "{end_date}"