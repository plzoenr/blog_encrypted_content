# Demo

[link to demo website](blog.plzoenr.com)

# Setup Guide

### Base requirement

* ruby-3.3.0

### Set up the base project by 

1. run bundle

 ```bundle install```

2. run migration

 ```rails db:migrate```

3. generate encryption key then store in .env file or add to your .bashrc or any you're using

 ```bin/rails db:encryption:init```

  3.1 the result will return

```
Add this entry to the credentials of the target environment:

active_record_encryption:
  primary_key: primary_key_xxxxxxxx
  deterministic_key: deterministic_key_xxxxxxxx
  key_derivation_salt: key_derivation_salt_xxxxxx
```
  3.2 after encryption has been generated store value in .env or add to .bashrc or bash you're using

#### for .env file
1. create .env file
2. copy the value to the file and replace the value
```
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=primary_key_xxxxxxxx
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=deterministic_key_xxxxxxxx
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=key_derivation_salt_xxxxxx
```

#### for .bashrc or whatever you're using
```
export ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY=primary_key_xxxxxxxx
export ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY=deterministic_key_xxxxxxxx
export ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT=key_derivation_salt_xxxxxx
```

### Start server

 ```bin/dev```

### Run the test by

 ```rspec spec```

### Deploy Flow

1. Push the code to branch main
2. CI will run If the test pass the deploy will automatically deploy to website blog.plzoenr.com

### Can be Implement later

1. Make the main branch as protect branch
2. Then use PR for merge the code to main branch
