resource "github_repository" "example" {
  name = "${var.repo_name}"
  description = "Example codebase repo"
}

data "github_repository" "example" {
  full_name = "${var.github_organization}/${var.repo_name}"
}

