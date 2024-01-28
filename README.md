
# BitsAndBobs Australia Business Data Analysis

## 1. Executive Summary

BitsAndBobs Australia is currently facing downward trends in sales, prompting a comprehensive review of branch performance and sales figures across its ten divisions. The analysis aims to guide management in determining the potential benefits of office consolidation to reverse falling sales and implement cost-cutting measures for future sustainability.

The company is reevaluating its strategy due to declining sales in various products, leading to financial challenges across over ten offices in Australia. This analysis focuses on identifying the causes behind declining revenue streams, taking into account regional variations in consumer preferences, market trends, and office-specific dynamics.

The examination serves to guide strategic decisions, particularly regarding possible office consolidation, aligning with cost reduction measures and long-term profitability goals. It is a comprehensive effort to navigate BitsAndBobs out of financial challenges, reinvent its strategy, and establish sustainable leadership in the competitive Australian market.

## 2. Problem Statement

BitsAndBobs Australia is experiencing a worrying trend of falling sales and declining financial status across its organization. The analysis focuses on branch performance, sales results, and potential office consolidation to address the decline in sales and enhance overall business stability and expansion.

The examination aims to unravel the complex reasons behind falling revenue streams, considering unique regional dynamics in consumer preferences and market trends. The deep analysis guides strategic decisions, especially regarding office consolidation, cost reduction, and long-term profitability.

## 3. Data Model/Data Load Process

### Data Loading:

- The .xlxl file was loaded into the SQL Server database.
- Tables for customer, sales, item, and staff were created after loading.
- Data integrity constraints were applied to ensure the validity of records.
- Duplicate records were checked and excluded.
- Null values were handled to maintain consistency in the dataset.

### Analysis:

Two approaches were employed for data analysis:

1. **Combined Analysis:**
   - Identified top 3 selling and least selling products based on combined office data.
   - Determined the top 3 salespersons irrespective of office location.

2. **Separate Analysis for Each Office:**
   - Analyzed top 3 selling products, least 3 selling products, and top 3 salespersons for each office.

### Sales Prediction:

- Linear Regression and Random Forest algorithms were used for sales prediction.
- Wagga Wagga was identified as the best-performing office based on sales.

## 4. Business Recommendations

1. **Office Consolidation for Efficiency:**
   - Strategically consolidate offices, focusing on underperforming locations.
   - Enhance operational efficiency for future competitiveness.

2. **Salesperson Training and Recognition Programs:**
   - Implement sales training programs for consistent success.
   - Establish recognition and reward programs for top-performing salespersons.

3. **Product Diversification Strategy:**
   - Widen the range of products to cater to changing consumer preferences.
   - Launch new and trendy merchandise based on market research.

4. **Operational Process Optimization:**
   - Evaluate organizational operational processes for efficiency.
   - Utilize technology to improve productivity in repetitive activities.

5. **Market Expansion and Customer Outreach:**
   - Increase market penetration with targeted marketing strategies.
   - Utilize digital marketing and social media for brand visibility.

6. **Office Closure and Downsizing:**
   - Consider closing the underperforming office at Wollongong.
   - Focus on consolidating operations for cost-cutting and efficiency.

## 5. Dashboard

An interactive PowerBI dashboard was created to visualize sales data and provide a query engine for specific questions.

## 6. Conclusion

The analysis aims to guide BitsAndBobs Australia in making strategic decisions to address declining sales, enhance operational efficiency, and ensure long-term profitability. Implementing the recommended strategies will position the company for revival, reinvention, and sustainable leadership in the Australian market.

For detailed analysis results and visualizations, refer to the PowerBI dashboard.
