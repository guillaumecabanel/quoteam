class GetSslJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # ACME client
    #
    # ACME is part of the Letsencrypt project, which goal is to provide free SSL/TLS
    # certificates with automation of the acquiring and renewal process.
    # (See https://github.com/unixcharles/acme-client)

    # Register client
    # ---------------
    puts "Register client..."
    require 'openssl'

    print "Generate private key..."
    private_key = OpenSSL::PKey::RSA.new(4096)
    puts "OK"

    # We need an ACME server to talk to, see github.com/letsencrypt/boulder
    # WARNING: This endpoint is the production endpoint, which is rate limited and will produce valid certificates.
    # You should probably use the staging endpoint for all your experimentation:
    # Staging:     'https://acme-staging.api.letsencrypt.org/'
    # Production:  'https://acme-v01.api.letsencrypt.org/'
    endpoint = ENV['ACME_SERVER']
    puts "# ACME server: Endpoint is set to #{endpoint}"

    # Initialize the client
    require 'acme-client'
    print "Initialize the client..."
    client = Acme::Client.new(private_key: private_key, endpoint: endpoint, connection_options: { request: { open_timeout: 5, timeout: 5 } })
    puts "OK"

    # If the private key is not known to the server, we need to register it for the first time.
    registration = client.register(contact: "mailto:#{ENV['SSL_ACCOUNT_EMAIL']}")

    # You may need to agree to the terms of service (that's up the to the server to require it or not but boulder does by default)
    print "Agreeing terms..."
    registration.agree_terms
    puts "OK"

    # Authorize for domain
    # --------------------
    print "Authorize client..."
    authorization = client.authorize(domain: ENV['DOMAIN'])

    # If authorization.status returns 'valid' here you can already get a certificate
    # and _must not_ try to solve another challenge.
    authorization.status # => 'pending'

    # You can store the authorization's URI to fully recover it and
    # any associated challenges via Acme::Client#fetch_authorization.
    authorization.uri # => '...'

    # This example is using the http-01 challenge type. Other challenges are dns-01 or tls-sni-01.
    challenge = authorization.http01

    # The http-01 method will require you to respond to a HTTP request.

    # You can retrieve the challenge token
    challenge.token # => "some_token"

    # You can retrieve the expected path for the file.
    challenge.filename # => ".well-known/acme-challenge/:some_token"

    # You can generate the body of the expected response.
    challenge.file_content # => 'string token and JWK thumbprint'

    # You are not required to send a Content-Type. This method will return the right Content-Type should you decide to include one.
    challenge.content_type

    # Save the file. We'll create a public directory to serve it from, and inside it we'll create the challenge file.
    FileUtils.mkdir_p( File.join( 'public', File.dirname( challenge.filename ) ) )

    # We'll write the content of the file
    File.write( File.join( 'public', challenge.filename), challenge.file_content )

    # Optionally save the authorization URI for use at another time (eg: by a background job processor)
    File.write('authorization_uri', authorization.uri)

    # The challenge file can be served with a Ruby webserver.
    # You can run a webserver in another console for that purpose. You may need to forward ports on your router.
    #
    # $ ruby -run -e httpd public -p 8080 --bind-address 0.0.0.0

    # Load a challenge based on stored authorization URI. This is only required if you need to reuse a challenge as outlined above.
    challenge = client.fetch_authorization(File.read('authorization_uri')).http01

    # Once you are ready to serve the confirmation request you can proceed.
    challenge.request_verification # => true
    challenge.authorization.verify_status # => 'pending'

    # Wait a bit for the server to make the request, or just blink. It should be fast.
    sleep(1)

    # Rely on authorization.verify_status more than on challenge.verify_status,
    # if the former is 'valid' you can already issue a certificate and the status of
    # the challenge is not relevant and in fact may never change from pending.
    challenge.authorization.verify_status # => 'valid'
    challenge.error # => nil

    # If authorization.verify_status is 'invalid', you can get at the error
    # message only through the failed challenge.
    authorization.verify_status # => 'invalid'
    authorization.http01.error # => {"type" => "...", "detail" => "..."}

    puts "OK"

    # Obtain a certificate
    # --------------------
    # We're going to need a certificate signing request. If not explicitly
    # specified, the first name listed becomes the common name.
    print "Obtain a certificate..."
    names = ENV['DOMAIN_NAMES'].split
    csr = Acme::Client::CertificateRequest.new(names: names)

    # We can now request a certificate. You can pass anything that returns
    # a valid DER encoded CSR when calling to_der on it. For example an
    # OpenSSL::X509::Request should work too.
    certificate = client.new_certificate(csr) # => #<Acme::Client::Certificate ....>

    # Save the certificate and the private key to files
    File.write("privkey.pem", certificate.request.private_key.to_pem)
    File.write("cert.pem", certificate.to_pem)
    File.write("chain.pem", certificate.chain_to_pem)
    File.write("fullchain.pem", certificate.fullchain_to_pem)

    puts "OK"
  end
end

# RegisterClientJob.perform_later
