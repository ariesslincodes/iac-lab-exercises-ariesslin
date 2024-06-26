terraform {
  backend "remote" {
    organization = "ariesslincodes"

    workspaces {
      name = "ariess-test-workspace"
    }
  }
}
