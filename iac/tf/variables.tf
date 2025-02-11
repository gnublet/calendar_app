variable "DATABASE_URL" {
  description = "Database connection URL"
  type        = string
#   sensitive   = true
  default = "postgresql://postgres:example@localhost:5432/calendar_db"
}

variable "DATABASE_USER" {
  description = "Database connection USER"
  type        = string
  default = "app"
}

variable "DATABASE_PASS" {
  description = "Database connection PASS"
  type        = string
  default = "password"
}

variable "DATABASE_HOST" {
  description = "Database connection HOST"
  type        = string
  default = "localhost"
}

variable "DATABASE_PORT" {
  description = "Database connection PORT"
  type        = string
  default = "5432"
}

variable "DATABASE_NAME" {
  description = "Database connection NAME"
  type        = string
  default = "calendar_db"
}

variable "SECRET_KEY" {
  description = "APP Secret KEY"
  type        = string
  default = "your-secret-key-here"
}

variable "ALGORITHM" {
  description = "ALGORITHM"
  type        = string
  default = "HS256"
}

variable "ACCESS_TOKEN_EXPIRE_MINUTES" {
  description = "access token expire minutes"
  type        = string
  default = "30"
}

variable "VERSION" {
  description = "version"
  type        = string
  default = "v1"
}