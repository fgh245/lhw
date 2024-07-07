provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# Define a map of Helm releases
locals {
  helm_releases = {
    vote = {
      chart = "../helm/chart/vote/"
      version           = "0.1.0"
    },
    result = {
      chart = "../helm/chart/result/"
      version           = "0.1.0"
    },
    redis = {
      chart = "../helm/chart/redis/"
      version           = "0.1.0"
    },
    db = {
      chart = "../helm/chart/db/"
      version           = "0.1.0"
    },
    worker = {
      chart = "../helm/chart/worker/"
      version           = "0.1.0"
    },
  }
}

# Create helm_release resources using for_each loop
resource "helm_release" "this" {
  dependency_update = true
  force_update      = true
  recreate_pods     = true
  wait              = true
  max_history       = 3
  for_each = local.helm_releases

  name  = each.key
  chart = each.value.chart
  version = each.value.version
}

resource "null_resource" "port_forward_to_vote" {
  depends_on = [helm_release.this]
  provisioner "local-exec" {
    command     = "minikube kubectl port-forward service/vote 8080:80 >/dev/null 2>&1 &"
  }
}

resource "null_resource" "port_forward_to_result" {
  depends_on = [helm_release.this]
  provisioner "local-exec" {
    command     = "minikube kubectl port-forward service/result 8090:80 >/dev/null 2>&1 &"
  }
}

output "vote_app_url" {
  value = "http://localhost:8080/"
}

output "result_app_url" {
  value = "http://localhost:8090/"
}
