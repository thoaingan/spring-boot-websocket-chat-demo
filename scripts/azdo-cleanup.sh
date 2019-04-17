#!/bin/bash
set -eou pipefail
source ./scripts/variables.sh

curl -s -u $(presenter):$(PAT) --request DELETE "https://vsrm.dev.azure.com/$(organization)/$(project)/_apis/release/definitions/$(releaseDef)?forceDelete=true&api-version=5.0" | grep 'does not exist' > /dev/null && echo "$(organization) $(project) Release Definition $(releaseDef) has been successfully deleted." || echo "Release definition $(releaseDef) not deleted. Please check your inputs, including your PAT, and try again."

sleep 5

curl -s -u $(presenter):$(PAT) --request DELETE "https://dev.azure.com/$(organization)/$(project)/_apis/build/definitions/$(buildDef)?api-version=5.0" | grep 'was not found' > /dev/null && echo "$(organization) $(project) Build Definition $(buildDef) has been successfully deleted." || echo "Build definition $(buildDef) not deleted. Please check your inputs, including your PAT, and try again."
