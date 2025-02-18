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

  3.1 the result will return

```
Add this entry to the credentials of the target environment:

active_record_encryption:
  primary_key: primary_key_xxxxxxxx
  deterministic_key: deterministic_key_xxxxxxxx
  key_derivation_salt: key_derivation_salt_xxxxxx
```
  3.2 after encryption has been generated store value in .env or add to .bashrc or bash you're using

#### for ENV 
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

 > ```bin/dev```

### Run the test by

 > ```rspec spec```
