terraform {
  required_version = ">= 0.12"

  backend "remote" {
    organization = "owenbendavies"

    workspaces {
      name = "howtofixinternet"
    }
  }
}
