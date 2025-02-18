# Setup Guide

### Base requirement

* ruby-3.3.0

### Set up the base project by 

1. run bundle

 > ```bundle install```

2. run migration

 > ```rails db:migrate```

3. generate encryption key then store in .env file or add to your .bashrc

 > ```bin/rails db:encryption:init```

### Start server

 > ```bin/dev```

### Run the test by

 > ```rspec spec```
