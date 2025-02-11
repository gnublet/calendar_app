resource "kubernetes_manifest" "service_fastapi_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "fastapi-service"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 8000
          "protocol" = "TCP"
          "targetPort" = 8000
        },
      ]
      "selector" = {
        "app" = "fastapi"
      }
      "type" = "LoadBalancer"
    }
  }
}
