require_relative '../../app/lib/omni_auth_token_verifier'

OmniAuth.config.request_validation_phase = OmniAuthTokenVerifier.new
