resource "kubernetes_manifest" "deployment_fastapi_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "fastapi-app"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "fastapi"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "fastapi"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "DATABASE_URL"
                  "value" = "postgresql://app:password@pg-cluster-rw:5432/calendar_db"
                },
              ]
              "image" = "ghcr.io/gnublet/calendar_app:0.1"
              "imagePullPolicy" = "Always"
              "name" = "fastapi"
              "ports" = [
                {
                  "containerPort" = 8000
                },
              ]
            },
          ]
        }
      }
    }
  }
}
