This Ruby on Rails application consumes employee data from an external API, stores it in the database, and displays it. The app uses Sidekiq for background jobs to periodically fetch and update employee data. Redis is used as the backend for Sidekiq.

# Features
Fetches employee data from an external API.
Stores employee data in a local database.
Displays a list of employees with details like name, email, address, etc.
Uses Sidekiq to periodically poll the API and refresh the employee data.
Cache API responses for faster access.
UI styled with Tailwind CSS.
Prerequisites
Before running the app, ensure the following are installed on your system:

* Ruby 3.1.3
* Rails 7.0.8
* Redis (for Sidekiq)
# Setup Instructions
  
Follow these steps to get the app up and running:

1. Clone the Repository
```bash
git clone
```
```bash
cd employee-list
```
2. Install Dependencies
```bash
bundle install
```
3. Set Up Environment Variables
At the .env file in the root directory, add your API credentials:

# .env file
```bash
API_CLIENT_ID=your_client_id
API_CLIENT_SECRET=your_client_secret
API_USERNAME=your_username
API_PASSWORD=your_password
API_BASE_URI=https://dev.truthsocial.com/api/v1/assignment
```
4. Set Up the Database
```bash
rails db:create
rails db:migrate
```
5. Precompiling Assets
```bash
rails assets:precompile
```
6. Start the Rails Server
```bash
bin/dev
```
The app should now be running at <a href="http://localhost:3000">http://localhost:3000</a>.

### Schedule the API Polling Job
The app uses the whenever gem to poll the API every 10 minutes for updated employee data. To enable this, you need to ensure that cron is running on your system and update the crontab:
```bash
whenever --update-crontab
```
Make sure the cron service is running:
```bash
sudo service cron start  # For Ubuntu/Debian-based systems
```

Alternative: Instant Database Population
If you prefer to manually populate the database with employee data without waiting for the scheduled job, you can use a rake task. This task allows you to fetch and store employee data immediately.

To run the rake task, use the following command:
```bash
bundle exec rake employees:fetch
```
This will execute the logic to fetch data from the API and store it in the database right away. This is useful for initial setups or when you want to refresh the data on demand.

Notes
The API polling job is scheduled to run every 10 minutes by default.
The app requires Redis and Sidekiq to be running for background job processing.
Ensure your .env file is configured with the correct API credentials and is not committed to version control.
