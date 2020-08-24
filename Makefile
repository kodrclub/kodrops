#
# Use this to start the dev environment instead of directly running
# $ skaffold dev
#
# This prevents accidentally trying to run skaffold on the wrong context
# (maybe production?!?)
#
SKAFFOLD_CONTEXT ?= "docker-desktop"
CURRENT_CONTEXT := "$(shell kubectl config current-context)"

dev:
ifneq ($(CURRENT_CONTEXT), $(SKAFFOLD_CONTEXT))
	@kubectl config use-context $(SKAFFOLD_CONTEXT)
endif
	@skaffold dev