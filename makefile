BRANCH ?= master
SUBSCRIPTION ?= "jessde"
RG ?= jdk8s-us

.PHONY: local-clean git-clean helm-delete azd-clean

all:
	-make local-clean
	-make git-clean
	-make helm-delete
	make azd-clean

local-clean:
	-kubectx docker-for-desktop
	-helm delete --purge spring-boot-websocket-chat-demo
	-rm -rf charts draft.toml Dockerfile .draftignore .dockerignore .draft-tasks.toml target .classpath .project

# delete-branch: 
# 	-git branch -d $(BRANCH)
# 	-git push origin -d $(BRANCH) && echo "$(branch) branch successfully deleted"
# 	-git fetch --prune

git-clean:
	- git checkout master
	- git branch -D build19
	- git push origin --delete build19
	- rm azure-pipelines.yml
	- git commit -am "reset demo"
	- git push

helm-delete:
	-kubectx jdk8s-us
	-helm delete --purge build19-dev
	-helm delete --purge build19-prod
	-kubectx docker-for-desktop

azd-clean:
	@scripts/azdo-cleanup.sh
azd-clean:
	@scripts/azdo-cleanup.sh
