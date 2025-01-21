#!/bin/bash

# Build the project
cargo build --release --target wasm32-unknown-unknown --package rustWallet_backend

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed. Exiting."
    exit 1
fi

# Extract candid interface from the WASM file
candid-extractor target/wasm32-unknown-unknown/release/rustWallet_backend.wasm > src/rustWallet_backend/rustWallet_backend.did

# Check if candid extraction was successful
if [ $? -ne 0 ]; then
    echo "Candid extraction failed. Exiting."
    exit 1
fi

dfx deploy

echo "Deployment script completed successfully."