CREATE TABLE IF NOT EXISTS ip_pool (
    id UUID PRIMARY KEY,
    ip TEXT NOT NULL UNIQUE,
    status TEXT NOT NULL DEFAULT 'available',
    reserved_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ip_pool_status ON ip_pool(status);
CREATE INDEX idx_ip_pool_reserved_until ON ip_pool(reserved_until);

INSERT INTO ip_pool (id, ip) 
SELECT gen_random_uuid(), '192.168.1.' || generate_series(1, 254)
ON CONFLICT (ip) DO NOTHING;