#!/bin/bash
set -eou pipefail
source ./scripts/variables.sh

releaseAPI="https://vsrm.dev.azure.com/$(organization)/$(project)/_apis/release/definitions/$(releaseDef)?forceDelete=true&api-version=5.0"
buildAPI="https://dev.azure.com/$(organization)/$(project)/_apis/build/definitions/$(buildDef)?api-version=5.0"

curl -s -u $(presenter):$(PAT) --request DELETE $releaseAPI > /dev/null && curl -s -u $(presenter):$(PAT) --request GET $releaseAPI | grep 'does not exist' > /dev/null && echo "$(organization) $(project) Release Definition $(releaseDef) has been successfully deleted." || echo "Release definition $(releaseDef) not deleted. Please check your inputs, including your PAT, and try again."

sleep 5

curl -s -u $(presenter):$(PAT) --request DELETE $buildAPI > /dev/null && curl -s -u $(presenter):$(PAT) --request GET $buildAPI | grep 'was not found' > /dev/null && echo "$(organization) $(project) Build Definition $(buildDef) has been successfully deleted." || echo "Build definition $(buildDef) not deleted. Please check your inputs, including your PAT, and try again."
