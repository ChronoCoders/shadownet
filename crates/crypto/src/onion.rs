use crate::encryption::AesGcmEncryption;
use crate::error::Result;

/// Multi-layer encryption for onion routing.
///
/// Implements Tor-style onion encryption where each relay node can only
/// decrypt its own layer, preventing any single node from seeing both
/// the source and destination of traffic.
pub struct OnionRouter {
    layers: Vec<AesGcmEncryption>,
}


impl Default for OnionRouter {
    fn default() -> Self {
        Self::new()
    }
}

impl OnionRouter {
    /// Creates a new onion router with no encryption layers.
    pub fn new() -> Self {
        Self { layers: Vec::new() }
    }

    /// Adds an encryption layer for a relay hop.
    pub fn add_layer(&mut self, key: &[u8; 32]) {
        self.layers.push(AesGcmEncryption::new(key));
    }

    /// Encrypts data with all layers (client perspective).
    ///
    /// Applies encryption in REVERSE order so the first relay can decrypt
    /// the outermost layer.
    pub fn wrap(&self, data: &[u8]) -> Result<Vec<u8>> {
        let mut result = data.to_vec();

        // CRITICAL: Encrypt in REVERSE order
        for layer in self.layers.iter().rev() {
            result = layer.encrypt(&result)?;
        }

        Ok(result)
    }

    /// Decrypts one layer (relay perspective).
    pub fn unwrap_one(&self, data: &[u8]) -> Result<Vec<u8>> {
        if self.layers.is_empty() {
            return Err(crate::error::CryptoError::EncryptionError(
                "No layers to unwrap".into(),
            ));
        }

        let first = &self.layers[0];
        first.decrypt(data)
    }

    /// Returns the number of encryption layers.
    pub fn layer_count(&self) -> usize {
        self.layers.len()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_onion_encryption_three_hops() {
        // Setup three layers (simulating 3-hop circuit)
        let mut router = OnionRouter::new();

        let key1 = [1u8; 32];
        let key2 = [2u8; 32];
        let key3 = [3u8; 32];

        router.add_layer(&key1);
        router.add_layer(&key2);
        router.add_layer(&key3);

        assert_eq!(router.layer_count(), 3);

        // Client encrypts message
        let message = b"Hello, ShadowNet!";
        let encrypted = router.wrap(message).unwrap();

        // Message should be encrypted (different from original)
        assert_ne!(encrypted.as_slice(), message);

        // Each relay decrypts one layer
        let mut relay1_router = OnionRouter::new();
        relay1_router.add_layer(&key1);
        let after_relay1 = relay1_router.unwrap_one(&encrypted).unwrap();

        let mut relay2_router = OnionRouter::new();
        relay2_router.add_layer(&key2);
        let after_relay2 = relay2_router.unwrap_one(&after_relay1).unwrap();

        let mut relay3_router = OnionRouter::new();
        relay3_router.add_layer(&key3);
        let after_relay3 = relay3_router.unwrap_one(&after_relay2).unwrap();

        // Final message should match original
        assert_eq!(after_relay3.as_slice(), message);
    }

    #[test]
    fn test_single_layer() {
        let mut router = OnionRouter::new();
        let key = [42u8; 32];
        router.add_layer(&key);

        let message = b"Test";
        let encrypted = router.wrap(message).unwrap();
        let decrypted = router.unwrap_one(&encrypted).unwrap();

        assert_eq!(decrypted.as_slice(), message);
    }

    #[test]
    fn test_empty_router_error() {
        let router = OnionRouter::new();
        let data = b"test";

        let result = router.unwrap_one(data);
        assert!(result.is_err());
    }

    #[test]
    fn test_layer_count() {
        let mut router = OnionRouter::new();
        assert_eq!(router.layer_count(), 0);

        router.add_layer(&[1u8; 32]);
        assert_eq!(router.layer_count(), 1);

        router.add_layer(&[2u8; 32]);
        assert_eq!(router.layer_count(), 2);
    }
}
