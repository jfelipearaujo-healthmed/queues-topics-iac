# type 'make help' to visualize the help information

##@ Utility
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

TAG := $(shell git describe --tags --abbrev=0 2>/dev/null)
VERSION := $(shell echo $(TAG) | sed 's/v//')

##@ Developing
tag: ## Create or bump the version tag
	@if [ -z "$(TAG)" ]; then \
        echo "No previous version found. Creating v1.0 tag..."; \
        git tag v1.0; \
    else \
        echo "Previous version found: $(VERSION)"; \
        read -p "Bump major version (M/m) or release version (R/r)? " choice; \
        if [ "$$choice" = "M" ] || [ "$$choice" = "m" ]; then \
            echo "Bumping major version..."; \
			major=$$(echo $(VERSION) | cut -d'.' -f1); \
            major=$$(expr $$major + 1); \
            new_version=$$major.0; \
        elif [ "$$choice" = "R" ] || [ "$$choice" = "r" ]; then \
            echo "Bumping release version..."; \
			release=$$(echo $(VERSION) | cut -d'.' -f2); \
            release=$$(expr $$release + 1); \
            new_version=$$(echo $(VERSION) | cut -d'.' -f1).$$release; \
        else \
            echo "Invalid choice. Aborting."; \
            exit 1; \
        fi; \
        echo "Creating tag for version v$$new_version..."; \
        git tag v$$new_version; \
    fi

##@ Auto generated files
gen-tf-docs: ## Generate Terraform Docs
	@echo "Generating Terraform Docs..."
	@terraform-docs markdown table terraform

gen-cloud-diagrams: ## Generate Cloud Diagrams
	@echo "Generating Cloud Diagrams..."
	@cd docs && python3 cloud_aws_queues_topics.py

##@ Terraform
init:
	@echo "Initializing..."
	@cd terraform \
		&& terraform init -reconfigure

check:
	@echo "Checking..."
	make fmt && make validate && make plan

fmt:
	@echo "Formatting..."
	@cd terraform \
		&& terraform fmt -check

validate:
	@echo "Validating..."
	@cd terraform \
		&& terraform validate

plan:
	@echo "Planning..."
	@cd terraform \
		&& terraform plan -var-file="local.tfvars" -out=plan \
		&& terraform show -json plan > plan.tfgraph

apply:
	@echo "Applying..."
	@cd terraform \
		&& terraform apply plan

destroy:
	@echo "Destroying..."
	@cd terraform \
		&& terraform destroy -auto-approve