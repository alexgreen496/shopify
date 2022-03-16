# Shopify App Store

The Shopify apps marketplace is a source of valuable information on how online shop owners interact with apps and their features. This dbt project transforms raw Shopify app store review data into a model ready for analytics.

### Overview:

- Sources layer, staging layer, intermediate layer (normalised star-schema) and marts layer (denormalised wide-table and metrics) with the necessary dependencies and materialisations.
- Consistent naming guide (snake-case column names, date types, decimal places etc.) and a clearly defined coding style.
- Use of open-source packages, macros and jinja templating for modularity and code efficiency while maintaining readability.
- Detailed documentation and use of generic and singular testing.

### DAG:

![alt text](https://github.com/alexgreen496/shopify-app-store/blob/main/dbt-dag.png?raw=true)

## Data:
The dataset used in this project includes data on Shopify app store apps (created by developers) and reviews (published by shops) and can be accessed here: [ShopifyAppStore](https://www.kaggle.com/usernam3/shopify-app-store)

