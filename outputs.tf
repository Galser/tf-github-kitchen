output "full_repo_web_path" {
  value = "${data.github_repository.example.html_url}"
}

output "ssh_clone_url" {
  value = "${data.github_repository.example.ssh_clone_url}"
}

output "repo_description" {
  value = "${data.github_repository.example.description}"
}
