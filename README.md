# Amazon Product Search

This is a tool to find product information from Amazon, given an Amazon product indentification number. It scrapes the required data from the website to return product name, category, dimensions and rank.

# Setup
1. Clone this repository.
2. Run bundle install to install dependencies.
3. Run `bin/rake db:reset` to create and load db.
4. Run `rails s` to start the server.

# Technology choices

The choice for me was between Ruby-On-Rails and Javascrapt with node. Each has its pros and cons. For web scraping, Javascript can take advantage of the language's asynchronous nature which can overcome the blocks like accessing data that isn't rendered until a client-side event is triggered.

Since this app is for demonstration purposes, that wasn't a big deal for me. On the other hand, I could use the power of active record and MVC framework that comes with Rails to quickly spin a server. Personally, I also like Ruby syntax better. For that reason, I chose Ruby-On-Rails.

# Testing

For this app, there is no point in testing the http library. The respective maintainers already do that. This leaves with testing the parsing logic, some basic database interactions and the controller.

* Testing the parsing logic

Since this application uses crawlers to collect information, it is primarily reliant on the external website (that do not share an API) for functionality. In most cases, when the page layout is changed, the crawler stops working. The goal of the tests was to one hand detect that, but on the other, connecting to an external server every time the tests are run is not optimal and lowers network performance.

After doing some research, I found a gem called VCR that did exactly that. It records the test suit's HTTP interactions and replays them during future test runs for fast, deterministic and accurate tests. After the first run, we do not have to connect to the external server.

For VCR, I set the configuration to one month, after which it checks for any change in the website layout.

Another issue I faced was that Amazon uses different layouts with different CSS selectors for different category of products. I tried to account for as many variations as I could. But the database of products listed is enormous and I could not account for all of them. Given more time, I would like to fix that.

For testing, I have tried to use mutually exclusive list of products for better coverage. Tests can be run by simply using `rspec` in the terminal.




