resource "github_repository" "example" {
  name = "${var.repo_name}"
  description = "Example codebase repo"
}

data "github_repository" "example" {
  full_name = "${var.github_organization}/${var.repo_name}"
  depends_on = [github_repository.example]  # <- as  before getting data from
                                            # we need to have it, implicit dep
}

