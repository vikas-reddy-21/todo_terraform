variable "key_name" {
  description = "Your existing AWS key pair name"
}

variable "github_repo" {
  default     = "https://github.com/vikas-reddy-21/todo_project.git"
  description = "Your GitHub repo HTTPS URL"
}

variable "project_name" {
  default     = "todo_project"
  description = "Your Django project folder name"
}
