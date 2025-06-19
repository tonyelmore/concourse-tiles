#!/bin/bash

# Download BOSH Releases for Concourse Web Tile
# Run this script from your tile project directory

set -e

# Create resources directory
mkdir -p concourse-web-tile/resources
cd concourse-web-tile/resources

echo "Downloading BOSH releases for Concourse Web tile..."

# 1. Concourse BOSH Release v7.11.2
echo "Downloading Concourse v7.11.2..."
curl -L -o concourse-7.11.2.tgz "https://bosh.io/d/github.com/concourse/concourse-bosh-release?v=7.11.2"
echo "✓ Downloaded concourse-7.11.2.tgz"

# Verify SHA1 (optional but recommended)
CONCOURSE_SHA1=$(shasum -a 1 concourse-7.11.2.tgz | cut -d' ' -f1)
EXPECTED_CONCOURSE_SHA1="c0b566627e3f8890fec9e4ebeea25921a6932d47"
if [ "$CONCOURSE_SHA1" = "$EXPECTED_CONCOURSE_SHA1" ]; then
    echo "✓ Concourse SHA1 verified"
else
    echo "⚠ WARNING: Concourse SHA1 mismatch. Expected: $EXPECTED_CONCOURSE_SHA1, Got: $CONCOURSE_SHA1"
fi

# 2. Postgres BOSH Release v53.0.3 (latest stable)
echo "Downloading Postgres v53.0.3..."
curl -L -o postgres-53.0.3.tgz "https://bosh.io/d/github.com/cloudfoundry/postgres-release?v=53.0.3"
echo "✓ Downloaded postgres-53.0.3.tgz"

# 3. UAA BOSH Release v77.30.0 (latest stable instead of 75.21.0)
echo "Downloading UAA v77.30.0..."
curl -L -o uaa-77.30.0.tgz "https://bosh.io/d/github.com/cloudfoundry/uaa-release?v=77.30.0"
echo "✓ Downloaded uaa-77.30.0.tgz"

# Verify UAA SHA1
UAA_SHA1=$(shasum -a 1 uaa-77.30.0.tgz | cut -d' ' -f1)
EXPECTED_UAA_SHA1="07a3352ef4fb542526390d98e7ca88b78925e1ca"
if [ "$UAA_SHA1" = "$EXPECTED_UAA_SHA1" ]; then
    echo "✓ UAA SHA1 verified"
else
    echo "⚠ WARNING: UAA SHA1 mismatch. Expected: $EXPECTED_UAA_SHA1, Got: $UAA_SHA1"
fi

# 4. CredHub BOSH Release v2.14.2 (latest stable instead of 2.12.70)
echo "Downloading CredHub v2.14.2..."
curl -L -o credhub-2.14.2.tgz "https://bosh.io/d/github.com/pivotal-cf/credhub-release?v=2.14.2"
echo "✓ Downloaded credhub-2.14.2.tgz"

# Verify CredHub SHA1
CREDHUB_SHA1=$(shasum -a 1 credhub-2.14.2.tgz | cut -d' ' -f1)
EXPECTED_CREDHUB_SHA1="a11e05db682b3bd9e60dfa2e60baa1feef2b536e"
if [ "$CREDHUB_SHA1" = "$EXPECTED_CREDHUB_SHA1" ]; then
    echo "✓ CredHub SHA1 verified"
else
    echo "⚠ WARNING: CredHub SHA1 mismatch. Expected: $EXPECTED_CREDHUB_SHA1, Got: $CREDHUB_SHA1"
fi

# 5. Garden-runC BOSH Release v1.70.0 (latest stable, needed for workers)
echo "Downloading Garden-runC v1.70.0..."
curl -L -o garden-runc-1.70.0.tgz "https://bosh.io/d/github.com/cloudfoundry/garden-runc-release?v=1.70.0"
echo "✓ Downloaded garden-runc-1.70.0.tgz"

# Verify Garden-runC SHA1
GARDEN_SHA1=$(shasum -a 1 garden-runc-1.70.0.tgz | cut -d' ' -f1)
EXPECTED_GARDEN_SHA1="9ba797d2e43679b5dd5d05aa0cc67ef2e1b2018b"
if [ "$GARDEN_SHA1" = "$EXPECTED_GARDEN_SHA1" ]; then
    echo "✓ Garden-runC SHA1 verified"
else
    echo "⚠ WARNING: Garden-runC SHA1 mismatch. Expected: $EXPECTED_GARDEN_SHA1, Got: $GARDEN_SHA1"
fi

echo ""
echo "📦 All BOSH releases downloaded successfully!"
echo ""
echo "Downloaded files:"
ls -la *.tgz

echo ""
echo "Next steps:"
echo "1. Update your tile.yml files to use the correct versions and file names"
echo "2. Generate the SHA1 checksums for your tile.yml if needed:"
echo "   shasum -a 1 *.tgz"
echo "3. Build your tile with: docker run --rm -v \$(pwd):/tile cfplatformeng/tile-generator build"