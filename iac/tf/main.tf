provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "default"
}

resource "kubernetes_secret" "fastapi_secrets" {
  metadata {
    name = "fastapi-secret"
  }

  data = {
    DATABASE_URL = var.DATABASE_URL
    SECRET_KEY   = var.SECRET_KEY
  }

  type = "Opaque"
}

# resource "kubernetes_deployment" "fastapi_app" {
#   metadata {
#     name = "fastapi-app"
#     labels = {
#       app = "fastapi-app"
#     }
    
#   }

#   spec {
#     replicas = 1 

#     selector {
#       match_labels = {
#         app = "fastapi-app"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "fastapi-app"
#         }
#       }

#       spec {
#         container {
#           name  = "fastapi-container"
#           image = "ghcr.io/gnublet/calendar_app:0.1"  
#           port {
#             container_port = 8000
#           }

#         #   env {}
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "fastapi_service" {
#   metadata {
#     name = "fastapi-service"
#   }

#   spec {
#     selector = {
#       app = "fastapi-app"
#     }

#     port {
#       protocol    = "TCP"
#       port        = 80
#       target_port = 8000
#     }

#     type = "LoadBalancer"  # Change to ClusterIP if using Ingress
#   }
# }