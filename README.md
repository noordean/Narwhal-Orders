##  Narwhal Orders

A Shopify app that lists orders that are placed which contain products with the word "narwhal" in them.

### Dependencies & Technologies

- Ruby 2.7.0
- Rails 6.0.3
- Shopify App 13.3.0

### How To Use

- Visit https://nar-whal-orders.herokuapp.com/
- Enter your store link and install

Note: This works only on development stores as this is an unlisted app, and ensure you select `Developer Preview` when creating a new store

### Local Setup

- Clone this repo

- Install Bundler gems

  ```
  cd narwhal-orders
  gem install bundler
  bundle
  ```

- Create a .env and set your secret keys
    ```
    cp .env.example .env
    ```

### Testing

- Specs: `rspec`

### Starting

```
rails s
```
Or install `foreman` and run Procfile to start sidekiq together with the app


Visit http://localhost:3000/
