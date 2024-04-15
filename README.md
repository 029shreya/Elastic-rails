# README

<!-- This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover: -->

Requirements
	Ruby version: ruby-3.0.0
	Rails version: 7.1.3
	Database: PostgreSQL

Installation Steps
	git clone https://github.com/chdivya495/elastic_rails.git
  cd elastic_rails

Install dependencies:
 bundle install

Database setup:
 rails db:create
 rails db:migrate
 rails db:seed

Run the server:
 rails server

API endpoints are mentioned here: 
 elastic/api_endpoints

Elasticsearch Setup:
 Download Elasticsearch:
 wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.1-amd64.deb
 sudo apt install ./elasticsearch-7.17.1-amd64.deb

Start Elasticsearch service:
 sudo systemctl start elasticsearch

Check Elasticsearch status:
 sudo systemctl status elasticsearch

Data Import to Elasticsearch
 For each model, follow these steps to import data to Elasticsearch:

 1. Create Elasticsearch index:
   Vertical.__elasticsearch__.create_index!
 2. Import data:
   Vertical.import(force: true)
 Repeat the above steps for all models.

Elasticsearch API Links
	Courses Index Search: http://localhost:9200/courses_development/_search
	Verticals Index Search: http://localhost:9200/verticals_development/_search
	Categories Index Search: http://localhost:9200/categories_development/_search
	Get Vertical by ID: http://localhost:9200/verticals_development/_doc/:id