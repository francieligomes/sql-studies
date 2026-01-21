# Analytics Queries

This directory contains analytical SQL queries built on top of the core database schema.
The queries are designed to generate business metrics and insights using clean,
well-defined grains and explicit business logic.

## Purpose

The goal of this folder is to centralize reusable analytical queries that:
- Calculate business metrics (revenue, sales, averages, counts)
- Apply consistent business rules (e.g. billable orders only)
- Respect clear aggregation grains (day, month, year, category, etc.)

These queries are intended for analysis, reporting, dashboards,
and as a foundation for future data models.

## Folder Structure

analytics/
├── revenue/
│ ├── revenue_by_day.sql
│ ├── revenue_by_month.sql
│ ├── revenue_by_year.sql
│ ├── revenue_by_category_month.sql
│ └── revenue_by_author_month.sql
│
├── sales/
│ ├── total_units_sold.sql
│ ├── units_sold_by_book.sql
│ └── aov_by_month.sql
│
└── orders/
  └── orders_by_status.sql



## Conventions

Each query follows a standard structure:
- A descriptive file name that reflects the metric and grain
- A header comment defining:
  - Metric name
  - Aggregation grain
  - Business logic
  - Tables involved
  - Status filtering rules

## Status Logic

Unless explicitly stated otherwise, analytical queries consider only
the following order statuses as billable:

- Paid
- Shipped
- Delivered
- Completed

## Notes

- Time-based metrics derive their grain from `order_date`
- Monetary metrics use `quantity * unit_price`
- Category-level metrics resolve categories through bridge tables

This structure is intentionally designed to mirror real-world
analytics and data engineering workflows.
