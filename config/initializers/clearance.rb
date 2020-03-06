Clearance.configure do |config|
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/book_lists/new"
end
