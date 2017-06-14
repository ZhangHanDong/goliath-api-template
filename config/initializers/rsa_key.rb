RSA_PUBLIC_KEY = OpenSSL::X509::Certificate.new(File.read "#{Goliath.root}/config/demo/pems/public_key.der").public_key


PKCS1_PRIVATE_KEY = OpenSSL::PKey::RSA.new File.read "#{Goliath.root}/config/demo/pems/private_key.pem"
