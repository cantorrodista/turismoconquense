# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ocr_session',
  :secret      => '8f60cb2ced61d035b06d6373b77b67b6156bbb07030fbb33771e49ce8b813421a1703662eafafb9db5ec651a6b60a2479843bbe2615f4eda3b0bd6529ffbf290'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
